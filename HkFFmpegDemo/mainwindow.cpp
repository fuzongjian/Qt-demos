#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QThread>
#include <QPainter>
#include <QFileDialog>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    unsigned version = avcodec_version();
    qDebug()<<QString::number(version,10);
    qDebug()<<avcodec_configuration();


//    ffmpegMethod();
//    ffmpegMethod_2();
//    clipVideo();

    av_register_all(); //初始化FFMPEG  调用了这个才能正常使用编码器和解码器
    avformat_network_init(); //支持打开网络文件

    if (SDL_Init(SDL_INIT_AUDIO)) {
        fprintf(stderr,"Could not initialize SDL - %s. \n", SDL_GetError());
        exit(1);
    }

    mPlayer = new VideoPlayer;
    connect(mPlayer,SIGNAL(sig_GetOneFrame(QImage)),this,SLOT(slotGetOneFrame(QImage)));
    connect(mPlayer,SIGNAL(sig_TotalTimeChanged(qint64)),this,SLOT(slotTotalTimeChanged(qint64)));
    connect(mPlayer,SIGNAL(sig_StateChanged(VideoPlayer::PlayerState)),this,SLOT(slotStateChanged(VideoPlayer::PlayerState)));


    mTimer = new QTimer; //定时器-获取当前视频时间
    connect(mTimer,SIGNAL(timeout()),this,SLOT(slotTimerTimeOut()));
    mTimer->setInterval(500);

    connect(ui->pushButton_open_2,SIGNAL(clicked()),this,SLOT(slotBtnClick()));
    connect(ui->pushButton_play_2,SIGNAL(clicked()),this,SLOT(slotBtnClick()));
    connect(ui->pushButton_pause_2,SIGNAL(clicked()),this,SLOT(slotBtnClick()));
    connect(ui->pushButton_stop_2,SIGNAL(clicked()),this,SLOT(slotBtnClick()));

    connect(ui->horizontalSlider_2,SIGNAL(sliderMoved(int)),this,SLOT(slotSliderMoved(int)));


}
//void MainWindow::on_pushButton_clicked()
//{
//    QString path = QFileDialog::getOpenFileName(this,"打开播放文件",".","所有文件(*.*)");
//    if(path.isEmpty())return;
//    qDebug()<<path;
////    mPlayer->startPlay(path);
//}
void MainWindow::slotGetOneFrame(QImage image){
    mImage = image;
    update();
}

void MainWindow::paintEvent(QPaintEvent *event){
    QPainter painter(this);
    painter.setBrush(Qt::black);
    painter.drawRect(0, 0, this->width(), this->height()); //先画成黑色

    if (mImage.size().width() <= 0) return;

    ///将图像按比例缩放成和窗口一样大小
    QImage img = mImage.scaled(this->size(),Qt::KeepAspectRatio);

    int x = this->width() - img.width();
    int y = this->height() - img.height();

    x /= 2;
    y /= 2;

    painter.drawImage(QPoint(x,y),img); //画出图像
}
void MainWindow::slotTotalTimeChanged(qint64 uSec)
{
    qint64 Sec = uSec/1000000;

    ui->horizontalSlider_2->setRange(0,Sec);

//    QString hStr = QString("00%1").arg(Sec/3600);
    QString mStr = QString("00%1").arg(Sec/60);
    QString sStr = QString("00%1").arg(Sec%60);

    QString str = QString("%1:%2").arg(mStr.right(2)).arg(sStr.right(2));
    ui->label_totaltime_2->setText(str);

}

void MainWindow::slotSliderMoved(int value)
{
    if (QObject::sender() == ui->horizontalSlider_2)
    {
        mPlayer->seek((qint64)value * 1000000);
    }
}

void MainWindow::slotTimerTimeOut()
{
    if (QObject::sender() == mTimer)
    {

        qint64 Sec = mPlayer->getCurrentTime();

        ui->horizontalSlider_2->setValue(Sec);

    //    QString hStr = QString("00%1").arg(Sec/3600);
        QString mStr = QString("00%1").arg(Sec/60);
        QString sStr = QString("00%1").arg(Sec%60);

        QString str = QString("%1:%2").arg(mStr.right(2)).arg(sStr.right(2));
        ui->label_currenttime_2->setText(str);
    }
}

void MainWindow::slotBtnClick()
{
    if (QObject::sender() == ui->pushButton_play_2)
    {
        mPlayer->play();
    }
    else if (QObject::sender() == ui->pushButton_pause_2)
    {
        mPlayer->pause();
    }
    else if (QObject::sender() == ui->pushButton_stop_2)
    {
        mPlayer->stop(true);
    }
    else if (QObject::sender() == ui->pushButton_open_2)
    {
        QString s = QFileDialog::getOpenFileName(
                   this, "选择要播放的文件",
                    "/",//初始目录
                    "视频文件 (*.flv *.rmvb *.avi *.MP4);; 所有文件 (*.*);; ");
        if (!s.isEmpty())
        {
            s.replace("/","\\");

            mPlayer->stop(true); //如果在播放则先停止

            mPlayer->setFileName(s);

            mTimer->start();

        }
    }

}
void MainWindow::clipVideo(){
    // ffmpeg -ss 00:04:30 -t 00:00:30 -i E:/QT/test.mp4 -vcodec copy -acodec copy E:/QT/2.mp4
    connect(&p,SIGNAL(readyReadStandardOutput()),this,SLOT(process_out()));
    connect(&p,SIGNAL(finished(int)),this,SLOT(finish(int)));
    // 需要配置环境变量
    QString cmd = QString("ffmpeg -ss 00:04:30 -t 00:00:30 -i E:/QT/%1 -vcodec copy -acodec copy E:/QT/%2").arg("test-2.mp4").arg("0.mp4");
    p.start("cmd.exe",QStringList()<<"/c"<<cmd);
    qDebug()<<"write---"<<p.waitForBytesWritten();
    qDebug()<<"wait---"<<p.waitForStarted();
    // 解决 QProcess: destroyed while process still running问题
    if(p.waitForFinished() == false){
        p.kill();
        p.waitForFinished();
    }
}
void MainWindow::process_out(){
    qDebug()<<p.readAllStandardOutput();
}
void MainWindow::finish(int state){
    if(state == 0){
         qDebug()<<"clip success";
    }else{
        qDebug()<<"clip failure";
    }

}

