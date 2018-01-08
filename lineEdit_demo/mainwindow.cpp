#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    connect(ui->lineEdit,SIGNAL(cursorPositionChanged(int,int)),this,SLOT(position_changed(int,int)));
    connect(ui->lineEdit,SIGNAL(editingFinished()),this,SLOT(finish_edited()));
    connect(ui->lineEdit,SIGNAL(returnPressed()),this,SLOT(pressed_return()));
    connect(ui->lineEdit,SIGNAL(textChanged(QString)),this,SLOT(change_text(QString)));
    connect(ui->lineEdit,SIGNAL(textEdited(QString)),this,SLOT(edit_text(QString)));
}
void MainWindow::position_changed(int oldV, int newV){
    qDebug()<<"oldv=== "<<oldV<<" newV === "<<newV<<"  "<<ui->lineEdit->text();
}
void MainWindow::finish_edited(){
    qDebug()<<"finish_edited";
}
void MainWindow::pressed_return(){
    qDebug()<<"pressed_return";
}
void MainWindow::change_text(QString content){
    qDebug()<<"change_text === "<<content;
}
void MainWindow::edit_text(QString content){
    qDebug()<<"edit_text === "<<content;
}

MainWindow::~MainWindow()
{
    delete ui;
}
