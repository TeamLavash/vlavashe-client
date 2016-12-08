/*
 *  User.hpp
 *
 *  Created on: 08 Dec, 2016
 *      Author: Renat
 *
 */

#ifndef USER_HPP
#define USER_HPP

#include <QString>

typedef uint64_t UserId;

enum class UserStatus {
	UNDEFINED = 0,
	COMMON_USER,
	ADMIN
};

struct UserInfo {
	UserId id;

	QString name;
	UserStatus status;

	// TODO add photo
};

class User {
public:
	User();
	virtual ~User() {}

	virtual void setInfo(UserInfo info) = 0;

	virtual const UserInfo getInfo() const = 0;
};

#endif // USER_HPP
