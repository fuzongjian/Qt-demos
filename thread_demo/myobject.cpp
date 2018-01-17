#include "myobject.h"
#include <QDebug>
#include <QThread>
MyObject::MyObject(QObject *parent) : QObject(parent)
{

}
void MyObject::start(){
    qDebug()<<"start---";
}

