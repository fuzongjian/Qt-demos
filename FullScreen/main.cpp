#include "mainwindow.h"
#include <QApplication>
#include <windows.h>
#include <QDebug>
bool enumuserwindowscb(HWND hwnd,LPARAM lParam){
    long wflags = GetWindowLong(hwnd,GWL_STYLE);
    if(!(wflags & WS_VISIBLE))return true;
    HWND sndWnd;
    if(!(sndWnd=FindWindowEx(hwnd,NULL,L"SHELLDLL_DefView",NULL)))return true;
    HWND targetWnd;
    if(!(targetWnd=FindWindowEx(sndWnd,NULL,L"SysListView32",L"FolderView")))return true;
    HWND * resultHwnd = (HWND *)lParam;
    *resultHwnd = targetWnd;
    return false;
}
HWND finddesktopiconwnd(){
    HWND resultHwnd = NULL;
    EnumWindows((WNDENUMPROC)enumuserwindowscb,(LPARAM)&resultHwnd);
    return resultHwnd;
}
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;


    HWND hwnd = finddesktopiconwnd();
    if(hwnd){
        SetParent((HWND)w.winId(),hwnd);
    }
    w.show();
    return a.exec();
}
