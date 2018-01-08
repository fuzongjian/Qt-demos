#include "simplethread.h"

SimpleThread::SimpleThread()
{

}
void SimpleThread::run(){
    while(true){
        qDebug()<<currentThread();
        sleep(5);
    }
}
