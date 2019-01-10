import QtQuick 2.0

Image{
    source: "../images/background.png"
    Image{
        x: 40; y: 40
        source: "../images/rocket.png"
        NumberAnimation on x{
            to: 240
            duration: 4000
            loops: Animation.Infinite
        }
        RotationAnimation on rotation{
            to: 360
            duration: 4000
            loops: Animation.Infinite
        }
    }

}
/*
  PropertyAnimation属性动画（使用属性值改变播放的动画）
  NumberAnimation数字动画（使用数字改变播放的动画）
  ColorAnimation颜色动画（使用颜色改变播放的动画）
  RotationAnimation旋转动画（使用旋转改变播放的动画）

*/
