import QtQuick 2.0

Rectangle{
    width: 400
    height: 400
    ListModel{
        id: fruitModel
        ListElement{name: "Apple"; cost: 2.45}
        ListElement{name: "Apple"; cost: 2.46}
        ListElement{name: "Apple"; cost: 2.47}
        ListElement{name: "Apple"; cost: 2.48}
        ListElement{name: "Apple"; cost: 2.49}
    }
    PathView{
        id: view
        anchors.fill: parent
        model: 40
        delegate: Rectangle{
            width: 20
            height: 20
            color: "red"
            anchors.margins: 10
        }

        path:Path{
            startX: view.width / 2
            startY: view.height / 2

            PathQuad {
                relativeX: 0
                y: view.height
                controlX: view.width
                controlY: 0
            }
            PathQuad {
                relativeX: 0
                y: view.height / 2
                controlX: 0
                controlY: 0
            }

        }
    }

}
