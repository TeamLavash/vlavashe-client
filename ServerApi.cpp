#include <QNetworkReply>
#include <QNetworkRequest>
#include "ServerApi.hpp"

ServerApi::ServerApi(QObject *parent) :
	QObject(parent)
{
	http = new QNetworkAccessManager(this);
	connect(http, &QNetworkAccessManager::finished, this, &ServerApi::replyFinished);
}

ServerApi::~ServerApi()
{
	delete http;
}

void ServerApi::processRequest(Message message)
{
	QString urlStr = "http://127.0.0.1:5000/";
	switch (message.getType()) {
		case MessageType::SHOW_MAP: {
			if (!lastSearchResult.isNull()) {
				emit messageReady(Message(MessageType::SHOW_MAP, lastSearchResult));
			} else {
				emit messageReady(Message(MessageType::SHOW_MAP));
			}
			return;
		}

		case MessageType::SIGN_UP: {
			urlStr += "sign_up";
			break;
		}
		case MessageType::SIGN_IN: {
			urlStr += "sign_in";
			break;
		}
		case MessageType::SHOW_FAVOURITE: {
			urlStr += "favourite";
			break;
		}
		case MessageType::FAVOURITE_ADD: {
			urlStr += "favourite_add";
			break;
		}
		case MessageType::FAVOURITE_REMOVE: {
			urlStr += "favourite_remove";
			break;
		}
		case MessageType::ADD_NEW_SHAWA: {
			urlStr += "shawa_add";
			break;
		}
		case MessageType::SHOW_COMMENTS: {
			urlStr += "comments";
			break;
		}
		case MessageType::COMMENT_ADD: {
			urlStr += "comment_add";
			break;
		}
		case MessageType::MORE: {
			urlStr += "more";
			break;
		}
		case MessageType::SEARCH: {
			urlStr += "search";
			break;
		}
		default: {
			return;
		}
	}

	QNetworkRequest req;
	req.setUrl(QUrl(urlStr));
	req.setRawHeader("Content-Type", "application/json");
	http->post(req, message.getData().toJson());
}

void ServerApi::replyFinished(QNetworkReply *reply)
{
	QByteArray arr = reply->readAll();
	qDebug() << arr;

	QJsonDocument resp = QJsonDocument::fromJson(arr);
	MessageType::T type = static_cast<MessageType::T>(resp.object()["type"].toInt());
	MessageResult::R result = resp.object()["error"].toBool() ? MessageResult::ERROR : MessageResult::OK;
	QJsonDocument data = QJsonDocument::fromJson(resp.object()["data"].toString().toUtf8());

	Message message(type, data, result);
	emit messageReady(message);
}
