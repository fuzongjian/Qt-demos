#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QCamera>

#include <QCameraImageCapture>
#include <QCameraViewfinder>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:
    void on_saveBtn_clicked();

private:
    Ui::MainWindow *ui;
    QCamera * mCamera;
    QCameraImageCapture * mCameraImageCapture;
    QVideoWidget * widget;
};

#endif // MAINWINDOW_H
