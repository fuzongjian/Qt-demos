#include "setcoordinate.h"
#include <QDebug>
#include <QPainter>
SetCoordinate::SetCoordinate(QWidget *parent) : QWidget(parent)
{
    current_point.setX(30);
    current_point.setY(50);
}

void SetCoordinate::mousePressEvent(QMouseEvent *event){
    current_point = event->pos();
    update();
}
void SetCoordinate::paintEvent(QPaintEvent *event){
    qDebug()<<"hello update";
    QWidget::paintEvent(event);
    QPainter painter(this);
    painter.setPen(Qt::green);
    painter.setBrush(Qt::green);

    painter.drawEllipse((float)current_point.x()*scaleX,(float)current_point.y()*scaleY,10,10);
    painter.setPen(Qt::red);
    painter.drawText((float)current_point.x()*scaleX,(float)current_point.y()*scaleY+22,QString::number(10));

    scaleX = 1.0;
    scaleY = 1.0;



}
