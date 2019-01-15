#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "manager.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //4个参数的含义是：包名、主版本号、此版本号、QML类型名
    qmlRegisterType<Manager>("MainManager.module",1,0,"CommonManager");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
