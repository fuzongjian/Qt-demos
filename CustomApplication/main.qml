import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    width: 640
    height: 480
    color: "black"
    title: qsTr("Hello World")
    flags: Qt.Window | Qt.FramelessWindowHint
    Rectangle{
        x: 0; y: 0
        width: parent.width; height: 50
        color: "blue"
        focus: true
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            property point clickP: "0,0"
            onPressed: {
                clickP = Qt.point(mouse.x,mouse.y)
            }
            onPositionChanged: {
                var position = Qt.point(mouse.x - clickP.x, mouse.y - clickP.y)
                root.setX(root.x + position.x)
                root.setY(root.y+position.y)
            }

        }
        Keys.onPressed: {
            if(event.key == Qt.Key_F11){
                console.log("big")
                root.visibility = Window.FullScreen
            }else if(event.key == Qt.Key_Escape){
                console.log("small")
                root.visibility = Window.Windowed
            }else if (event.key == Qt.Key_Q){
                Qt.quit()
            }

        }
    }




    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
        color: "white"
    }
}
