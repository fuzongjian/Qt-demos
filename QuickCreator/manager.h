#ifndef MANAGER_H
#define MANAGER_H

#include <QObject>

class Manager : public QObject
{
    Q_OBJECT
public:
    explicit Manager(QObject *parent = 0);
    Q_INVOKABLE void test();
    Q_INVOKABLE QString testString();
signals:
    void mySignal();
public slots:
};

#endif // MANAGER_H
