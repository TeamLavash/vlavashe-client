#ifndef DATABASE_HPP
#define DATABASE_HPP

#include <QJsonDocument>
#include "Types.hpp"

class DataBase
{
public:
	virtual ~DataBase() {}

	virtual Message processRequest(Message message) = 0;
};

#endif // DATABASE_HPP
