#-------------------------------------------------
#
# Project created by QtCreator 2018-04-08T14:28:29
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = Library4Demo
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES += main.cpp

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/release/ -lLibrary3Demo
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/debug/ -lLibrary3Demo
else:unix: LIBS += -L$$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/ -lLibrary3Demo

INCLUDEPATH += $$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/debug
DEPENDPATH += $$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/debug

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/release/libLibrary3Demo.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/debug/libLibrary3Demo.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/release/Library3Demo.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/debug/Library3Demo.lib
else:unix: PRE_TARGETDEPS += $$PWD/../build-Library3Demo-Desktop_Qt_5_5_0_MinGW_32bit-Debug/libLibrary3Demo.a
