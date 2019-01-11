import QtQuick 2.0

Canvas {
    width: 400; height: 200
    contextType: "2d"

    Path {
        id: myPath
        startX: 20; startY: 0
        PathCubic {
            x: 180; y: 0
            control1X: -10; control1Y: 90
            control2X: 210; control2Y: 90
        }
    }

    onPaint: {
        context.strokeStyle = Qt.rgba(.4,.6,.8);
        context.path = myPath;
        context.stroke();
    }
}
