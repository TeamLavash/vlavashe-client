#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QtCore/QUrl>
#include "App.hpp"

int main(int argc, char *argv[])
{
	App app(argc, argv);
	app.init();
	return app.exec();
}
