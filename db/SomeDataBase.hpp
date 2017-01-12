#ifndef SOMEDATABASE_HPP
#define SOMEDATABASE_HPP

#include <QJsonDocument>
#include <QJsonObject>
#include <QMap>
#include <QVector>
#include "DataBase.hpp"

class SomeDataBase : public DataBase
{
public:
	SomeDataBase();
	~SomeDataBase() override;

	Message processRequest(Message message) override;

private:
	QJsonDocument lastSearchResult;

	QVector<QJsonObject> registered;
	QVector<QJsonObject> shawarmas;
	QMap<int32_t, QVector<int32_t>> favourites;
	QMap<int32_t, QVector<QJsonObject>> comments;

	void init();
	bool findAccountByName(QString name) const;
	bool findAccountByEmail(QString email) const;
	bool findInFavourites(int32_t userId, int32_t shawaId) const;
	bool checkAccountPassword(QString name, QString password) const;
	QJsonObject getUserInfo(QString name) const;
	QJsonObject getShawarmaInfo(int32_t userId, int32_t shawaId) const;
};

#endif // SOMEDATABASE_HPP
