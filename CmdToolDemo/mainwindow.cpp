#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QProcess>
#include <QDebug>
#include <QMessageBox>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

}
void MainWindow::test1(){

    ui->textEdit->append("net start mysql");

    QProcess p(0);
    p.start("cmd",QStringList()<<"/c"<<"C:\\Users\\fuzongjian\\Desktop\\1\\mysql_stop_uninstall.bat");
    p.waitForStarted();
    p.waitForFinished();
    QString strTemp=QString::fromLocal8Bit(p.readAllStandardOutput());
    ui->textEdit->append(strTemp);


}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_startButton_clicked()
{
    test1();
}

void MainWindow::on_stopButton_clicked()
{

}
