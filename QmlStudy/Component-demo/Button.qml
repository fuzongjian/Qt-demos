import QtQuick 2.0

Rectangle{
    property alias text: textItem.text
    width: 100
    height: 62
    color: "blue"
    Text {
        id: textItem
        anchors.centerIn: parent
        color: "white"
    }
}
