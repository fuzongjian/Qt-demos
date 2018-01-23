#include "mythread.h"

MyThread::MyThread(QObject *parent) : QThread(parent)
{
    count = 0;
}
void MyThread::run(){
    while (count <=  5) {
       count ++;
       if(count == 5){
           emit well_done();
       }
       sleep(2);
    }
}
