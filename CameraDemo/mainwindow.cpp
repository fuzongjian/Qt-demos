#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // 启动系统摄像头
    mCamera = new QCamera;
    // 用摄像头初始化一个QCameraImageCapture用来截图
    mCameraImageCapture = new QCameraImageCapture(mCamera);
    mCameraImageCapture->setCaptureDestination(QCameraImageCapture::CaptureToFile);
    // 设置摄像头的模式，可以抓取静态图像
    mCamera->setCaptureMode(QCamera::CaptureStillImage);
    // 设置显示的窗体
    mCamera->setViewfinder(ui->viewfinder);
    // 启动摄像头
    mCamera->start();

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_saveBtn_clicked()
{
    // 保存图片
    QString fileName = QFileDialog::getSaveFileName(this,QString::fromLocal8Bit("保存图片"),QDir::currentPath(),tr("Images (*.png *.xpm *.jpg)"));
    mCameraImageCapture->capture(fileName);
}
