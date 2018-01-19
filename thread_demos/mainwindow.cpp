#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "mythread.h"
#include <QDebug>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    MyThread * thread = new MyThread();
    connect(thread,&MyThread::is_done,this,&MainWindow::thread_done);
    thread->start();
}
void MainWindow::thread_done(){
    qDebug()<<"thread is done";
}

MainWindow::~MainWindow()
{
    delete ui;
}
