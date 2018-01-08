#include "simplethread.h"

SimpleThread::SimpleThread()
{

}
void SimpleThread::run(){
    while(count <= 5){
        count ++;
        qDebug()<<currentThread()<<" id === "<<currentThreadId();
        if(count == 5){
            emit well_done();
        }
        sleep(5);
    }
}
