#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    unsigned version = avcodec_version();
    qDebug()<<QString::number(version,10);
    qDebug()<<avcodec_configuration();
    ui->textEdit->setText(avcodec_configuration());
}

MainWindow::~MainWindow()
{
    delete ui;
}
