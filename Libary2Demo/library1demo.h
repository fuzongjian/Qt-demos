#ifndef LIBRARY1DEMO_H
#define LIBRARY1DEMO_H
// 这里是把global的文件也放到这个位置 上 //
#include <QtCore/qglobal.h>
#if defined(LIBRARY1DEMO_LIBRARY)
#  define LIBRARY1DEMOSHARED_EXPORT Q_DECL_EXPORT
#else
#  define LIBRARY1DEMOSHARED_EXPORT Q_DECL_IMPORT
#endif
// 这里是把global的文件也放到这个位置 下 //
class LIBRARY1DEMOSHARED_EXPORT Library1Demo
{

public:
    Library1Demo();
    QString hello();
};

#endif // LIBRARY1DEMO_H
