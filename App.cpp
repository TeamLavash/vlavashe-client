/*
 *  App.cpp
 *
 *  Created on: 08 Dec, 2016
 *      Author: Renat
 *
 */

#include "App.hpp"
#include "SQLiteDataBase.hpp"

App::App(QObject *parent) :
	QObject(parent),
	engine(nullptr),
	qmlRoot(nullptr),
	db(nullptr),
	currentUser(nullptr)
{}

App::~App()
{
	delete engine;
	delete qmlRoot;
	delete db;
	delete currentUser;
}

void App::run()
{
	engine = new QQmlApplicationEngine;
	engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
	qmlRoot = engine->rootObjects().first();
	connect(qmlRoot, SIGNAL(qmlSignal), this, SLOT(qmlSlot(QString)));

	db = new SQLiteDataBase;
}

void App::qmlSlot(QString message)
{
	Q_UNUSED(message)
	// TODO
}
