#ifndef SETCOORDINATE_H
#define SETCOORDINATE_H

#include <QWidget>
#include <QPaintEvent>
#include <QKeyEvent>
class SetCoordinate : public QWidget
{
    Q_OBJECT
public:
    explicit SetCoordinate(QWidget *parent = 0);
    QPoint current_point;
    bool isUpdate = false;
    float scaleX = 1.0;
    float scaleY = 1.0;
signals:
protected:
    void paintEvent(QPaintEvent *);
    void mousePressEvent(QMouseEvent *);
public slots:
};

#endif // SETCOORDINATE_H
