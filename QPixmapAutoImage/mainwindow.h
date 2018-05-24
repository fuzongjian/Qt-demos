#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QKeyEvent>
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
protected:
    void keyPressEvent(QKeyEvent *);
private:
    Ui::MainWindow *ui;
    QString filePath;
    void updateImage();
};

#endif // MAINWINDOW_H
