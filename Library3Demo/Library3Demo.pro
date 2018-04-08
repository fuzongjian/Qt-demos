#-------------------------------------------------
#
# Project created by QtCreator 2018-04-08T14:11:54
#
#-------------------------------------------------

QT       -= gui

TARGET = Library3Demo
TEMPLATE = lib
CONFIG += staticlib

SOURCES += library3demo.cpp

HEADERS += library3demo.h
unix {
    target.path = /usr/lib
    INSTALLS += target
}
