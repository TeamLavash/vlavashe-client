#include <QQuickStyle>
#include <QSettings>
#include "App.hpp"

App::App(int argc, char **argv) :
	QGuiApplication(argc, argv),
	qmlEngine(nullptr),
	qmlRoot(nullptr),
	user(nullptr),
	api(nullptr)
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

	api = new ServerApi(this);
	user = new User(this, api);

	connect(user, &User::messageReady, this, &App::processResponse);
	connect(api, &ServerApi::messageReady,this, &App::processResponse);
}

void App::qmlSlot(int type, QString message)
{
	Message mes(static_cast<MessageType::T>(type), QJsonDocument::fromJson(message.toUtf8()));

	switch (mes.getType()) {
		case MessageType::SHOW_MAP: {
			api->processRequest(mes);
			break;
		}
		case MessageType::SHOW_PROFILE: {
			user->processRequest(mes);
			break;
		}
		case MessageType::SHOW_FAVOURITE: {
			user->processRequest(mes);
			break;
		}
		case MessageType::SHOW_ADD_NEW: {
			user->processRequest(mes);
			break;
		}
		case MessageType::SHOW_SIGN_UP: {
			user->processRequest(mes);
			break;
		}
		case MessageType::SHOW_SIGN_IN: {
			user->processRequest(mes);
			break;
		}
		case MessageType::SIGN_UP: {
			user->processRequest(mes);
			break;
		}
		case MessageType::SIGN_IN: {
			user->processRequest(mes);
			break;
		}
		case MessageType::LOGOUT: {
			user->processRequest(mes);
			break;
		}
		case MessageType::ADD_NEW_SHAWA: {
			user->processRequest(mes);
			break;
		}
		case MessageType::MORE: {
			user->processRequest(mes);
			break;
		}
		case MessageType::FAVOURITE_ADD: {
			user->processRequest(mes);
			break;
		}
		case MessageType::FAVOURITE_REMOVE: {
			user->processRequest(mes);
			break;
		}
		case MessageType::SEARCH: {
			api->processRequest(mes);
			break;
		}
		case MessageType::SHOW_COMMENTS: {
			api->processRequest(mes);
			break;
		}
		case MessageType::COMMENT_ADD: {
			user->processRequest(mes);
			break;
		}
		default: {
			return;
		}
	}
}

void App::processResponse(Message message)
{
	emit cppSignal(message.getType(), message.getData().toJson(), message.getResult());
}
