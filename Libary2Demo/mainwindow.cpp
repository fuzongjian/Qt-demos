#include "mainwindow.h"
#include "ui_mainwindow.h"
//#include "../Library1Demo/library1demo.h"

#include "library1demo.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    Library1Demo library;
    ui->label->setText(library.hello());
}

MainWindow::~MainWindow()
{
    delete ui;
}
