#ifndef TYPES_HPP
#define TYPES_HPP

#include <QJsonDocument>
#include <QJsonObject>
#include <QObject>

class MessageType : public QObject
{
	Q_OBJECT
public:
	enum T {
		UNDEFINED = 0,
		SHOW_MAP,
		SHOW_PROFILE,
		SHOW_FAVOURITE,
		SHOW_ADD_NEW,
		SHOW_SIGN_UP_SIGN_IN,
		SHOW_SIGN_UP,
		SHOW_SIGN_IN,
		SHOW_COMMENTS,

		SIGN_IN,
		SIGN_UP,
		LOGOUT,

		ADD_NEW_SHAWA,
		SEARCH,
		MORE,
		FAVOURITE_ADD,
		FAVOURITE_REMOVE,
		COMMENT_ADD
	};
	Q_ENUM(T)
};

class MessageResult : public QObject
{
	Q_OBJECT
public:
	enum R {
		OK = 0,
		ERROR
	};
	Q_ENUM(R)
};

class UserType : public QObject
{
	Q_OBJECT
public:
	enum U {
		UNREGISTERED = 0,
		USER,
		ADMIN
	};
	Q_ENUM(U)
};

class Message
{
public:
	Message() :
		type(MessageType::UNDEFINED),
		result(MessageResult::OK)
	{}

	Message(MessageType::T t, QJsonDocument d = QJsonDocument(QJsonObject {}), MessageResult::R r = MessageResult::OK) :
		type(t),
		data(d),
		result(r)
	{}

	bool isOk() const
	{
		return result == MessageResult::OK;
	}

	MessageType::T getType() const
	{
		return type;
	}

	const QJsonDocument &getData() const
	{
		return data;
	}

	MessageResult::R getResult() const
	{
		return result;
	}

private:
	MessageType::T type;
	QJsonDocument data;
	MessageResult::R result;
};

inline Message getResultMessage(MessageType::T type, QString message, bool error = true)
{
	QJsonObject obj {
		{ "result", message }
	};
	return Message(type, QJsonDocument(obj), error ? MessageResult::ERROR : MessageResult::OK);
}

#endif // TYPES_HPP
