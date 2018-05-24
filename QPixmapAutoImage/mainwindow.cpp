#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>
#include <QDebug>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

//

    // 必须要加上这句，否则不显示
    ui->widget->setAutoFillBackground(true);

}
void MainWindow::updateImage(){
    if(filePath.isEmpty())return;
    QPixmap pix(filePath);
    qDebug()<<"image-size === "<<pix.size()<<" widget-size === "<<ui->widget->size();
    ui->widget->scaleX = (float)ui->widget->width() / (float)pix.width();
    ui->widget->scaleY = (float)ui->widget->height() / (float)pix.height();
    qDebug()<<ui->widget->scaleX<<ui->widget->scaleY;
    // 放大
//    if(pix.size().width() < ui->widget->size().width()){

//
//    }else{
//        ui->widget->scaleX = 1.0;
//        ui->widget->scaleY = 1.0;
//    }
    pix = pix.scaled(ui->widget->size(),Qt::IgnoreAspectRatio,Qt::SmoothTransformation);
    qDebug()<<pix.size();
    QPalette palette;
    palette.setBrush(QPalette::Window,QBrush(pix));
    qDebug()<<palette;
    ui->widget->setPalette(palette);



//    ui->widget->update();
}
void MainWindow::keyPressEvent(QKeyEvent *event){
    if(event->key() == Qt::Key_F11){
        ui->widget->setPalette(QPalette());
        setWindowState(Qt::WindowFullScreen);
        updateImage();

    }else if(event->key() == Qt::Key_Escape){
         ui->widget->setPalette(QPalette());
        setWindowState(Qt::WindowNoState);
        updateImage();

    }
}

void MainWindow::on_pushButton_clicked()
{

    QString path = QFileDialog::getOpenFileName(this,tr("图片选择"),"",tr("Images(*.png *.jpg)"));
    if(path.isEmpty())return;
    filePath = path;
    updateImage();
}

MainWindow::~MainWindow()
{
    delete ui;
}
