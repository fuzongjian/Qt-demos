#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

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

private slots:
    void position_changed(int oldV,int newV);
    void finish_edited();
    void pressed_return();
    void change_text(QString);
    void edit_text(QString);
};

#endif // MAINWINDOW_H
