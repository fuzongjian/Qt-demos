import QtQuick 2.5
import QtQuick.Window 2.2



Window {
    visible: true
    width: 640
    height: 800
    title: qsTr("Hello World")
    // 列
    Column{
        id: column
        spacing: 10
        Button{ text: "Apple" }
        Button{ text: "Orange" }
        Button{ text: "Pear" }
        Rectangle{ color: "red"; width: 50; height: 50 }
        // 行
        Row{
            id: row
            spacing: 20
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
        }
        // 栅格
        Grid{
            columns: 4
            spacing: 10
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
            Rectangle{ color: "red"; width: 50; height: 50 }
        }
    }

    // flow
    Rectangle{
        id: flow
        color: "lightblue"
        anchors.left: column.right
        anchors.margins: 10
        width: 300
        height: 200

        Flow{
            anchors.fill: parent
            anchors.margins: 4
            spacing: 10

            Text { text: "Text"; font.pixelSize: 30 }
            Text { text: "Text"; font.pixelSize: 30 }
            Text { text: "Text"; font.pixelSize: 30 }
            Text { text: "Text"; font.pixelSize: 30 }
            Text { text: "Text"; font.pixelSize: 30 }
            Text { text: "Text"; font.pixelSize: 30 }
            Text { text: "Text"; font.pixelSize: 30 }
        }
    }
    // repeater
    Rectangle{
        id: repeater
        color: "black"
        width: 300
        height: 300
        anchors.left: column.right
        anchors.top: flow.bottom
        anchors.margins: 10
        Grid{
            x: 5; y: 5
            rows: 5; columns: 5; spacing: 10
            Repeater{
                model: 25
                Rectangle{
                    width: 40; height: 40
                    color: "lightgreen"
                    Text {
                       text: index
                       font.pointSize: 20
                       anchors.centerIn: parent
                       onTextChanged: console.log(index)
                    }
                }
            }
        }
    }
    // text
    Column{
        spacing: 20
        Text {
            width: 200
            text: "使文本在单行中对于超出部分不要进行省略"
        }
    }

    // item
    Item {
        anchors.left: parent
        anchors.top: repeater.bottom
        Rectangle{
            opacity: 0.5
            color: "red"
            width: 100; height: 100
            Rectangle{
                color: "blue"
                x: 50; y: 50; width: 100; height: 100
            }
        }
    }

}
