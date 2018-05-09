# Qt-demos

[1. 日志输出](https://github.com/fuzongjian/Qt-demos/blob/master/mds/log.md)

[2. 内存相关](https://github.com/fuzongjian/Qt-demos/blob/master/mds/memory.md)
#### 多线程的使用
- 创建线程类，继承QThread
- 重写run方法
- 主线程中创建线程对象，使用start（）方法启动线程
- 线程开始和结束会发送信号started（）和finished（），可以使用isFinshed()和isRunning()查询线程状态。

#### QLineEdit相关方法的使用
- [参考文档](http://blog.csdn.net/liang19890820/article/details/52044639)
