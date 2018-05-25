# QT-FFmpeg
### 配置相关
- [下载](https://ffmpeg.zeranoe.com/builds/)
![下载](/images/FFmpeg.png)
- 配置

>1.解压得到三个文件夹，如下

![](/images/FFmpeg-2.png)
>2.项目.pro下面添加路径

```
INCLUDEPATH += C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/include

LIBS += C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavcodec.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavdevice.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavfilter.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavformat.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libavutil.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libswresample.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libswscale.dll.a\
        C:/Users/fuzongjian/Desktop/HK/ffmpeg/dev/lib/libpostproc.dll.a
```
>3. 添加环境变量

`share文件夹下的bin目录添加到环境变量。（需要重启电脑）`

![图片](/images/FFmpeg-1.jpg)
>4. 将share下的bin目录拷贝到debug文件夹中。(不然会报错)

>5.引入ffmpeg头文件

![](/images/FFmpeg-3.jpg)
```
using namespace std;
extern "C"
{
#ifdef __cplusplus
  #define __STDC_CONSTANT_MACROS
  #ifdef _STDINT_H
   #undef _STDINT_H
  #endif
  # include <stdint.h>
#endif
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libswresample/swresample.h>
#include <libavutil/opt.h>
}
```
>6.测试

![](/images/FFmpeg-4.jpg)
### 视频裁剪（代码）
>主要通过QProcess调起cmd进行截取,`需要配置环境变量`
```
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
    ui->textEdit->append("\n");
    ui->textEdit->append(p.readAllStandardOutput());
}
void MainWindow::finish(int state){
    qDebug()<<"hello === "<<state;
}
```
### 图片截取（代码）
```
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
                    ui->label->setPixmap(QPixmap::fromImage(image));
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
```

**[↑回到顶部](#QT-FFmpeg)**
