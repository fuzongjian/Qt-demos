#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>
#include <QDebug>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
//    ui->imageLabel->setScaledContents(true);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    QString path = QFileDialog::getOpenFileName(this, tr("Open Image"), ".", tr("Image Files(*.jpg *.png)"));
    qDebug()<<path;


    QPixmap pix = QPixmap(path);
    qDebug()<<pix.height()<<pix.width();

//    ui->imageLabel->resize(pix.height(),pix.width());
    ui->imageLabel->setPixmap(pix);
    ui->imageLabel->setScaledContents(true);

}
