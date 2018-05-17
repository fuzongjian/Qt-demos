### 内存相关
#### 介绍
```
   Qt内存管理机制: Qt在内部能够维护对象的层次结构。对于对于可视元素，这种层次结构就是自组件和子组件的关系；
对于非可视元素，则是一个对象与另一个对象的从属关系。在Qt中，删除父对象会将子对象一起删除。
```
#### 半自动化的内存管理
- QObject及其派生类的对象，如果其parent非0，那么其parent析构时会析构该对象。
- QWidget及其派生类的对象，可以设置Qt::WA_DeleteOnClose标志位（当close时会析构该对象）
- QAbstractAnimation派生类的对象，可以设置QAbstractAnimation::DeleteWhenStopped.
- QRunnable::setAutoDelete()、MediaSource::setAutoDelete().
- 父子关系：父对象、子对象、父子关系。这是Qt中所特有的，与类的继承关系无关，传递参数是与parent有关。
 （基类、派生类、或父类、子类，这是对于派生体系来说的，与parent无关。）


 #### eg
 - 1
 ```
 void MainWindow::on_pushButton_clicked()
{
    QLabel * label = new QLabel("hello Qt!");
    label->show();
}
 ```
 `问题`
 ```
 label既没有指定parent，也没有对其调用delete，会造成内存泄漏。（指针内存问题）
 ```
 `解决方法`
 > 1、分配对象在栈上而不是堆上。
  ```
    QLabel label("hello memory!");
    label.show();
  ```
 > 2、设置标志位，close（）后会delete label
 ```
  QLabel * label = new QLabel("hello Qt!");
  label->show();
  label->setAttribute(Qt::WA_DeleteOnClose);
 ```
 > 3、new后手动delete
 ```
 label->deleteLater();
 ```

 - 2
 ```
 int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QLabel label("hello memory!");
    label.show();
    label.setAttribute(Qt::WA_DeleteOnClose);

    return a.exec();
}
 ```
 `问题：`程序崩溃，因为label被close时，delete &label;但label对象是在栈上分配的内存，delete栈上地址会出错。

- 3
```
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QLabel label("hello memory!");
    QWidget w;
    label.setParent(&w);
    w.show();

    return a.exec();
}
```
  `问题：`当关闭w的时候会崩溃。Object内部有一个list，会保存children，还有一个指针保存parent，当自己析构时，
  会自己从parent列表中删除并且析构所有的children。w比label先被析构，当w被析构时，会删除children列表中的对象label，
  但label是分配到栈上，因delete栈上的对象会出错。

  `解决方法`
  >1、调整一下顺序，确保label先于其parent被析构，label析构时将自己从父对象的类表中移除自己，w析构时，
  children列表中就不会有分配在stack中的对象了。

    ```
    int main(int argc, char *argv[])
    {
        QApplication a(argc, argv);

        QWidget w;
        QLabel label("hello memory!");

        label.setParent(&w);
        w.show();

        return a.exec();
    }
    ```

  >2、将label分配到堆上。

  ```
    int main(int argc, char *argv[])
    {
      QApplication a(argc, argv);

      QWidget w;
      QLabel * label = new QLabel("hello memory!");
      label->setParent(&w);
      w.show();
      return a.exec();

      //或者
      QLabel *label = new QLabel("Hello Qt!",this);
    }
    ```


- 4（野指针）
```
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QWidget * w = new QWidget;
    QLabel * label = new QLabel("hello memory!");
    label->setParent(w);
    w->show();
    delete w;
    label->setText("hello world");

    return a.exec();
}
```
`问题：`程序异常结束，delete w时会delete label，label成为了野指针（label指向了已经删除的对象）。

- 5(deleteLater)
```
QObject的deleteLater()函数，会让所有事件都发送完，一切处理好后马上清除这片内存，而且就算调用多次也不会有问题。
```
