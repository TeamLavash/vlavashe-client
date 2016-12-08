/*
 *  DataBase.hpp
 *
 *  Created on: 08 Dec, 2016
 *      Author: Renat
 *
 */

#ifndef DATABASE_HPP
#define DATABASE_HPP

#include "Shawarma.hpp"
#include "User.hpp"

enum class DBType {
	UNDEFINED = 0,
	SQLITE
};

struct DBConfig {
	QString host;
	QString dbName;
	QString user;
	QString password;
};

struct ShawarmaInfoQuery {
	QString parameters;
};

struct ShawarmaInfoResponse {
	QList<ShawarmaInfo> infos;
};

struct ShawarmaMenuQuery {
	ShawarmaId id;
};

struct ShawarmaMenuResponse {
	Menu menu;
};

// TODO add ext queries and responses

struct UserLoginQuery {
	QString name;
	QString password;
};

struct UserLoginResponse {
	UserId id;
};

struct UserInfoQuery {
	UserId id;
};

struct UserInfoResponse {
	UserInfo info;
};

class DataBase
{
public:
	DataBase() {}
	virtual ~DataBase() {}

	virtual bool open(const DBConfig config) = 0;
	virtual bool close() = 0;

	virtual const UserLoginResponse login(const UserLoginQuery query) = 0;
	virtual const UserInfoResponse getUserInfo(const UserInfoQuery query) = 0;

	virtual const ShawarmaInfoResponse getShawarmaInfo(const ShawarmaInfoQuery query) = 0;
	virtual const ShawarmaMenuResponse getShawarmaMenu(const ShawarmaInfoQuery query) = 0;
};

#endif // DATABASE_HPP
