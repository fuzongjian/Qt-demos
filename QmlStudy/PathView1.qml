import QtQuick 2.0

Rectangle{
    width: 480
    height: 300
    color: "black"
    id: root


    Component{
        id: rectDelegate
        Item {
            id: wrapper
            z: PathView.zOrder
            opacity: PathView.itemAlpha
            scale: PathView.itemScale
            Rectangle{
                width: 100
                height: 60
                color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
                border.width: 2
                border.color: wrapper.PathView.iscurrentItem ? "red":"lightgray"
                Text{
                    anchors.centerIn: parent
                    font.pixelSize: 28
                    text: index
                    color: Qt.lighter(parent.color,2)
                }
            }
        }
    }
    PathView{
        id: pathView
        anchors.fill: parent
        interactive: true
        pathItemCount: 7
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        delegate: rectDelegate
        model: 15
        path: Path{
            // startX、startY整个路径的起点
            startX: 10
            startY: 100
            // PathAttribute放在某个路径段的前面，指明这段路径起始时的属性值；路径段后面的PathAttribute指明路径段终止时的属性值，而在路径段上的属性值Path会根据起止值自动插值计算
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemAlpha"; value: 0.1 }
            PathAttribute { name: "itemScale"; value: 0.6 }
            // PathLine是最简单的路径元素，在Path的起点或者一段路径的终点，与本元素定义的终点之间绘制一条直线
            PathLine {
                x: root.width/2 - 40
                y: 100
            }
            PathAttribute { name: "zOrder"; value: 10 }
            PathAttribute { name: "itemAlpha"; value: 0.8 }
            PathAttribute { name: "itemScale"; value: 1.2 }
            // relativeX、relativeY是相对于起点的相对坐标的形式来指定终点
            PathLine{
                relativeX: root.width/2 - 60
                relativeY: 0
            }
            PathAttribute { name: "zOrder"; value: 0 }
            PathAttribute { name: "itemAlpha"; value: 0.1 }
            PathAttribute { name: "itemScale"; value: 0.6 }
        }
        focus: true
        Keys.onLeftPressed: decrementCurrentIndex()
        Keys.onRightPressed: incrementCurrentIndex()
        onCurrentIndexChanged: {
            console.log(currentIndex)
        }
        onCurrentItemChanged: {
            console.log(currentItem)
        }
    }
}
