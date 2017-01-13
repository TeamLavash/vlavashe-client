#include "User.hpp"

User::User(QObject *parent, ServerApi *serverApi) :
	QObject(parent),
	api(serverApi),
	userType(UserType::UNREGISTERED)
{
	connect(api, &ServerApi::messageReady, this, &User::processResponse);
}

User::~User()
{}

void User::processRequest(Message message)
{
	switch (message.getType()) {
		case MessageType::SHOW_PROFILE: {
			if (userType != UserType::UNREGISTERED) {
				if (userInfo.isNull()) {
					emit messageReady(getResultMessage(MessageType::SHOW_PROFILE,
													   "Информация о пользователе недоступна."));
				} else {
					emit messageReady(Message(MessageType::SHOW_PROFILE, userInfo));
				}
			} else {
				emit messageReady(Message(MessageType::SHOW_SIGN_UP_SIGN_IN));
			}
			break;
		}
		case MessageType::SHOW_FAVOURITE: {
			if (userType != UserType::UNREGISTERED) {
				if (favourites.isNull()) {
					if (!userInfo.isNull()) {
						QJsonObject req {
							{ "id", userInfo.object()["id"].toInt() }
						};
						api->processRequest(Message(MessageType::SHOW_FAVOURITE, QJsonDocument(req)));
					} else {
						emit messageReady(getResultMessage(MessageType::SHOW_FAVOURITE,
														   "Информация о пользователе недоступна."));
					}
				} else {
					emit messageReady(Message(MessageType::SHOW_FAVOURITE, favourites));
				}
			} else {
				emit messageReady(getResultMessage(MessageType::SHOW_FAVOURITE, "Пользователь неавторизован."));
			}
			break;
		}
		case MessageType::SHOW_ADD_NEW: {
			if (userType == UserType::ADMIN) {
				emit messageReady(Message(MessageType::SHOW_ADD_NEW));
			} else {
				emit messageReady(getResultMessage(MessageType::SHOW_ADD_NEW, "Пользователь неавторизован."));
			}
			break;
		}
		case MessageType::SHOW_SIGN_UP: {
			if (userType == UserType::UNREGISTERED) {
				emit messageReady(Message(MessageType::SHOW_SIGN_UP));
			} else {
				emit messageReady(getResultMessage(MessageType::SHOW_SIGN_UP, "Пользователь уже авторизован."));
			}
			break;
		}
		case MessageType::SHOW_SIGN_IN: {
			if (userType == UserType::UNREGISTERED) {
				emit messageReady(Message(MessageType::SHOW_SIGN_IN));
			} else {
				emit messageReady(getResultMessage(MessageType::SHOW_SIGN_IN, "Пользователь уже авторизован."));
			}
			break;
		}

		case MessageType::SIGN_UP: {
			if (userType == UserType::UNREGISTERED) {
				api->processRequest(message);
			} else {
				emit messageReady(getResultMessage(MessageType::SIGN_UP, "Пользователь уже авторизован."));
			}
			break;
		}
		case MessageType::SIGN_IN: {
			if (userType == UserType::UNREGISTERED) {
				api->processRequest(message);
			} else {
				emit messageReady(getResultMessage(MessageType::SIGN_IN, "Пользователь уже авторизован."));
			}
			break;
		}
		case MessageType::LOGOUT: {
			if (userType != UserType::UNREGISTERED) {
				userType = UserType::UNREGISTERED;
				userInfo = QJsonDocument();
				favourites = QJsonDocument();
				emit messageReady(Message(MessageType::LOGOUT));
			} else {
				emit messageReady(getResultMessage(MessageType::LOGOUT, "Пользователь не авторизован."));
			}
			break;
		}
		case MessageType::FAVOURITE_ADD: {
			if (userType != UserType::UNREGISTERED) {
				if (!userInfo.isNull()) {
					QJsonObject req {
						{ "userId", userInfo.object()["id"].toInt() },
						{ "shawaId", message.getData().object()["id"].toInt() }
					};
					api->processRequest(Message(MessageType::FAVOURITE_ADD, QJsonDocument(req)));
				} else {
					emit messageReady(getResultMessage(MessageType::FAVOURITE_ADD,
													   "Информация о пользователе недоступна."));
				}
			} else {
				emit messageReady(getResultMessage(MessageType::FAVOURITE_ADD, "Пользователь неавторизован."));
			}
			break;
		}
		case MessageType::FAVOURITE_REMOVE: {
			if (userType != UserType::UNREGISTERED) {
				if (!userInfo.isNull()) {
					QJsonObject req {
						{ "userId", userInfo.object()["id"].toInt() },
						{ "shawaId", message.getData().object()["id"].toInt() }
					};
					api->processRequest(Message(MessageType::FAVOURITE_REMOVE, QJsonDocument(req)));
				} else {
					emit messageReady(getResultMessage(MessageType::FAVOURITE_REMOVE,
													   "Информация о пользователе недоступна."));
				}
			} else {
				emit messageReady(getResultMessage(MessageType::FAVOURITE_REMOVE, "Пользователь неавторизован."));
			}
			break;
		}
		case MessageType::ADD_NEW_SHAWA: {
			if (userType == UserType::ADMIN) {
				api->processRequest(message);
			} else {
				emit messageReady(getResultMessage(MessageType::ADD_NEW_SHAWA, "Пользователь неавторизован."));
			}
			break;
		}
		case MessageType::MORE: {
			QJsonObject req {
				{ "userId", userInfo.isNull() ? -1 : userInfo.object()["id"].toInt() },
				{ "shawaId", message.getData().object()["id"].toInt() }
			};
			api->processRequest(Message(MessageType::MORE, QJsonDocument(req)));
			break;
		}
		case MessageType::COMMENT_ADD: {
			if (userType != UserType::UNREGISTERED) {
				if (!userInfo.isNull()) {
					double rating = message.getData().object()["rating"].toDouble();
					QString ratingStr = QString::number(rating, 'g', 2);

					QJsonObject req {
						{ "userId", userInfo.object()["id"].toInt() },
						{ "shawaId", message.getData().object()["id"].toInt() },
						{ "comment", message.getData().object()["comment"].toString() },
						{ "rating", ratingStr.toDouble() }
					};
					api->processRequest(Message(MessageType::COMMENT_ADD, QJsonDocument(req)));
				} else {
					emit messageReady(getResultMessage(MessageType::COMMENT_ADD,
													   "Информация о пользователе недоступна."));
				}
			} else {
				emit messageReady(getResultMessage(MessageType::COMMENT_ADD, "Пользователь не авторизован."));
			}
			break;
		}
		default: {
			emit messageReady(getResultMessage(message.getType(), "Неизвестный запрос."));
			break;
		}
	}
}

void User::processResponse(Message message)
{
	switch (message.getType()) {
		case MessageType::SIGN_IN: {
			if (message.isOk()) {
				userType = static_cast<UserType::U>(message.getData().object()["status"].toInt());
				userInfo = message.getData();
			}
			break;
		}
		case MessageType::FAVOURITE_ADD: {
			if (message.isOk()) {
				favourites = QJsonDocument();
			}
			break;
		}
		case MessageType::FAVOURITE_REMOVE: {
			if (message.isOk()) {
				favourites = QJsonDocument();
			}
			break;
		}
		default: {
			break;
		}
	}
}
