#include <QJsonArray>
#include "SomeDataBase.hpp"

SomeDataBase::SomeDataBase()
{
	init();
}

SomeDataBase::~SomeDataBase()
{}

Message SomeDataBase::processRequest(Message message)
{
	Message resp;

	switch (message.getType()) {
		case MessageType::SHOW_MAP: {
			if (lastSearchResult.isNull()) {
				resp = Message(MessageType::SHOW_MAP);
			} else {
				resp = Message(MessageType::SHOW_MAP, lastSearchResult);
			}
			break;
		}
		case MessageType::SEARCH: {
			QJsonArray arr;
			for (auto it : shawarmas) {
				arr.append(it);
			}
			lastSearchResult = QJsonDocument(arr);
			resp = Message(MessageType::SEARCH, lastSearchResult);
			break;
		}
		case MessageType::SHOW_COMMENTS: {
			int32_t id = message.getData().object()["id"].toInt();

			if (shawarmas.size() <= id) {
				resp = getResultMessage(MessageType::SHOW_COMMENTS, "Shawarma not found.");
			} else {
				QJsonArray arr;
				for (auto it : comments[id]) {
					arr.append(it);
				}

				QJsonObject obj {
					{ "id", id },
					{ "comments", arr }
				};

				resp = Message(MessageType::SHOW_COMMENTS, QJsonDocument(obj));
			}
			break;
		}

		case MessageType::SHOW_FAVOURITE: {
			int32_t id = message.getData().object()["id"].toInt();
			if (registered.size() > id) {
				QJsonArray arr;
				for (auto it : favourites[id]) {
					arr.append(shawarmas.at(it));
				}
				resp = Message(MessageType::SHOW_FAVOURITE, QJsonDocument(arr));
			} else {
				resp = getResultMessage(MessageType::SHOW_FAVOURITE, "User not found.");
			}
			break;
		}
		case MessageType::SIGN_UP: {
			QString name = message.getData().object()["name"].toString();
			QString email = message.getData().object()["email"].toString();
			QString pass1 = message.getData().object()["password"].toString();
			QString pass2 = message.getData().object()["checkPassword"].toString();

			if (pass1 != pass2) {
				resp = getResultMessage(MessageType::SIGN_UP, "Passwords are not equal.");
			} else if (findAccountByName(name)) {
				resp = getResultMessage(MessageType::SIGN_UP, "User name is already registered.");
			} else if (findAccountByEmail(email)) {
				resp = getResultMessage(MessageType::SIGN_UP, "Email is already registered.");
			} else {
				QJsonObject user {
					{ "id", registered.size() },
					{ "name", name },
					{ "email", email },
					{ "password", pass1 },
					{ "status", UserType::USER }
				};
				registered.append(user);
				favourites[user["id"].toInt()];

				resp = getResultMessage(MessageType::SIGN_UP, "You have successfully registered.", false);
			}
			break;
		}
		case MessageType::SIGN_IN: {
			QString name = message.getData().object()["name"].toString();
			QString pass = message.getData().object()["password"].toString();

			if (!findAccountByName(name)) {
				resp = getResultMessage(MessageType::SIGN_IN, "User not registered.");
			} else if (!checkAccountPassword(name, pass)) {
				resp = getResultMessage(MessageType::SIGN_IN, "Wrong password.");
			} else {
				QJsonObject info = getUserInfo(name);
				resp = Message(MessageType::SIGN_IN, QJsonDocument(info));
			}
			break;
		}
		case MessageType::FAVOURITE_ADD: {
			int32_t userId = message.getData().object()["userId"].toInt();
			int32_t shawaId = message.getData().object()["shawaId"].toInt();

			if (registered.size() <= userId) {
				resp = getResultMessage(MessageType::FAVOURITE_ADD, "User not found.");
			} else if (shawarmas.size() <= shawaId) {
				resp = getResultMessage(MessageType::FAVOURITE_ADD, "Shawarma not found.");
			} else if (findInFavourites(userId, shawaId)) {
				resp = getResultMessage(MessageType::FAVOURITE_ADD, "Shawarma already in favourites.");
			} else {
				favourites[userId].append(shawaId);
				resp = getResultMessage(MessageType::FAVOURITE_ADD, "Shawarma added to favourites.", false);
			}
			break;
		}
		case MessageType::FAVOURITE_REMOVE: {
			int32_t userId = message.getData().object()["userId"].toInt();
			int32_t shawaId = message.getData().object()["shawaId"].toInt();

			if (registered.size() <= userId) {
				resp = getResultMessage(MessageType::FAVOURITE_REMOVE, "User not found.");
			} else if (shawarmas.size() <= shawaId) {
				resp = getResultMessage(MessageType::FAVOURITE_REMOVE, "Shawarma not found.");
			} else if (!findInFavourites(userId, shawaId)) {
				resp = getResultMessage(MessageType::FAVOURITE_REMOVE, "Shawarma is not in favourites.");
			} else {
				favourites[userId].removeAll(shawaId);
				resp = getResultMessage(MessageType::FAVOURITE_REMOVE, "Shawarma removed from favourites.", false);
			}
			break;
		}
		case MessageType::ADD_NEW_SHAWA: {
			QJsonObject data = message.getData().object();

			QJsonObject shawa {
				{ "id", shawarmas.size() },
				{ "name", data["name"].toString() },
				{ "road", data["road"].toString() },
				{ "house", data["house"].toString() },
				{ "x", data["x"].toString().toDouble() },
				{ "y", data["y"].toString().toDouble() },
				{ "rating", 0.0 },
				{ "rateCount", 0 },
				{ "price", data["price"].toInt() }
			};
			shawarmas.append(shawa);
			comments[shawa["id"].toInt()];

			resp = getResultMessage(MessageType::ADD_NEW_SHAWA, "Shawarma added.", false);
			break;
		}
		case MessageType::MORE: {
			int32_t userId = message.getData().object()["userId"].toInt();
			int32_t shawaId = message.getData().object()["shawaId"].toInt();

			if (shawarmas.size() > shawaId) {
				QJsonObject info = getShawarmaInfo(userId, shawaId);
				resp = Message(MessageType::MORE, QJsonDocument(info));
			} else {
				resp = getResultMessage(MessageType::MORE, "Shawarma not found.");
			}
			break;
		}
		case MessageType::COMMENT_ADD: {
			int32_t userId = message.getData().object()["userId"].toInt();
			int32_t shawaId = message.getData().object()["shawaId"].toInt();
			QString comment = message.getData().object()["comment"].toString();
			double rating = message.getData().object()["rating"].toDouble();

			if (registered.size() <= userId) {
				resp = getResultMessage(MessageType::COMMENT_ADD, "User not found.");
			} else if (shawarmas.size() <= shawaId) {
				resp = getResultMessage(MessageType::COMMENT_ADD, "Shawarma not found.");
			} else {
				QJsonObject obj {
					{ "user", registered[userId]["name"].toString() },
					{ "comment", comment },
					{ "rating", rating }
				};
				comments[shawaId].append(obj);

				QJsonObject shawaInfo = shawarmas[shawaId];
				double avRating = shawaInfo["rating"].toDouble() + rating / (shawaInfo["rateCount"].toInt() + 1);
				QJsonObject newInfo = {
					{ "id", shawaInfo["id"].toInt() },
					{ "name", shawaInfo["name"].toString() },
					{ "road", shawaInfo["road"].toString() },
					{ "house", shawaInfo["house"].toString() },
					{ "x", shawaInfo["x"].toDouble() },
					{ "y", shawaInfo["y"].toDouble() },
					{ "rating", QString::number(avRating, 'g', 2).toDouble() },
					{ "rateCount", shawaInfo["rateCount"].toInt() + 1 },
					{ "price", shawaInfo["price"].toInt() }
				};
				shawarmas[shawaId] = newInfo;

				QJsonObject r {
					{ "id", shawaId }
				};
				resp = processRequest(Message(MessageType::SHOW_COMMENTS, QJsonDocument(r)));
			}
			break;
		}
		default: {
			resp = getResultMessage(message.getType(), "Unknown request.");
			break;
		}
	}

	return resp;
}

