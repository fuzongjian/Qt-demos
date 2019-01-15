import QtQuick 2.5
import QtQuick.Window 2.2
import Qt.labs.folderlistmodel 2.0
import MainManager.module 1.0
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    // C++与QML混编
    CommonManager{
        id: manager
        Component.onCompleted: {
            test();
            var string = testString()
            console.log(string)
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            manager.test()
            display.text = manager.testString()
        }
    }

    Text {
        id: display
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
}
