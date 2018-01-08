#include "mainwindow.h"
#include "ui_mainwindow.h"
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    SimpleThread * thread = new SimpleThread();
    // 设置当前线程的名称
    thread->setObjectName("test_thread");
    connect(thread,SIGNAL(started()),this,SLOT(started()));
    connect(thread,SIGNAL(finished()),this,SLOT(finished()));

    connect(thread,SIGNAL(well_done()),this,SLOT(signal_done()));
    thread->start();
}
void MainWindow::started(){
    qDebug()<<"thread started";
}
void MainWindow::finished(){
    qDebug()<<"thread finished";
}
void MainWindow::signal_done(){
    qDebug()<<"well done";
}

MainWindow::~MainWindow()
{
    delete ui;
}
