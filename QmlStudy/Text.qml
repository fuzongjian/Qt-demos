import QtQuick 2.0

Item {
    id: item
    width: 300
    height: 300
    Column{
        id: column
        spacing: 10
        Text{
            width: 200
            text: "使文本在单行中对于超出部分不要进行省略"
        }
        Text{
            width: 200
            elide: Text.ElideLeft
            text: "使文本在单行中对于超出部分从左边进行省略"
        }
        Text {
            width: 200
            elide: Text.ElideRight
            text: "使文本在单行中对于超出部分从右边进行省略"
        }
        Text{
            width: 200
            elide: Text.ElideMiddle
            text: "使文本在单行中对于超出部分从中间进行省略"
        }
        Rectangle{
            width: 100
            height: 100
            color: "red"
            Text{
                width: 100
                height: 100
                text: "中心"
                style: Text.Outline
                styleColor: "blue"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    Rectangle{
        anchors.top: column.bottom
        Text {

            textFormat: Text.RichText
            text: "The main website is at <a href=\"http://qt.nokia.com\">Nokia Qt DF</a>."
            onLinkActivated: console.log(link + " link activated")
        }
    }
}



