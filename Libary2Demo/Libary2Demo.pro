#-------------------------------------------------
#
# Project created by QtCreator 2018-04-06T20:21:07
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = Libary2Demo
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h \
    library1demo.h

FORMS    += mainwindow.ui

# 如果不把 .dll文件放在此文件夹中的话，需要如下的配置
#LIBS    += -LE:\fuzongjian\code\Qt-demos\build-Library1Demo-Desktop_Qt_5_7_0_MinGW_32bit-Debug\debug -lLibrary1Demo

# 把 .dll文件放到程序的文件中，需要进行如下配置，并将两个.h文件合并，同时也要讲 .dll文件放在debug或release文件中
LIBS    += E:\fuzongjian\code\Qt-demos\Libary2Demo\Library1Demo.dll
