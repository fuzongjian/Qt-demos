import QtQuick 2.0

Item {
    width: 1620
    height: 720
    visible: true
    Rectangle{
        id: displayImage
        anchors.fill: parent
        Image {
            id: image
            width: 1600
            height: 700
            anchors.centerIn: parent
            clip: true
            Image {
               id: display
               //这里使图片居中显示
               x: image.width/2-display.width/2
               y: image.height/2-display.height/2
               source: "../images/soccer_ball.png"
               //图像异步加载，只对本地图像有用
               asynchronous: true
            }
            MouseArea {
               id: mapDragArea
               anchors.fill: display
               drag.target: display
               //这里使图片不管是比显示框大还是比显示框小都不会被拖拽出显示区域
               drag.minimumX: (display.width > image.width) ? (image.width - display.width) : 0
               drag.minimumY: (display.height > image.height) ? (image.height - display.height) : 0
               drag.maximumX: (display.width > image.width) ? 0 : (image.width - display.width)
               drag.maximumY: (display.height > image.height) ? 0 : (image.height - display.height)

               //使用鼠标滚轮缩放
               onWheel: {
                   //每次滚动都是120的倍数
                   var datla = wheel.angleDelta.y/120;
                   if(datla > 0)
                   {
                       display.scale = display.scale/0.9
                   }
                   else
                   {
                       display.scale = display.scale*0.9
                   }
               }
            }
    }
}
}
