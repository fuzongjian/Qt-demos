#include "myobject.h"
#include <QThread>
#include <QDebug>
MyObject::MyObject(QObject *parent) : QObject(parent)
{
    flag = false;
}
void MyObject::deal_thread_method(){
    while (flag) {
        emit objectSignal();
        qDebug()<<"2---子线程："<<QThread::currentThread();
    }
}
void MyObject::setFlag(bool status){
    flag = status;
}
