/*
 *  SQLiteDataBase.cpp
 *
 *  Created on: 08 Dec, 2016
 *      Author: Renat
 *
 */

#include "SQLiteDataBase.hpp"

SQLiteDataBase::SQLiteDataBase() :
	DataBase()
{}

SQLiteDataBase::~SQLiteDataBase()
{
	close();
}

bool SQLiteDataBase::open(const DBConfig config)
{
	db = QSqlDatabase::addDatabase("SQLITE");
	db.setHostName(config.host);
	db.setDatabaseName(config.dbName);
	db.setUserName(config.user);
	db.setPassword(config.password);

	return db.open();
}

bool SQLiteDataBase::close()
{
	db.close();
	return true;
}

const UserLoginResponse SQLiteDataBase::login(const UserLoginQuery query)
{
	Q_UNUSED(query)
	// TODO
}

const UserInfoResponse SQLiteDataBase::getUserInfo(const UserInfoQuery query)
{
	Q_UNUSED(query)
	// TODO
}

const ShawarmaInfoResponse SQLiteDataBase::getShawarmaInfo(const ShawarmaInfoQuery query)
{
	Q_UNUSED(query)
	// TODO
}

const ShawarmaMenuResponse SQLiteDataBase::getShawarmaMenu(const ShawarmaInfoQuery query)
{
	Q_UNUSED(query)
	// TODO
}

QSqlQuery SQLiteDataBase::exec(QString query)
{
	return db.exec(query);
}
