#-------------------------------------------------
#
# Project created by QtCreator 2018-01-19T17:58:28
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = thread_demos
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
<<<<<<< HEAD:thread_demo/thread_demo.pro
    mythread.cpp \
    myobject.cpp

HEADERS  += mainwindow.h \
    mythread.h \
    myobject.h
=======
    mythread.cpp

HEADERS  += mainwindow.h \
    mythread.h
>>>>>>> origin/master:thread_demos/thread_demos.pro

FORMS    += mainwindow.ui
