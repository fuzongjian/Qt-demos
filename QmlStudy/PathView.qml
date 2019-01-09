import QtQuick 2.0

Rectangle{
    width: 400
    height: 240
    color: "white"
    ListModel{
        id: appModel
        ListElement { name: "Music"; icon: "AudioPlayer_48.png" }
        ListElement { name: "Movies"; icon: "VideoPlayer_48.png" }
        ListElement { name: "Camera"; icon: "Camera_48.png" }
        ListElement { name: "Calendar"; icon: "DateBook_48.png" }
        ListElement { name: "Messaging"; icon: "EMail_48.png" }
        ListElement { name: "Todo List"; icon: "TodoList_48.png" }
        ListElement { name: "Contacts"; icon: "AddressBook_48.png" }
    }
    Component{
        id: appDelegate
        Item {
            width: 100; height: 100
            scale: PathView.iconScale
            Image {
                id: myIcon
                y: 20; anchors.horizontalCenter: parent.horizontalCenter
                source: icon
                smooth: true
            }
            Text{
                anchors { top: myIcon.bottom; horizontalCenter: parent.horizontalCenter }
                text: name
                smooth: true
            }
        }
    }
    Component{
        id: appHighlight
        Rectangle { width: 80; height: 80; color: "lightsteelblue" }
    }

    PathView{
        id: view
        anchors.fill: parent
        // preferredHighlightBegin、preferredHighlightEnd指定当前item在view中首选起始结束的位置
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: appModel
        delegate: appDelegate
        // highlight 指定当前item绘制高亮效果组件
        highlight: appHighlight
        path: Path{
            startX: 10
            startY: 50
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathQuad { x: 200; y: 150; controlX: 50; controlY: 200 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathQuad { x: 390; y: 50; controlX: 350; controlY: 200 }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }
    }
}
