#include "simplethread.h"

SimpleThread::SimpleThread()
{

}
void SimpleThread::run(){
    while(count <= 5){
        count ++;
        if(count == 5){
//            emit well_done();
        }
        qDebug()<<currentThread()<<" id === "<<currentThreadId();
        sleep(5);
    }
}
