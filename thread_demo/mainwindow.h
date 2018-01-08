#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "simplethread.h"
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
    void started();
    void finished();
    void signal_done();

private:
    Ui::MainWindow *ui;
    SimpleThread * thread;
};

#endif // MAINWINDOW_H