bool SomeDataBase::findAccountByName(QString name) const
{
	for (auto it : registered) {
		if (it["name"].toString() == name) {
			return true;
		}
	}
	return false;
}

bool SomeDataBase::findAccountByEmail(QString email) const
{
	for (auto it : registered) {
		if (it["email"].toString() == email) {
			return true;
		}
	}
	return false;
}

bool SomeDataBase::findInFavourites(int32_t userId, int32_t shawaId) const
{
	return favourites[userId].count(shawaId) > 0;
}

bool SomeDataBase::checkAccountPassword(QString name, QString password) const
{
	for (auto it: registered) {
		if (it["name"].toString() == name) {
			return it["password"] == password;
		}
	}
	return false;
}

QJsonObject SomeDataBase::getUserInfo(QString name) const
{
	for (auto it : registered) {
		if (it["name"].toString() == name) {
			return it;
		}
	}
	return QJsonObject();
}

QJsonObject SomeDataBase::getShawarmaInfo(int32_t userId, int32_t shawaId) const
{
	QJsonObject info = shawarmas.at(shawaId);

	if (userId != -1) {
		info.insert("favourite", findInFavourites(userId, shawaId));
	} else {
		info.insert("favourite", false);
	}
	return info;
}

void SomeDataBase::init()
{
	QJsonObject usr1 {
		{ "id", 0 },
		{ "name", "admin" },
		{ "email", "admin@admin.com" },
		{ "password", "admin" },
		{ "status", UserType::ADMIN }
	};
	QJsonObject usr2 {
		{ "id", 1 },
		{ "name", "user" },
		{ "email", "user@user.com" },
		{ "password", "user" },
		{ "status", UserType::USER }
	};
	registered.push_back(usr1);
	registered.push_back(usr2);

	QJsonObject shawa1 {
		{ "id", 0 },
		{ "name", "Shawa 1" },
		{ "road", "Address" },
		{ "house", "1" },
		{ "x", 59.924501 },
		{ "y", 30.409750 },
		{ "rating", 1.5 },
		{ "rateCount", 3 },
		{ "price", 100 }
	};
	QJsonObject shawa2 {
		{ "id", 1 },
		{ "name", "Shawa 2" },
		{ "road", "Address" },
		{ "house", "2" },
		{ "x", 59.824501 },
		{ "y", 30.309750 },
		{ "rating", 2.5 },
		{ "rateCount", 3 },
		{ "price", 200 }
	};
	QJsonObject shawa3 {
		{ "id", 2 },
		{ "name", "Shawa 3" },
		{ "road", "Address" },
		{ "house", "3" },
		{ "x", 59.724501 },
		{ "y", 30.209750 },
		{ "rating", 3.5 },
		{ "rateCount", 3 },
		{ "price", 300 }
	};
	shawarmas.append(shawa1);
	shawarmas.append(shawa2);
	shawarmas.append(shawa3);
	favourites[1].append(0);
	favourites[1].append(1);
	favourites[1].append(2);

	QJsonObject comment1 {
		{ "user", "User1" },
		{ "comment", "Meh." },
		{ "rating", 1.5 }
	};
	QJsonObject comment2 {
		{ "user", "User2" },
		{ "comment", "Meh.[2]" },
		{ "rating", 1.5 }
	};
	QJsonObject comment3 {
		{ "user", "User3" },
		{ "comment", "Meh.[3]" },
		{ "rating", 1.5 }
	};
	QVector<QJsonObject> coms;
	coms.append(comment1);
	coms.append(comment2);
	coms.append(comment3);

	comments[0] = coms;
	comments[1] = coms;
	comments[2] = coms;
}
