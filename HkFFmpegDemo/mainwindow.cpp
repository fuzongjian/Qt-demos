#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    unsigned version = avcodec_version();
    ui->textEdit->append(QString::number(version,10));
    ui->textEdit->append(avcodec_configuration());

    ffmpegMethod();

}
void MainWindow::ffmpegMethod(){
    // 1、初始化FFmpeg，调用这个才能正常使用编码器和解码器
    av_register_all();
    // 2、需要分配一个AVFormatContext,FFMPEG所有的操作都要通过AVFormatContext来进行
    AVFormatContext * pFormatCtx = avformat_alloc_context();
    // 3、打开视频文件
    char *file_path = "E:/QT/test.mp4";
    avformat_open_input(&pFormatCtx,file_path,NULL,NULL);
    // 4、文件打开成功后就是查询文件中的视频流
    // 循环查找视频中包含的流信息，直到找到视频类型的流（只处理视频流，不处理音频流）
    int isVideo = -1;
    for(int i = 0; i < pFormatCtx->nb_streams; i ++){
        if(pFormatCtx->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO){
            isVideo = i;
        }
    }
    // 5、根据视频流，打开一个解码器来解码
    if(isVideo == -1){return;}
    // 查找解码器
    AVCodecContext *pCodecCtx = pFormatCtx->streams[isVideo]->codec;
    AVCodec * pCodec = avcodec_find_decoder(pCodecCtx->codec_id);
    if(pCodec == NULL){
        qDebug()<<"Codec not found";
        return;
    }
    // 打开解码器
    if(avcodec_open2(pCodecCtx,pCodec,NULL) < 0){
        qDebug()<<"could not open codec";
        return;
    }
     AVFrame *pFrame = av_frame_alloc();
     AVFrame *pFrameRGB = av_frame_alloc();
     AVPicture  pAVPicture;

    avpicture_alloc(&pAVPicture,AV_PIX_FMT_RGB24,pCodecCtx->width,pCodecCtx->height);

     static struct SwsContext *img_convert_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height,
                                                                AV_PIX_FMT_YUV420P, pCodecCtx->width, pCodecCtx->height,
                                                                AV_PIX_FMT_RGB24, SWS_BICUBIC, NULL, NULL, NULL);



     int numBytes = avpicture_get_size(AV_PIX_FMT_RGB24,pCodecCtx->width,pCodecCtx->height);
     uint8_t *out_buffer = (uint8_t *)av_malloc(numBytes * sizeof(uint8_t));
     avpicture_fill((AVPicture *)pFrameRGB,out_buffer,AV_PIX_FMT_RGB24,pCodecCtx->width,pCodecCtx->height);

     int y_size = pCodecCtx->width * pCodecCtx->height;
     // 分配一个packet
     AVPacket *packet = (AVPacket *)malloc(sizeof(AVPacket));
     // 分配packet的数据
     av_new_packet(packet,y_size);
     // 输出视频信息
     av_dump_format(pFormatCtx,0,file_path,0);
     int index = 0,ret,got_picture;
     while (1) {
         if(av_read_frame(pFormatCtx,packet) < 0){
             break;// 这里认为视频读取完
         }
         if(packet->stream_index == isVideo){
            ret = avcodec_decode_video2(pCodecCtx,pFrame,&got_picture,packet);
            if(ret < 0){
                qDebug()<<"decode error";
                return;
            }
            if(got_picture){
                sws_scale(img_convert_ctx,(uint8_t const * const *)pFrame->data,pFrame->linesize,0,pCodecCtx->height,pFrameRGB->data,pFrameRGB->linesize);

                ffmpegSaveImage(pFrameRGB,pCodecCtx->width,pCodecCtx->height,index++);
                if(index > 50) return;
                if(index == 40){
                    QImage image(pAVPicture.data[0],pCodecCtx->width,pCodecCtx->height,QImage::Format_RGB888);

                    qDebug()<<image.size()<<image.save("fuzongjian.jpg","jpg");
                    ui->label->setPixmap(QPixmap::fromImage(image));
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
void MainWindow::ffmpegSaveImage(AVFrame * pframe, int width, int height, int index){
    FILE * pFile;
    char szFilename[32];
    int y;
    // open file
    sprintf(szFilename,"frame%d.jpg",index);
    pFile = fopen(szFilename,"wb");
    if(pFile == NULL){
        qDebug()<<"error";
        return;
    }
    // write header
    fprintf(pFile,"P6 %d %d",width,height);
    // wirte pixel data
    for(y = 0; y < height; y ++){
        fwrite(pframe->data[0]+y*pframe->linesize[0],1,width*3,pFile);
    }
    // close file
    fclose(pFile);

}

MainWindow::~MainWindow()
{
    delete ui;
}
