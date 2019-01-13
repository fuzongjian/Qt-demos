import QtQuick 2.0

Rectangle{
    width: 900
    height: 900
    property int itemCount: 100
    property int itemWH: 80

    // 中间的高清显示
    Rectangle{
        width: 100
        height: 100
        color: "blue"
        anchors.centerIn: parent
    }

    PathView{
        id: view
        anchors.fill: parent
        model: itemCount
        pathItemCount: 20
//        highlight: highLight
        delegate: Rectangle{
            id: item
            width: 100
            height: 100
            color: "red"
            anchors.margins: 10
//            ColorAnimation on color { from: "white"; to: "red"; duration: 1000 }
            RotationAnimation on  rotation{
                from: 0; to: 360
                duration: 1000
            }
            PropertyAnimation on scale {
                from: 0; to: 1
                duration: 1000
            }
            Text{
                color: "white"
                text: index + 1
                anchors.centerIn: parent
            }


        }
        path:Path{
            startX: itemWH
            startY: itemWH

            PathLine { x: view.width-100; y: 100 }
            PathLine {x: view.width-100; y: view.height-100 }
            PathLine {x: 100; y: view.height-100 }
            PathLine {x: 100; y: 100 }


            PathLine {x: 250; y: 250 }
            PathLine { x: view.width-250; y: 250 }
            PathLine {x: view.width-250; y: view.height-250 }
            PathLine {x: 250; y: view.height-250 }
            PathLine {x: 250; y: 250 }


//            PathLine {x: 120; y: 120 }
//            PathLine { x: view.width-120; y: 120 }
//            PathLine {x: view.width-120; y: view.height-120 }
//            PathLine {x: 120; y: view.height-120 }
//            PathLine {x: 120; y: 120 }

//            PathLine {x: 170; y: 170 }
//            PathLine { x: view.width-170; y: 170 }
//            PathLine {x: view.width-170; y: view.height-170 }
//            PathLine {x: 170; y: view.height-170 }
//            PathLine {x: 170; y: 170 }

//            PathLine {x: 220; y: 220 }
//            PathLine { x: view.width-220; y: 220 }
//            PathLine {x: view.width-220; y: view.height-220 }
//            PathLine {x: 220; y: view.height-220 }
//            PathLine {x: 220; y: 220 }
        }
    }
    Component{
        id: highLight
        Rectangle{
            height: 100+5
            width: 100+5
            border.color: "blue"
            border.width: 2
        }
    }

    onWidthChanged: {
        console.log(width)

//        if(width > 1000){
//            itemCount = 20
//        }else if (width>1000&&width<2000){
//            itemCount = 50
//        }else{
//            itemCount = 100
//        }
    }

}
