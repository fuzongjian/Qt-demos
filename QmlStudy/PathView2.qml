import QtQuick 2.0

Rectangle {
    width: 700
    height: 600
    color: "black"
    id: root
    PathView{
        id: view
        focus: true
        model: myModel
        delegate: myDelegate
        anchors.fill: parent
        pathItemCount: 5

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        flickDeceleration: 390
        path: myPath
    }

    Component{
        id: myDelegate
        Item{
            property real tmpAngle: PathView.rotateY
            property real scaleValue: PathView.scalePic
            width: 340
            height: 260
            visible: PathView.onPath
            z: PathView.zOrder

            Image{
                id:myImage
                width: 340
                height: 260
                source: picName
                anchors.horizontalCenter: parent.horizontalCenter
                smooth: true
            }
            Image {
                id: subImage
                width: 340
                height: 260
                source: picName
                anchors.horizontalCenter: parent.horizontalCenter
                smooth: true
                transform: Rotation { origin.x: 0; origin.y: 260; axis { x: 1; y: 0; z: 0 } angle: 180 }
            }
            Rectangle{
                y: myImage.height;
                x: -1
                width: myImage.width + 1
                height: myImage.height
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(0,0,0, 0.7) }
                }
            }
            transform:[
               Rotation{
                   angle: tmpAngle
                   origin.x: 340/2
                   axis { x: 0; y: 1; z: 0 }
               },
               Scale {
                   xScale:scaleValue; yScale:scaleValue
                   origin.x: 340/2;   origin.y: 260/2
               }
           ]
        }
    }
    Path{
        id: myPath
        startX: 0; startY: 150
        PathAttribute {name: "rotateY"; value: 50.0}
        PathAttribute {name: "scalePic"; value: 0.5}
        PathAttribute {name: "zOrder"; value: 1}

        PathLine{x:180; y: 150}
        PathPercent {value: 0.44}
        PathAttribute {name: "rotateY"; value: 50.0}
        PathAttribute {name: "scalePic"; value: 0.5}
        PathAttribute {name: "zOrder"; value: 10}

        PathQuad{x:320; y: 190; controlX: 290; controlY: 190}
        PathPercent {value: 0.50}
        PathAttribute {name: "rotateY"; value: 0.0}
        PathAttribute {name: "scalePic"; value: 1.0}
        PathAttribute {name: "zOrder"; value: 50}

        PathQuad{x:460; y: 150; controlX: 510; controlY: 150}
        PathPercent {value: 0.56}
        PathAttribute {name: "rotateY"; value: -50.0}
        PathAttribute {name: "scalePic"; value: 0.5}
        PathAttribute {name: "zOrder"; value: 10}

        PathLine{x:640; y: 150}
        PathPercent {value: 1.00}
        PathAttribute {name: "rotateY"; value: -50.0}
        PathAttribute {name: "scalePic"; value: 0.5}
        PathAttribute {name: "zOrder"; value: 1}
    }

    ListModel{
        id: myModel
        ListElement { picName: "01.png" }
        ListElement { picName: "02.png" }
        ListElement { picName: "03.png" }
        ListElement { picName: "04.png" }
        ListElement { picName: "05.png" }
        ListElement { picName: "06.png" }
        ListElement { picName: "07.png" }
        ListElement { picName: "08.png" }
        ListElement { picName: "09.png" }
        ListElement { picName: "10.png" }
    }
}
