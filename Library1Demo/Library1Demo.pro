#-------------------------------------------------
#
# Project created by QtCreator 2018-04-06T19:28:36
#
#-------------------------------------------------

QT       -= gui

TARGET = Library1Demo
TEMPLATE = lib

DEFINES += LIBRARY1DEMO_LIBRARY

SOURCES += library1demo.cpp

HEADERS += library1demo.h\
        library1demo_global.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}
