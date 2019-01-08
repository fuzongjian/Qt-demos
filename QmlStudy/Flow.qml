import QtQuick 2.0

Rectangle{
    color: "lightblue"
    width: 300; height: 200
    Flow{
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
        Text { text: "Text"; font.pixelSize: 40 }
        Text { text: "Text"; font.pixelSize: 40 }
        Text { text: "Text"; font.pixelSize: 40 }
        Text { text: "Text"; font.pixelSize: 40 }
        Text { text: "Text"; font.pixelSize: 40 }
        Text { text: "Text"; font.pixelSize: 40 }

    }
}
