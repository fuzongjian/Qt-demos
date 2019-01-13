import QtQuick 2.0

Rectangle{
    width: 800
    height: 800
    property int itemCount: 10
    ListModel{
        id: fruitModel
        ListElement{name: "Apple"; cost: 2.45}
        ListElement{name: "Apple"; cost: 2.46}
        ListElement{name: "Apple"; cost: 2.47}
        ListElement{name: "Apple"; cost: 2.48}
        ListElement{name: "Apple"; cost: 2.49}
    }
    Rectangle{
        width: 200
        height: 200
        color: "blue"
        anchors.centerIn: parent
    }

    PathView{
        id: view
        anchors.fill: parent
        model: itemCount
        delegate: Rectangle{
            width: 100
            height: 100
            color: "red"
            anchors.margins: 10
        }
        path:Path{
            startX: 100
            startY: 100
            PathLine { x: view.width-100; y: 100 }
            PathLine {x: view.width-100; y: view.height-100 }
            PathLine {x: 100; y: view.height-100 }
            PathLine {x: 100; y: 100 }


//            PathLine {x: 70; y: 70 }
//            PathLine { x: view.width-70; y: 70 }
//            PathLine {x: view.width-70; y: view.height-70 }
//            PathLine {x: 70; y: view.height-70 }
//            PathLine {x: 70; y: 70 }


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
    onWidthChanged: {
        console.log(width)

        if(width > 1000){
            itemCount = 20
        }else if (width>1000&&width<2000){
            itemCount = 50
        }else{
            itemCount = 100
        }
    }

}
