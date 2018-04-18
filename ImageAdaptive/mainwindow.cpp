#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>
#include <QDebug>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

//    setImageWithPath(":/images/test.png");
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    QString path = QFileDialog::getOpenFileName(this, tr("Open Image"), ".", tr("Image Files(*.jpg *.png)"));
    if (path == NULL)return;
    setImageWithPath(path);


}
void MainWindow::setImageWithPath(QString path){
    QPixmap pix = QPixmap(path);
    qDebug()<<path;
    float width = pix.width(),height = pix.height();
    //宽高比一致
    float scale = width/height;
    width = ui->imageLabel->width();
    height = width/scale;
    if(height > ui->imageLabel->height()){
        float newScale = ui->imageLabel->height()/height;
        width*=newScale;
        height*=newScale;
    }
    ui->imageLabel->resize(width,height);
    pix.scaled(ui->imageLabel->size(),Qt::KeepAspectRatio);

    ui->imageLabel->setPixmap(pix);
    ui->imageLabel->setScaledContents(true);
    // 移动到中心位置
    QPoint center = ui->bgwidget->rect().center();
    ui->imageLabel->move(QPoint(center.x()-width*0.5,center.y()-height*0.5));
}

void MainWindow::resizeEvent(QResizeEvent *event){
    QWidget::resizeEvent(event);
    qDebug()<<"hello world";
}
