#include "library3demo.h"
#include <QDebug>

Library3Demo::Library3Demo()
{
}
QString Library3Demo::hello(){
    qDebug()<<"hello world";
    return "hello world";
}
