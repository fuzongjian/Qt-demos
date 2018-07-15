#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QQueue>
#include <QDebug>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QQueue<int> Q;// 定义一个int型队列
    qDebug()<<"queue empty: "<<Q.isEmpty();

    for(int i = 0; i < 10; i ++){
        Q.enqueue(i); // 入队
    }
    qDebug()<<"queue empty: "<<Q.isEmpty();
    qDebug()<<"queue size: "<<Q.size();

    for(int i = 0; i < 10; i ++){
        //qDebug()<<"queue last: "<<Q.last();   // 返回队列最后一个元素
        qDebug()<<"queue head: "<<Q.dequeue(); // 出队列，并且返回当前队列第一个元素
    }
    qDebug()<<"queue empty: "<<Q.isEmpty();
    qDebug()<<"queue size: "<<Q.size();
}

MainWindow::~MainWindow()
{
    delete ui;
}
