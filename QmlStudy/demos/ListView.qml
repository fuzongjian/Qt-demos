import QtQuick 2.0

ListView{
    width: 180
    height: 200
    Component{
        id: contactsDelegate
        Rectangle{
            id: wrapper
            width: 180
            height: contactInfo.height
            color: ListView.isCurrentItem ? "black" : "red"
            Text {
                id: contactInfo
                text: name + ":" + number
                color: wrapper.ListView.isCurrentItem ? "red" : "black"
            }
        }
    }
    model: ListViewModel{}
    delegate: contactsDelegate
    focus: true
}
