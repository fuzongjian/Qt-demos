#include "mythread.h"

MyThread::MyThread(QObject *parent) : QThread(parent)
{

}
void MyThread::run(){
    sleep(5);
    emit is_done();
}

