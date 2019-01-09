import QtQuick 2.0

Rectangle {
    id: root

    width: 300
    height: 500

    Rectangle {
        id: rect
        width: 200; height: parent.height
        color: "red"

        NumberAnimation {
            running: true
            target: rect;
            property: "x";
            from:root.width;
            to:root.width-rect.width;
            duration: 2000;
            easing.type: Easing.InOutExpo;  //Easing.InOutQuad; Easing.InOutCubic
            //loops: Animation.Infinite //Easing.InOutQuart;
        }
    }

}
