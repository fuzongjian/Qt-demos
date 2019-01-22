import QtQuick 2.0

Rectangle{
    id: root
    width: 550
    height: 400
    color: "black"
    Keys.onPressed: {
        console.log(event.key)
    }

    Component{
        id: appDelegate
        Item{
            width: gridview.cellWidth
            height: gridview.cellHeight
            Rectangle{
                width: parent.width -5
                height: parent.height -5
                anchors.centerIn: parent
                color: "black"
                border.width: 1
                radius: 5
                Image {
                    id: displayImage
                    source: "../images/10.png"
                    anchors.fill: parent
                    clip: true
                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                    asynchronous: true
                    cache: false //指定是否缓存图像，默认为true，在处理大图像的时候，指定为false还是很有用的
                }
//                Text{
//                  anchors.centerIn: parent
//                    text: index + 1
//                    color: "white"
//                }
                RotationAnimation on  rotation{
                    from: 0; to: 360
                    duration: 1000
                    direction: RotationAnimation.Clockwise

                }
                PropertyAnimation on scale {
                    from: 0; to: 1
                    duration: 1000
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log(index)
                        gridview.clickNum = index + 1
                        if(gridview.state == "show")
                            return
                        else
                            gridview.state = "show"
                       // gridview.state = (gridview.state == "hidden" ? "show" : "hidden")
                    }
                }
            }
        }
    }

    Component{
        id: appHightLight
        Rectangle{ width: 80; height: 80; color: "lightSteelblue" }
    }

    GridView{
        id: gridview
        property int clickNum : 0
        anchors.fill: parent
        cellWidth: 150
        cellHeight: 150

        focus: true
        model: 10000
        delegate: appDelegate
        flow: GridView.FlowTopToBottom
        Rectangle{
            id: display
            visible: true
            width: root.height*0.3
            height: width
            z: 1000
            anchors.centerIn: parent
            color: "black"
            scale: 0
            opacity: 0.9
            Text {
                id: displayLabel
                anchors.centerIn: parent
                text: gridview.clickNum
                color: "white"
            }
        }
        state: "hidden"
        // 状态
        states: [
            State {
                name: "hidden"
                PropertyChanges { target: display; scale: 0.0 }// 这一句话要不要都可以
            },
            State {
                name: "show"
                PropertyChanges { target: display; scale: 1.0 }// 这一句话要不要都可以
            }
        ]
        transitions: [
            Transition {
                from: "hidden"
                to: "show"
                NumberAnimation {
                    target: display
                    properties: "scale"
                    to: 1.0
                    duration: 1000
                    easing.type: Easing.OutBounce
                }
            },
            Transition {
                from: "show"
                to: "hidden"
                NumberAnimation {
                    target: display
                    properties: "scale"
                    to: 0.0
                    duration: 1000
                    easing.type: Easing.OutCirc
                }
            }
        ]

        onMovementStarted: {
            gridview.state = "hidden"
        }
    }
}

