#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "simplethread.h"
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    SimpleThread * thread = new SimpleThread();
    connect(thread,SIGNAL(started()),this,SLOT(started()));
    thread->start();
}
void MainWindow::started(){
    qDebug()<<"started";
}
void MainWindow::finished(){

}

MainWindow::~MainWindow()
{
    delete ui;
}
