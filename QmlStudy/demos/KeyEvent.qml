import QtQuick 2.0

Rectangle{
    width: 100
    height: 100
    focus: true
    Keys.onPressed: {
        console.log(event.key)
        if(event.key == Qt.Key_A){
            console.log("key a was pressed")
            event.accepted = true
        }
    }
}
