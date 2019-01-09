import QtQuick 2.0

Item {
    Column{
        spacing: 10
        Repeater{
            model: 10
            Rectangle{
                width: 200
                height: 20
                radius: 3
                color: "lightBlue"
                Text{
                    anchors.centerIn: parent
                    text: index
                }
            }
        }
    }
}
