import QtQuick 2.0

Rectangle{
    width: 300
    height: 400
    color: "white"
    ListModel{
        id: appModel
        ListElement { name: "Music"; icon: "../images/AudioPlayer_48.png" }
        ListElement { name: "Movies"; icon: "../images/VideoPlayer_48.png" }
        ListElement { name: "Camera"; icon: "../images/Camera_48.png" }
        ListElement { name: "Calendar"; icon: "../images/DateBook_48.png" }
        ListElement { name: "Messaging"; icon: "../images/EMail_48.png" }
        ListElement { name: "Todo List"; icon: "../images/TodoList_48.png" }
        ListElement { name: "Contacts"; icon: "../images/AddressBook_48.png" }
    }
    Component{
        id: appDelegate
        Item{
            width: 100
            height: 100
            Image {
                id: myIcon
                y: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: icon
            }
            Text{
                anchors { top: myIcon.bottom; horizontalCenter: parent.horizontalCenter }
                text: name
            }
        }
    }

    Component{
        id: appHightLight
        Rectangle{ width: 80; height: 80; color: "lightSteelblue" }
    }

    GridView{
        anchors.fill: parent
        cellWidth: 100; cellHeight: 100
        highlight: appHightLight
        focus: true
        model: appModel
        delegate: appDelegate
    }
}
