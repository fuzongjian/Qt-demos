#include "library1demo.h"
#include <QDebug>

Library1Demo::Library1Demo()
{
}
QString Library1Demo::hello(){
    qDebug()<<"hello world";
    return "hello world";
}
