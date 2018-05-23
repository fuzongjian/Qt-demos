#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QDebug>
#include <stdio.h>
#include <QProcess>
#include <QPaintEvent>
#include "videoplayer.h"
#include <QImage>
#include <QTimer>
using namespace std;
extern "C"
{
#ifdef __cplusplus
  #define __STDC_CONSTANT_MACROS
  #ifdef _STDINT_H
   #undef _STDINT_H
  #endif
  # include <stdint.h>
#endif
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libswscale/swscale.h>
#include <libavutil/pixfmt.h>
}


namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    void ffmpegMethod_2();
    void clipVideo();
    QProcess p;

    VideoPlayer * mPlayer;// 播放线程
    QImage mImage; // 记录当前的图像
    QTimer *mTimer; //定时器-获取当前视频时间
private slots:
    void process_out();
    void finish(int);
    void slotGetOneFrame(QImage);
private slots:

    void slotTotalTimeChanged(qint64 uSec);

    void slotSliderMoved(int value);

    void slotTimerTimeOut();

    void slotBtnClick();

protected:
    void paintEvent(QPaintEvent *);
};

#endif // MAINWINDOW_H
