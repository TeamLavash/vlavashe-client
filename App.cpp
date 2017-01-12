#include <QDebug>
#include <QQuickStyle>
#include <QSettings>
#include "App.hpp"
#include "db/SomeDataBase.hpp"

App::App(int argc, char **argv) :
	QGuiApplication(argc, argv),
	qmlEngine(nullptr),
	qmlRoot(nullptr),
	user(nullptr),
	db(nullptr)
{
	setApplicationName("VLavashe");
	setOrganizationName("TeamLavash");
}

App::~App()
{}

void App::init()
{
	qmlRegisterType<MessageType>("TypeEnum", 1, 0, "Type");
	qmlRegisterType<MessageResult>("ResultEnum", 1, 0, "Result");
	qmlRegisterType<UserType>("UserEnum", 1, 0, "User");

	QSettings settings;
	QString style = QQuickStyle::name();
	if (!style.isEmpty()) {
		settings.setValue("style", style);
	} else {
		QQuickStyle::setStyle(settings.value("style").toString());
	}

	qmlEngine = new QQmlApplicationEngine;
	qmlEngine->load(QUrl("qrc:/main.qml"));

	qmlRoot = qmlEngine->rootObjects().first();
	connect(qmlRoot, SIGNAL(qmlSignal(int, QString)), this, SLOT(qmlSlot(int, QString)));
	connect(this, SIGNAL(cppSignal(QVariant, QVariant, QVariant)),
			qmlRoot, SLOT(cppSlot(QVariant, QVariant, QVariant)));

	db = new SomeDataBase();
	user = new User(db);
}

void App::qmlSlot(int type, QString message)
{
	Message mes(static_cast<MessageType::T>(type), QJsonDocument::fromJson(message.toUtf8()));

	Message resp;
	switch (mes.getType()) {
		case MessageType::SHOW_MAP: {
			resp = db->processRequest(mes);
			break;
		}
		case MessageType::SHOW_PROFILE: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::SHOW_FAVOURITE: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::SHOW_ADD_NEW: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::SHOW_SIGN_UP: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::SHOW_SIGN_IN: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::SIGN_UP: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::SIGN_IN: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::LOGOUT: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::ADD_NEW_SHAWA: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::MORE: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::FAVOURITE_ADD: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::FAVOURITE_REMOVE: {
			resp = user->processRequest(mes);
			break;
		}
		case MessageType::SEARCH: {
			resp = db->processRequest(mes);
			break;
		}
		case MessageType::SHOW_COMMENTS: {
			resp = db->processRequest(mes);
			break;
		}
		case MessageType::COMMENT_ADD: {
			resp = user->processRequest(mes);
			break;
		}
		default: {
			return;
		}
	}
	emit cppSignal(resp.getType(), resp.getData().toJson(), resp.getResult());
}
