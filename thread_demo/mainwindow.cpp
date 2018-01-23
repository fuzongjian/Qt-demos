#include "mainwindow.h"
#include "ui_mainwindow.h"
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // 第一种方法
    thread = new MyThread();
    // 设置当前线程的名称
    thread->setObjectName("test_thread");
    connect(thread,SIGNAL(started()),this,SLOT(started()));
    connect(thread,SIGNAL(finished()),this,SLOT(finished()));

    connect(thread,SIGNAL(well_done()),this,SLOT(signal_done()));
    thread->start();


    // 第二种方法

    // 动态分配空间，不指定父对象
    mainObject = new MyObject();
    // 创建子线程
    mainThread = new QThread(this);
    // 把自定义的线程加入到子线程中
    mainObject->moveToThread(mainThread);
    connect(mainObject,&MyObject::objectSignal,this,&MainWindow::deal_signals);
    connect(this,&MainWindow::start_thread,mainObject,&MyObject::deal_thread_method);

}
void MainWindow::started(){
    qDebug()<<"1---thread started";
}
void MainWindow::finished(){
    qDebug()<<"1---thread finished";
}
void MainWindow::signal_done(){
    qDebug()<<"1---well done";
}
void MainWindow::deal_signals(){
    qDebug()<<"2---done";
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_startButton_clicked()
{
    if(mainThread->isRunning() == true) return;
    // 启动线程，但是没有启动线程处理函数
    mainThread->start();
    mainObject->setFlag(true);
    // 只能通过 signal - slot 方式调用
    // 原因：直接调用，导致线程处理函数和主线程是在同一个线程
    emit start_thread();
}

void MainWindow::on_stopButton_clicked()
{
    if(mainThread->isRunning() == false) return;
    mainObject->setFlag(false);
    mainThread->quit();
    mainThread->wait();
}
