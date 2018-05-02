#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QPushButton>
#include <QPropertyAnimation>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

//    QPushButton button("Animated Button");
//    button.show();

//    QPropertyAnimation animation(&button, "geometry");
//    animation.setDuration(10000);

//    animation.setKeyValueAt(0, QRect(0, 0, 100, 30));
//    animation.setKeyValueAt(0.8, QRect(250, 250, 100, 30));
//    animation.setKeyValueAt(1, QRect(0, 0, 100, 30));

//    animation.start();
}

MainWindow::~MainWindow()
{
    delete ui;
}
