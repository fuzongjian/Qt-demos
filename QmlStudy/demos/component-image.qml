import QtQuick 2.0

Image {
    width: 400
    height: 225
    source: "../images/10.png"
    Image {
        id: overlay
        source: "../images/09.png"
        anchors.fill: parent
        opacity: 0
        Behavior on opacity{ NumberAnimation{ duration: 300}}
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            overlay.opacity = 1 ? (overlay.opacity == 0) : (overlay.opacity == 1)
        }
    }
}