void MainWindow::ffmpegMethod_2(){
    // 视频源文件
    QString mFileName = "E:/QT/test.mp4";
    char *file_path = mFileName.toUtf8().data();

    AVFormatContext *pFormatCtx;
    AVCodecContext *pCodecCtx;
    AVCodec *pCodec;
    AVFrame *pFrame, *pFrameRGB;
    AVPacket *packet;
    uint8_t *out_buffer;

    static struct SwsContext *img_convert_ctx;

    int videoStream, i, numBytes;
    int ret, got_picture;
    //初始化FFMPEG  调用了这个才能正常适用编码器和解码器
    av_register_all();

    //Allocate an AVFormatContext.
    pFormatCtx = avformat_alloc_context();

    if (avformat_open_input(&pFormatCtx, file_path, NULL, NULL) != 0) {
        printf("can't open the file. \n");
        return;
    }
    int MS = (pFormatCtx->duration / AV_TIME_BASE)*1000;
    qDebug()<<"duration === "<<"min === "<<MS/1000/60<<" sec === "<<MS/1000%60;

    if (avformat_find_stream_info(pFormatCtx, NULL) < 0) {
        printf("Could't find stream infomation.\n");
        return;
    }

    videoStream = -1;

    ///循环查找视频中包含的流信息，直到找到视频类型的流
    ///便将其记录下来 保存到videoStream变量中
    ///这里我们现在只处理视频流  音频流先不管他
    for (i = 0; i < pFormatCtx->nb_streams; i++) {
        if (pFormatCtx->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO) {
            videoStream = i;
        }
    }

    // 如果videoStream为-1 说明没有找到视频流
    if (videoStream == -1) {
        printf("Didn't find a video stream.\n");
        return;
    }

    ///查找解码器
    pCodecCtx = pFormatCtx->streams[videoStream]->codec;
    pCodec = avcodec_find_decoder(pCodecCtx->codec_id);

    if (pCodec == NULL) {
        printf("Codec not found.\n");
        return;
    }

    ///打开解码器
    if (avcodec_open2(pCodecCtx, pCodec, NULL) < 0) {
        printf("Could not open codec.\n");
        return;
    }

    pFrame = av_frame_alloc();
    pFrameRGB = av_frame_alloc();

    ///这里我们改成了 将解码后的YUV数据转换成RGB32
    img_convert_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height,
            pCodecCtx->pix_fmt, pCodecCtx->width, pCodecCtx->height,
            AV_PIX_FMT_RGB32, SWS_BICUBIC, NULL, NULL, NULL);

    numBytes = avpicture_get_size(AV_PIX_FMT_RGB32, pCodecCtx->width,pCodecCtx->height);

    out_buffer = (uint8_t *) av_malloc(numBytes * sizeof(uint8_t));
    avpicture_fill((AVPicture *) pFrameRGB, out_buffer, AV_PIX_FMT_RGB32,
            pCodecCtx->width, pCodecCtx->height);

    int y_size = pCodecCtx->width * pCodecCtx->height;

    packet = (AVPacket *) malloc(sizeof(AVPacket)); //分配一个packet
    av_new_packet(packet, y_size); //分配packet的数据

    av_dump_format(pFormatCtx, 0, file_path, 0); //输出视频信息

    int index = 0;
    while (1)
    {
        // 读取码流中的音频若干帧或视频一帧的压缩数据
        if (av_read_frame(pFormatCtx, packet) < 0)
        {
            break; //这里认为视频读取完了
        }

        if (packet->stream_index == videoStream) {
            // 解码一帧数据
            ret = avcodec_decode_video2(pCodecCtx, pFrame, &got_picture,packet);
            if (ret < 0) {
                printf("decode error.\n");
                return;
            }

            if (got_picture) {
                // 处理图像数据
                sws_scale(img_convert_ctx,
                        (uint8_t const * const *) pFrame->data,
                        pFrame->linesize, 0, pCodecCtx->height, pFrameRGB->data,
                        pFrameRGB->linesize);

                //把这个RGB数据 用QImage加载
                QImage tmpImg((uchar *)out_buffer,pCodecCtx->width,pCodecCtx->height,QImage::Format_RGB32);
                QImage image = tmpImg.copy(); //把图像复制一份 传递给界面显示
                if(index < 10){
//                    ui->label->setPixmap(QPixmap::fromImage(image));//发送信号
                    QString imageName = QString::number(++index) + ".jpg";
                    image.save(imageName,"jpg");
                }

            }
        }
        av_free_packet(packet);
    }
    av_free(out_buffer);
    av_free(pFrameRGB);
    avcodec_close(pCodecCtx);
    avformat_close_input(&pFormatCtx);
}


MainWindow::~MainWindow()
{
    delete ui;
}


