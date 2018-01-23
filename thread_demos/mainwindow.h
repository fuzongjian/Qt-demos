#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
<<<<<<< HEAD:thread_demo/mainwindow.h
#include "mythread.h"
#include <QThread>
#include <QDebug>
#include "myobject.h"
=======

>>>>>>> origin/master:thread_demos/mainwindow.h
namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
<<<<<<< HEAD:thread_demo/mainwindow.h
    void deal_signals();
    void deal_close();
private slots:
    void started();
    void finished();
    void signal_done();

    void on_startButton_clicked();

    void on_stopButton_clicked();

private:
    Ui::MainWindow *ui;
    MyThread * thread;
    QThread * mainThread;
    MyObject * mainObject;
signals:
   void start_thread();// 启动子线程的信号
=======
    void thread_done();
private:
    Ui::MainWindow *ui;
>>>>>>> origin/master:thread_demos/mainwindow.h
};

#endif // MAINWINDOW_H
