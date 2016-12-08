/*
 *  App.hpp
 *
 *  Created on: 08 Dec, 2016
 *      Author: Renat
 *
 */

#ifndef APP_HPP
#define APP_HPP

#include <QObject>
#include <QQmlApplicationEngine>
#include "DataBase.hpp"
#include "Shawarma.hpp"
#include "User.hpp"

class App : public QObject
{
	Q_OBJECT
public:
	explicit App(QObject *parent = 0);
	~App();

	void run();

private:
	QQmlApplicationEngine *engine;
	QObject *qmlRoot;

	DataBase *db;
	User *currentUser;
	QList<Shawarma> shawarmas;

private slots:
	void qmlSlot(QString message);
};

#endif // APP_HPP
