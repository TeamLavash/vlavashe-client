#ifndef USER_HPP
#define USER_HPP

#include <QJsonDocument>
#include "db/DataBase.hpp"
#include "Types.hpp"

class User
{
public:
	User(DataBase *dataBase);
	~User();

	Message processRequest(Message message);

private:
	DataBase *db;

	UserType::U userType;

	QJsonDocument userInfo;
	QJsonDocument favourites;
};

#endif // USER_HPP
