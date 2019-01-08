import QtQuick 2.0

Item {
    Rectangle{
        z: 1
        color: "red"
        width: 100; height: 100
        border.color: "black"
        border.width: 1
        radius: 5
    }
    Rectangle{
        z: 2
        color: "blue"
        x: 50; y: 50; width: 100; height: 100
    }
}
