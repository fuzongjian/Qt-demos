import QtQuick 2.0
Item {
    id: root
    width: 480
    height: 300
    property int duration: 3000
    Rectangle{
        id: sky
        width: parent.width
        height: 200
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#0080FF" }
            GradientStop { position: 1.0; color: "#66CCFF" }
        }
    }
    Rectangle{
        id: ground
        anchors.top: sky.bottom
        anchors.bottom: root.bottom
        width: parent.width
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#00FF00" }
            GradientStop { position: 1.0; color: "#00803F" }
        }
    }
    Image {
        id: ball
        x: 20; y: 240
        source: "../images/soccer_ball.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                ball.x = 20; ball.y = 240
                anim.restart()
            }
        }
    }
    SequentialAnimation {
        id: anim
        NumberAnimation{
            target: ball
            properties: "y"
            to: 20
            duration: root.duration * 0.4
            easing.type: Easing.OutCirc
        }
        NumberAnimation{
            target: ball
            properties: "y"
            to: 240
            duration: root.duration * 0.6
            easing.type: Easing.OutBounce
        }
    }
    NumberAnimation{
        target: ball
        properties: "x"
        to: 400
        duration: root.duration
    }
    RotationAnimation{
        target: ball
        properties: "rotation"
        to: 720
        duration: root.duration * 1.1
    }
}


