/*
 *  Main.cpp
 *
 *  Created on: 01 Dec, 2016
 *      Author: Renat
 *
 */

#include <QGuiApplication>
#include "App.hpp"

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	App a;
	a.run();

	return app.exec();
}
