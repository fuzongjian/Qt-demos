#-------------------------------------------------
#
# Project created by QtCreator 2018-01-08T08:49:48
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = thread_demo
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    simplethread.cpp

HEADERS  += mainwindow.h \
    simplethread.h

FORMS    += mainwindow.ui
