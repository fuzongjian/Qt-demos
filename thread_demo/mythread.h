#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QThread>

class MyThread : public QThread
{
    Q_OBJECT
public:
    explicit MyThread(QObject *parent = 0);

signals:
    void well_done();
private:
    void run();
    int count;
public slots:
};

#endif // MYTHREAD_H
