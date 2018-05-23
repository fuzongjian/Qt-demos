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
        mainwindow.cpp \
    videoplayer.cpp

HEADERS  += mainwindow.h \
    videoplayer.h

FORMS    += mainwindow.ui

INCLUDEPATH += $$PWD/ffmpeg/dev/include\
               $$PWD/ffmpeg/SDL2/include

LIBS += $$PWD/ffmpeg/dev/lib/libavcodec.dll.a\
        $$PWD/ffmpeg/dev/lib/libavdevice.dll.a\
        $$PWD/ffmpeg/dev/lib/libavfilter.dll.a\
        $$PWD/ffmpeg/dev/lib/libavformat.dll.a\
        $$PWD/ffmpeg/dev/lib/libavutil.dll.a\
        $$PWD/ffmpeg/dev/lib/libswresample.dll.a\
        $$PWD/ffmpeg/dev/lib/libswscale.dll.a\
        $$PWD/ffmpeg/dev/lib/libpostproc.dll.a\
        $$PWD/ffmpeg/SDL2/lib/x86/SDL2.lib
