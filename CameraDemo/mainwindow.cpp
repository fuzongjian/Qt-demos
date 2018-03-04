#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QDebug>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // 设置窗口大小
    this->resize(600,400);

    camera = new QCamera();
    cameraViewFinder = new QCameraViewfinder();
    cameraImageCapture = new QCameraImageCapture(camera);

    captureBtn = new QPushButton();
    saveBtn = new QPushButton();
    exitBtn = new QPushButton();

    displayLabel = new QLabel();
    displayLabel->setFixedSize(160, 120);
    //打开自动平衡收放图片，显示图像大小，自动调节为QLabel的大小。
    displayLabel->setScaledContents(true);
    //部件垂直布局
    QVBoxLayout *rightLayout = new QVBoxLayout;
    rightLayout->addWidget(displayLabel);
    rightLayout->addStretch();
    rightLayout->addWidget(captureBtn);
    rightLayout->addWidget(saveBtn);
    rightLayout->addWidget(exitBtn);
    //部件水平布局
    QHBoxLayout *mainLayout = new QHBoxLayout;
    mainLayout->addWidget(cameraViewFinder);
    mainLayout->addLayout(rightLayout);

    connect(captureBtn, SIGNAL(clicked()), this, SLOT(captureBtnResponded()));
    connect(saveBtn, SIGNAL(clicked()), this, SLOT(saveBtnResponded()));
    connect(exitBtn, SIGNAL(clicked()), this, SLOT(exitBtnResponded()));
    connect(cameraImageCapture, SIGNAL(imageCaptured(int,QImage)), this,
            SLOT(cameraImageCaptured(int,QImage)));

    cameraImageCapture->setCaptureDestination(QCameraImageCapture::CaptureToFile);
    camera->setCaptureMode(QCamera::CaptureStillImage);
    camera->setViewfinder(cameraViewFinder);
    camera->start();//启动摄像头

    /*QVBoxLayout *layout = new QVBoxLayout;
       layout->addWidget(formWidget);
       setLayout(layout);
    */
    this->setLayout(mainLayout);/*必须执行这句代码才显现出布局*/
    this->translateLanguage();
}
void MainWindow::translateLanguage(){
    qDebug()<<"hello world";
    this->setWindowTitle(tr("testCapture"));
    captureBtn->setText(tr("capture"));
    saveBtn->setText(tr("save"));
    exitBtn->setText(tr("exit"));
}
void MainWindow::captureBtnResponded(){
    cameraImageCapture->capture();
}

void MainWindow::saveBtnResponded(){
    const QPixmap *pixmap = displayLabel->pixmap();
    if(pixmap) {pixmap->save("D:\\a.jpg");}
}
void MainWindow::exitBtnResponded(){
    camera->stop();
    this->close();
}
void MainWindow::cameraImageCaptured(int id, QImage image){
    displayLabel->setPixmap(QPixmap::fromImage(image));
}

MainWindow::~MainWindow()
{
    delete ui;
}
