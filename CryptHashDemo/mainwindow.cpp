#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QCryptographicHash>
#include "encrypttool.h"
#include <QDebug>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_buttonMd5_clicked()
{
    if(ui->lineEdit->text().length() != 0){
        ui->textEdit->append("MD5加密结果：");
        QByteArray byteStr = ui->lineEdit->text().toLatin1();
        QByteArray md5str = QCryptographicHash::hash(byteStr,QCryptographicHash::Md5);
        ui->textEdit->append(md5str.toHex());
    }
}

void MainWindow::on_buttonAes_clicked()
{
    EncryptTool * tool = new EncryptTool();
    // 明文
    char  mingwen[1024] = "ui->lineEdit->text().toStdString()";






    DWORD size = strlen(mingwen);
    char miwen[1024];
    char jiemi[1024];
    // key
    UCHAR key[1024] = "fuzongjian";


    UCHAR *p = key;
    // 初始化
    tool->InitializePrivateKey(16,p);
    // 加密
    tool->OnAesEncrypt((LPVOID)mingwen,size,(LPVOID)miwen);
    // 解密
    tool->OnAesUncrypt((LPVOID)miwen,(DWORD)sizeof(miwen),(LPVOID)jiemi);

    ui->textEdit->append(QString("明文：%1").arg(mingwen));

    ui->textEdit->append(QString("密文：%1---%2").arg(miwen).arg(strlen(miwen)));

    ui->textEdit->append(QString("解密：%1").arg(jiemi));

//    QString miwenStr = QString(QLatin1String(miwen));


    free(tool);
    tool=0;
}
