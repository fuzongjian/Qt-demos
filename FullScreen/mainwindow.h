#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QEvent>
#include <QMouseEvent>
#include <QKeyEvent>
#include <windows.h>
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
    void on_pushButton_clicked();

    void on_pushButtonSmall_clicked();

private:
    Ui::MainWindow *ui;
    // 鼠标
    void mousePressEvent(QMouseEvent *);
    void mouseReleaseEvent(QMouseEvent *);
    void mouseDoubleClickEvent(QMouseEvent *);
    void mouseMoveEvent(QMouseEvent *);
    void wheelEvent(QMouseEvent *);
    bool event(QEvent *event);
    // 键盘
    void keyPressEvent(QKeyEvent *);
    void keyReleaseEvent(QKeyEvent *);
    // 组合键 win+d
    int key_win = 0,key_d = 0;

    static bool enumuserwindowscb(HWND hwnd,LPARAM lParam);   //静态全局函数
    HWND finddesktopiconwnd();
};

#endif // MAINWINDOW_H
