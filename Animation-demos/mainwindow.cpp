#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QPushButton>
#include <QPropertyAnimation>
#include <QDesktopWidget>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

// 下坠效果
// 通过计算桌面的宽度、高度，来设置动画的起始和结束值
void MainWindow::on_pushButton_clicked()
{
    QPropertyAnimation *pAnimation = new QPropertyAnimation(this,"geometry");
    QDesktopWidget *pDesktopWidget = QApplication::desktop();
    int x = (pDesktopWidget->availableGeometry().width() - width())/ 2;
    int y = (pDesktopWidget->availableGeometry().height() - height())/ 2;

    pAnimation->setDuration(1000);
    pAnimation->setStartValue(QRect(x,0,width(),height()));
    pAnimation->setEndValue(QRect(x,y,width(),height()));
    pAnimation->setEasingCurve(QEasingCurve::OutElastic);
    pAnimation->start(QAbstractAnimation::DeleteWhenStopped);
}
// 抖动效果
// 获取界面的坐标，然后进行上下左右坐标移动，通过setKeyValueAt()来设置每个时刻的位置
void MainWindow::on_pushButton_3_clicked()
{
    QPropertyAnimation * pAnimation = new QPropertyAnimation(this,"pos");
    pAnimation->setDuration(500);
    pAnimation->setLoopCount(1);
    pAnimation->setKeyValueAt(0,QPoint(geometry().x()-3,geometry().y()-3));
    pAnimation->setKeyValueAt(0.1, QPoint(geometry().x() + 6, geometry().y() + 6));
    pAnimation->setKeyValueAt(0.2, QPoint(geometry().x() - 6, geometry().y() + 6));
    pAnimation->setKeyValueAt(0.3, QPoint(geometry().x() + 6, geometry().y() - 6));
    pAnimation->setKeyValueAt(0.4, QPoint(geometry().x() - 6, geometry().y() - 6));
    pAnimation->setKeyValueAt(0.5, QPoint(geometry().x() + 6, geometry().y() + 6));
    pAnimation->setKeyValueAt(0.6, QPoint(geometry().x() - 6, geometry().y() + 6));
    pAnimation->setKeyValueAt(0.7, QPoint(geometry().x() + 6, geometry().y() - 6));
    pAnimation->setKeyValueAt(0.8, QPoint(geometry().x() - 6, geometry().y() - 6));
    pAnimation->setKeyValueAt(0.9, QPoint(geometry().x() + 6, geometry().y() + 6));
    pAnimation->setKeyValueAt(1, QPoint(geometry().x() - 3, geometry().y() - 3));
    pAnimation->start(QAbstractAnimation::DeleteWhenStopped);
}
// 透明效果
void MainWindow::on_pushButton_2_clicked()
{
    QPropertyAnimation *pAnimation = new QPropertyAnimation(this,"windowOpacity");
    pAnimation->setDuration(1000);
    pAnimation->setKeyValueAt(0,1);
    pAnimation->setKeyValueAt(0.5,0);
    pAnimation->setKeyValueAt(1,1);
    pAnimation->start(QAbstractAnimation::DeleteWhenStopped);
}
MainWindow::~MainWindow()
{
    delete ui;
}


