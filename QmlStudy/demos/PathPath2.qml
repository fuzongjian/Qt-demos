import QtQuick 2.0
/*
PathArc 路径元素定义一条弧线，它的起点为上一个路径元素的终点（或者路径的起点），终点由 x 、 y 或 relativeX 、 relativeY 定义。
弧线的半径由 radiusX 、 radiusY 定义。
*/
Canvas{
    width: 400
    height: 240

    onPaint: {
        var ctx = getContext("2d")
        ctx.lineWidth = 4
        ctx.strokeStyle = "red"
        ctx.beginPath()
        ctx.arc(200, 0, 160, Math.PI * 2, 0, false)
        ctx.stroke()
    }

    Rectangle{
        id: rect
        width: 40
        height: 40
        x: 20
        y: 0
        color: "blue"

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            onClicked: pathAnim.start()
        }

        PathAnimation{
            id: pathAnim
            target: rect
            duration: 6000
            anchorPoint: "20, 20"
            orientationEntryDuration: 200
            orientationExitDuration: 200
            easing.type: Easing.InOutCubic

            orientation: PathAnimation.TopFirst
            path: Path{
                startX: 40
                startY: 20
                PathArc{
                    x: 360
                    y: 0
                    useLargeArc: true
                    radiusX: 160
                    radiusY: 160
                    direction: PathArc.Counterclockwise
                }
            }
        }
    }
}
