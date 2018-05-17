#-------------------------------------------------
#
# Project created by QtCreator 2018-05-17T09:35:12
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = HkFFmpegDemo
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

INCLUDEPATH += C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/include

LIBS += C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavcodec.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavdevice.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavfilter.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavformat.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavutil.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libswresample.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libswscale.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libpostproc.dll.a
