#include "manager.h"
#include <QDebug>
Manager::Manager(QObject *parent) : QObject(parent)
{

}
void Manager::test(){
    qDebug()<<"测试---测试";
}
QString Manager::testString(){
    emit mySignal();
    return "good good study,day day up";
}
