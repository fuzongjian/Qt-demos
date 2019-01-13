import QtQuick 2.0


Canvas {
    width: 400; height: 200
    contextType: "2d"

    Path {
        id: myPath
        startX: 0; startY: 100
        PathLine { x: 200; y: 80 }
        PathLine {x: 250; y: 150 }
        PathLine {x: 300; y: 160 }
        PathLine {x: 350; y: 180 }
        PathLine {x: 400; y: 220 }
        PathLine {x: 450; y: 250 }

    }

    onPaint: {
        context.strokeStyle = Qt.rgba(.4,.6,.8);
        context.path = myPath;
        context.stroke();
    }
}
