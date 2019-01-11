import QtQuick 2.0
Canvas {
    width: 320;
    height: 240;
/*
    PathQuad,贝塞尔曲线,是应用于二维图形应用程序的数学曲线。
    元素定义一条二次贝塞尔曲线作为路径段。它的起点为上一个路径元素的终点（或者路径的起点）。
    终点由 x 、 y 或 relativeX 、 relativeY 定义，控制点由 controlX 、 controlY 或 relativeControlX 、 relativeControlY 来定义。
    Path {
            startX: 0;
            startY: 0;
            PathQuad {
                x: root.width - 1;
                y: root.height - 1;
                controlX: 0;
                controlY: root.height - 1;
            }
        }

*/
    onPaint: {
        var ctx = getContext("2d");
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";
        ctx.beginPath();
        ctx.moveTo(0, 0);
        ctx.quadraticCurveTo(0, height - 1, width - 1, height - 1);
        ctx.stroke();
    }
    Text {
        anchors.centerIn: parent;
        font.pixelSize: 20;
        text: "quadratic Bezier curve";
    }
}

