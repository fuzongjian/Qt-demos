#ifndef MYOBJECT_H
#define MYOBJECT_H

#include <QObject>

class MyObject : public QObject
{
    Q_OBJECT
public:
    explicit MyObject(QObject *parent = 0);
    // 线程处理函数
    void deal_thread_method();
    void setFlag(bool);
signals:
    void objectSignal();
private:
   bool flag;
public slots:
};

#endif // MYOBJECT_H
