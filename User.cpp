#include "User.hpp"

User::User(DataBase *dataBase) :
	db(dataBase),
	userType(UserType::UNREGISTERED)
{}

User::~User()
{}

Message User::processRequest(Message message)
{
	Message resp;

	switch (message.getType()) {
		case MessageType::SHOW_PROFILE: {
			if (userType != UserType::UNREGISTERED) {
				if (userInfo.isNull()) {
					resp = getResultMessage(MessageType::SHOW_PROFILE, "User info not available.");
				} else {
					resp = Message(MessageType::SHOW_PROFILE, userInfo);
				}
			} else {
				resp = Message(MessageType::SHOW_SIGN_UP_SIGN_IN);
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
						resp = db->processRequest(Message(MessageType::SHOW_FAVOURITE, QJsonDocument(req)));
					} else {
						resp = getResultMessage(MessageType::SHOW_FAVOURITE, "User info not available.");
					}
				} else {
					resp = Message(MessageType::SHOW_FAVOURITE, favourites);
				}
			} else {
				resp = getResultMessage(MessageType::SHOW_FAVOURITE, "Unauthorized user.");
			}
			break;
		}
		case MessageType::SHOW_ADD_NEW: {
			if (userType == UserType::ADMIN) {
				resp = Message(MessageType::SHOW_ADD_NEW);
			} else {
				resp = getResultMessage(MessageType::SHOW_ADD_NEW, "Unauthorized user.");
			}
			break;
		}
		case MessageType::SHOW_SIGN_UP: {
			if (userType == UserType::UNREGISTERED) {
				resp = Message(MessageType::SHOW_SIGN_UP);
			} else {
				resp = getResultMessage(MessageType::SHOW_SIGN_UP, "User is logged in.");
			}
			break;
		}
		case MessageType::SHOW_SIGN_IN: {
			if (userType == UserType::UNREGISTERED) {
				resp = Message(MessageType::SHOW_SIGN_IN);
			} else {
				resp = getResultMessage(MessageType::SHOW_SIGN_IN, "User is logged in.");
			}
			break;
		}

		case MessageType::SIGN_UP: {
			if (userType == UserType::UNREGISTERED) {
				resp = db->processRequest(message);
			} else {
				resp = getResultMessage(MessageType::SIGN_UP, "User is logged in.");
			}
			break;
		}
		case MessageType::SIGN_IN: {
			if (userType == UserType::UNREGISTERED) {
				resp = db->processRequest(message);
				if (resp.isOk()) {
					userType = static_cast<UserType::U>(resp.getData().object()["status"].toInt());
					userInfo = resp.getData();
				}
			} else {
				resp = getResultMessage(MessageType::SIGN_IN, "User is logged in.");
			}
			break;
		}
		case MessageType::LOGOUT: {
			if (userType != UserType::UNREGISTERED) {
				userType = UserType::UNREGISTERED;
				userInfo = QJsonDocument();
				favourites = QJsonDocument();
				resp = Message(MessageType::LOGOUT);
			} else {
				resp = getResultMessage(MessageType::LOGOUT, "User is not logged in.");
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
					resp = db->processRequest(Message(MessageType::FAVOURITE_ADD, QJsonDocument(req)));

					if (resp.isOk()) {
						favourites = QJsonDocument();
					}
				} else {
					resp = getResultMessage(MessageType::FAVOURITE_ADD, "User info not available.");
				}
			} else {
				resp = getResultMessage(MessageType::FAVOURITE_ADD, "Unauthorized user.");
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
					resp = db->processRequest(Message(MessageType::FAVOURITE_REMOVE, QJsonDocument(req)));

					if (resp.isOk()) {
						favourites = QJsonDocument();
					}
				} else {
					resp = getResultMessage(MessageType::FAVOURITE_REMOVE, "User info not available.");
				}
			} else {
				resp = getResultMessage(MessageType::FAVOURITE_REMOVE, "Unauthorized user.");
			}
			break;
		}
		case MessageType::ADD_NEW_SHAWA: {
			if (userType == UserType::ADMIN) {
				resp = db->processRequest(message);
			} else {
				resp = getResultMessage(MessageType::ADD_NEW_SHAWA, "Unauthorized user.");
			}
			break;
		}
		case MessageType::MORE: {
			QJsonObject req {
				{ "userId", userInfo.isNull() ? -1 : userInfo.object()["id"].toInt() },
				{ "shawaId", message.getData().object()["id"].toInt() }
			};
			resp = db->processRequest(Message(MessageType::MORE, QJsonDocument(req)));
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
					resp = db->processRequest(Message(MessageType::COMMENT_ADD, QJsonDocument(req)));
				} else {
					resp = getResultMessage(MessageType::COMMENT_ADD, "User info not available.");
				}
			} else {
				resp = getResultMessage(MessageType::COMMENT_ADD, "Unauthorized user.");
			}
			break;
		}
		default: {
			resp = getResultMessage(message.getType(), "Unknown request");
			break;
		}
	}

	return resp;
}
