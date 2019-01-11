import QtQuick 2.0

Canvas {
    width: 400; height: 200
    contextType: "2d"

    Path {
        id: myPath
        /*1*/
//        startX: 100; startY: 0
//        PathArc {
//            x: 0; y: 100
//            radiusX: 100; radiusY: 100
//            useLargeArc: true
//        }
        /*2*/
           startX: 0; startY: 100

            PathArc {
                relativeX: 50; y: 100
                radiusX: 25; radiusY: 15
            }
            PathArc {
                relativeX: 50; y: 100
                radiusX: 25; radiusY: 25
            }
            PathArc {
                relativeX: 50; y: 100
                radiusX: 25; radiusY: 50
            }
            PathArc {
                relativeX: 50; y: 100
                radiusX: 50; radiusY: 100
            }

    }

    onPaint: {
        context.strokeStyle = Qt.rgba(.4,.6,.8);
        context.path = myPath;
        context.stroke();
    }
}
