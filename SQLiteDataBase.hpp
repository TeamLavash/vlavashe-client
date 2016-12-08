/*
 *  SQLiteDataBase.hpp
 *
 *  Created on: 08 Dec, 2016
 *      Author: Renat
 *
 */

#ifndef SQLITEDATABASE_HPP
#define SQLITEDATABASE_HPP

#include <QSqlDatabase>
#include <QSqlDriver>
#include <QSqlQuery>
#include "DataBase.hpp"

class SQLiteDataBase : public DataBase
{
public:
	SQLiteDataBase();
	virtual ~SQLiteDataBase();

	bool open(const DBConfig config) override;
	bool close() override;

	const UserLoginResponse login(const UserLoginQuery query) override;
	const UserInfoResponse getUserInfo(const UserInfoQuery query) override;

	const ShawarmaInfoResponse getShawarmaInfo(const ShawarmaInfoQuery query) override;
	const ShawarmaMenuResponse getShawarmaMenu(const ShawarmaInfoQuery query) override;

private:
	QSqlDatabase db;

	QSqlQuery exec(QString query);
};

#endif // SQLITEDATABASE_HPP
