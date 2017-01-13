#ifndef APP_HPP
#define APP_HPP

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "ServerApi.hpp"
#include "User.hpp"

class App : public QGuiApplication
{
	Q_OBJECT
public:
	explicit App(int argc, char **argv);
	~App();

	void init();

private:
	QQmlApplicationEngine *qmlEngine;
	QObject *qmlRoot;

	User *user;
	ServerApi *api;

private slots:
	void qmlSlot(int type, QString message);
	void processResponse(Message message);

signals:
	void cppSignal(QVariant type, QVariant data, QVariant result);
};

#endif // APP_HPP
