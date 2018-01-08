#include "simplethread.h"

SimpleThread::SimpleThread()
{

}
void SimpleThread::run(){
    while(count <= 5){
        count ++;
        qDebug()<<currentThread()<<" id === "<<currentThreadId();
        sleep(5);
    }
}
