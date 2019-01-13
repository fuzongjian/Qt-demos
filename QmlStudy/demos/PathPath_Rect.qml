import QtQuick 2.0

Canvas {
    width: 400; height: 400
    contextType: "2d"
    id: canvas
    Path {
        id: myPath
        startX: 10; startY: 10
        PathLine { x: canvas.width-10; y: 10 }
        PathLine {x: canvas.width-10; y: canvas.height-10 }
        PathLine {x: 10; y: canvas.height-10 }
        PathLine {x: 10; y: 10 }

        PathLine {x: 50; y: 50 }
        PathLine { x: canvas.width-50; y: 50 }
        PathLine {x: canvas.width-50; y: canvas.height-50 }
        PathLine {x: 50; y: canvas.height-50 }
        PathLine {x: 50; y: 50 }

        PathLine {x: 100; y: 100 }
        PathLine { x: canvas.width-100; y: 100 }
        PathLine {x: canvas.width-100; y: canvas.height-100 }
        PathLine {x: 100; y: canvas.height-100 }
        PathLine {x: 100; y: 100 }

    }

    onPaint: {
        context.strokeStyle = Qt.rgba(.4,.6,.8);
        context.path = myPath;
        context.stroke();
    }
}
