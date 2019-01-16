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
            anchors.centerIn: parent
            source: "../images/qt.png"
        }
        PinchArea{
            anchors.fill: parent
            pinch.target: image
            pinch.maximumScale: 2
            pinch.minimumScale: 0.2
            pinch.minimumRotation: -180
            pinch.maximumRotation: 180
        }
    }
}

