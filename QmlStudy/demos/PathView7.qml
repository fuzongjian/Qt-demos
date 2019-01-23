import QtQuick 2.0

Rectangle{
    width: 900
    height: 900

    ListModel {
        id: model
        ListElement { fruit: "Bilberry";
                      picture: "http://upload.wikimedia.org/wikipedia/commons/9/91/Norwegian_blueberries.jpg" }
        ListElement { fruit: "Kumquat";
                      picture: "http://upload.wikimedia.org/wikipedia/commons/8/82/Kumquat.jpeg" }
        ListElement { fruit: "Grapefruit"; picture:
                      "http://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/
    Table_grapes_on_white.jpg/250px-Table_grapes_on_white.jpg" }
    }
    Component {
        id: delegate
        Item {
            width: 100; height: 100
            scale: PathView.scale
            Column { Image { anchors.fill: parent; source: picture;  }
                     Text { text: fruit; font.pointSize: 24; }
            }
        }
    }
    PathView {
        anchors.fill: parent
        model: model;
        delegate: delegate
        path: Path {
            startX: 100; startY: 100
            PathAttribute { name: "scale"; value: 0.5 }
            PathLine { x:200; y:200 }
            PathAttribute { name: "scale"; value: 1.0 }
            PathLine { x:300; y:100 }
            PathLine { x:100; y:100 }
        }
    }

}
