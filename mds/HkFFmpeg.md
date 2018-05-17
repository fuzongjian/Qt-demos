## QT与FFmpeg相关
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
