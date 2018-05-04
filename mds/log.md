### 项目生成日志文件
[TOC]
### 方法定义
```
// 日志生成
void LogOutTxt(QtMsgType type,const QMessageLogContext &context,const QString &msg){
#ifndef _DEBUG
    // 保证debug模式正常输出
    cout << msg.toStdString() << endl;
#endif
    mutex.lock();
    QString typeTxt;
    switch (type) {
    case QtDebugMsg:
         typeTxt = QString("Debug: "); // 调试信息
         break;
     case QtInfoMsg:
         typeTxt = QString("Info: ");
         break;
     case QtWarningMsg:
         typeTxt = QString("Warning: "); // 警告
         break;
     case QtCriticalMsg:
         typeTxt = QString("Critical: "); // 严重错误
         break;
     case QtFatalMsg:
         typeTxt = QString("Fatal: ");// 致命错误
         abort();
    default:
        break;
    }
    QString context_info = QString("File: (%1) Line:(%2)").arg(QString(context.file)).arg(context.line);
    QString current_time = QString("(%1)").arg( QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss ddd"));
    QString log = QString("%1 %2 %3\r\n%4").arg(typeTxt).arg(context_info).arg(current_time).arg(msg);

    QFile file;
    QString path = QString("log%1.txt").arg(timePoint);
    file.setFileName(path);
    if(!file.open(QIODevice::ReadWrite  | QIODevice::Append)){
        QString erinfo = file.errorString();
        cout << erinfo.toStdString() << endl;
        return;
    }
    QTextStream out(&file);
    out << "\r\n" << log;
    file.flush();
    file.close();
    mutex.unlock();
}
```
### 方法调用
```
int main(int argc, char *argv[])
{

#ifndef _DEBUG
    timePoint = QDateTime::currentDateTime().toString("yyyyMMddHHmmss");
    qInstallMessageHandler(LogOutTxt);
#endif
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    // 测试
    qDebug("This is a debug message");
    qWarning("This is a warning message");
    qCritical("This is a critical message");
    return a.exec();
}
```
### 遇到问题
`问题`
```
Release中输入日志的文件信息和行数为空
```
`原因`
```
Debug版本是可以输出日志信息的，而Release中输入日志的文件信息和行数为空。
原因是：Qt在Release版本默认舍弃了文件信息、行数等信息
```
`解决方案：Pro文件定义一个宏，然后qmake，最后在编译即可`
```
DEFINES += QT_MESSAGELOGCONTEXT

```
### 最终结果
![日志输出](/images/log.png)
