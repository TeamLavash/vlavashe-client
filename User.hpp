#ifndef USER_HPP
#define USER_HPP

#include <QJsonDocument>
#include <QObject>
#include "ServerApi.hpp"
#include "Types.hpp"

class User : public QObject
{
	Q_OBJECT
public:
	User(QObject *parent, ServerApi *serverApi);
	~User();

	void processRequest(Message message);

private:
	ServerApi *api;

	UserType::U userType;

	QJsonDocument userInfo;
	QJsonDocument favourites;

private slots:
	void processResponse(Message message);

signals:
	void messageReady(Message message);
};

#endif // USER_HPP
