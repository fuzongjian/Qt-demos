#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>
#include <windows.h>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

//    setWindowFlags(Qt::FramelessWindowHint);


}
bool MainWindow::enumuserwindowscb(HWND hwnd,LPARAM lParam){
    long wflags = GetWindowLong(hwnd,GWL_STYLE);
    if(!(wflags & WS_VISIBLE))return true;
    HWND sndWnd;
    if(!(sndWnd=FindWindowEx(hwnd,NULL,L"SHELLDLL_DefView",NULL)))return true;
    HWND targetWnd;
    if(!(targetWnd=FindWindowEx(sndWnd,NULL,L"SysListView32",L"FolderView")))return true;
    HWND * resultHwnd = (HWND *)lParam;
    *resultHwnd = targetWnd;
    return false;
}
HWND MainWindow::finddesktopiconwnd(){
    HWND resultHwnd = NULL;
    EnumWindows((WNDENUMPROC)enumuserwindowscb,(LPARAM)&resultHwnd);
    return resultHwnd;
}

void MainWindow::on_pushButton_clicked()
{

}
void MainWindow::on_pushButtonSmall_clicked()
{

}
bool MainWindow::event(QEvent *event){

    if(event->type() == QEvent::KeyPress){

        QKeyEvent *key = static_cast<QKeyEvent *>(event);
        if(key->key() == Qt::Key_Meta){
            qDebug()<<"super === "<<event;
            return false;
        }
    }else if(event->type() == QEvent::KeyRelease){

        QKeyEvent *key = static_cast<QKeyEvent *>(event);
        if(key->key() == Qt::Key_Meta){
             qDebug()<<"super === "<<event;
            return false;
        }
        if(key->key() == Qt::Key_Up){
            return false;
        }else if(key->key() == Qt::Key_Down){
            return false;
        }
    }
    return QMainWindow::event(event);
}

void MainWindow::keyPressEvent(QKeyEvent * event){
//    if(event->modifiers() == Qt::ControlModifier){
//        qDebug()<<"ctrl";
//    }
    qDebug()<<event->modifiers()<<"----"<<event->MetaCall;
    if(event->key() == Qt::Key_Escape){// Esc
        setWindowState(Qt::WindowNoState);
    }else if(event->key() == Qt::Key_F11){// F11
        setWindowState(Qt::WindowFullScreen);
    }else if(event->key() == Qt::Key_Meta && key_win == 0){ // win
        qDebug()<<"----win";
        key_win = event->key();
    }
    if(event->key() == Qt::Key_D && key_d == 0 && key_win != 0){// D
           key_d = event->key();
           qDebug()<<"command+D";
    }


//    if(event->modifiers() == Qt::MetaModifier){
//        qDebug()<<"win";
//        if(event->key() == Qt::Key_D){
//            qDebug()<<"command+D";
//        }
//    }

//    if(event->key() == Qt::Key_Meta){

//        qDebug()<<"----win";
//    }
//    qDebug()<<event<<event->modifiers();


}
void MainWindow::keyReleaseEvent(QKeyEvent * event){
    qDebug()<<"release "<<event;
    if(event->key() == key_win){
        key_win = 0;
    }else if(event->key() == key_d){
        key_d = 0;
    }
}

// 鼠标事件
void MainWindow::mousePressEvent(QMouseEvent * event){
    if(event->button() == Qt::LeftButton){
        qDebug()<<"left button";
    }else if(event->button() == Qt::RightButton){
        qDebug()<<"right button";
    }
}
void MainWindow::mouseReleaseEvent(QMouseEvent * event){
    qDebug()<<"release";
}
void MainWindow::mouseDoubleClickEvent(QMouseEvent * event){

}
void MainWindow::mouseMoveEvent(QMouseEvent * event){
    if(event->buttons() & Qt::LeftButton){
        qDebug()<<"move left button";
    }
}
void MainWindow::wheelEvent(QMouseEvent *event){
    qDebug()<<"wheel move";
}

MainWindow::~MainWindow()
{
    delete ui;
}




