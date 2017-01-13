#ifndef SERVERAPI_HPP
#define SERVERAPI_HPP

#include <QJsonDocument>
#include <QNetworkAccessManager>
#include "Types.hpp"

class ServerApi : public QObject
{
	Q_OBJECT
public:
	ServerApi(QObject *parent = 0);
	~ServerApi();

	void processRequest(Message message);

private:
	QNetworkAccessManager *http;

	QJsonDocument lastSearchResult;

private slots:
	void replyFinished(QNetworkReply *reply);

signals:
	void messageReady(Message message);
};

#endif // SERVERAPI_HPP
