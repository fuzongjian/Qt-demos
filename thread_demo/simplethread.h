#ifndef SIMPLETHREAD_H
#define SIMPLETHREAD_H
#include <QThread>
#include <QDebug>
class SimpleThread : public QThread
{
public:
    SimpleThread();
    // 重写run方法
    void run();
    int count = 0;
};

#endif // SIMPLETHREAD_H