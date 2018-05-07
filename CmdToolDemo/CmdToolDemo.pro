#-------------------------------------------------
#
# Project created by QtCreator 2018-05-07T14:40:03
#
#-------------------------------------------------

QT       += core gui

QMAKE_LFLAGS += /MANIFESTUAC:"level='requireAdministrator'uiAccess='false'"

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = CmdToolDemo
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui
