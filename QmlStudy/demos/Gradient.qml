import QtQuick 2.0

Rectangle{
    width: 200
    height: 200
    gradient: Gradient{
        GradientStop { position: 0.0; color: "red" }
        GradientStop { position: 0.43; color: "yellow" }
        GradientStop { position: 1.0; color: "green" }
    }
}
