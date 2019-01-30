import QtQuick 2.0

Item {
    width: 800
    height: 600
    Item {
        id: flow
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: columns * (cardWidth+spacing) - spacing
        anchors.margins: 8
        property int spacing: 8
        property int cardWidth: 80
        property int animeDuration: 100//1200//动画周期+修改定时
        property int columns: (parent.width)/(cardWidth+spacing)//每行多少个
        property int length//cards数组的数量,默认为0,所有元素的数量
        property var cards: []
        property var bottoms: []
        function update(item) {
            var upCard = bottoms[0]//存储高度最低的元素
            var column = 0
            for (var i = 1;i<columns;i++) {//需找高度最低的底元素
                if (bottoms[i].bottomY<upCard.bottomY) {
                    upCard = bottoms[i]
                    column = i
                }
            }
            item.upCard = upCard//上下元素连接
            upCard.downCard = item
            item.column = column//设置元素是那一列的
            bottoms[column] = item//更新最低元素
        }
        function push(item) {
            cards.push(item)
            update(item)
            length = cards.length
        }
        function remove(idx) {
            var item = cards[idx]
            cards = cards.slice(0, idx).concat(cards.slice(idx+1))
            item.upCard.downCard = item.downCard
            item.downCard.upCard = item.upCard
            if (item === bottoms[item.column])
                bottoms[item.column] = item.upCard
            item.opacity = 0
            length = cards.length
        }
        Item {
            id: dummy
            property int bottomY: y+height
            property Item upCard: dummy
            property Item downCard: dummy
            x: 0
            y: 0
            width: 0
            height: 0
        }
        Item {
            id: bottomy
            property int bottomY: y+height
            property Item upCard: dummy
            property Item downCard: dummy
            x: parent.width/2
            y: parent.height
            width: 0
            height: 0
        }
        Component {
            id: card
            Rectangle {
                property int bottomY: y+height
                property Item upCard: bottomy
                property Item downCard: bottomy
                property int column: flow.columns/2
                opacity: 0
                x: (width + flow.spacing)*column//自身的x位置
                y: upCard.y + upCard.height + flow.spacing//自身的y位置
                width: flow.cardWidth
                height: 40 + Math.random()*80
                color: Qt.hsla(Math.random(), .7, .5, 1.)
                Behavior on x {
                    NumberAnimation {
                        duration: flow.animeDuration
                    }
                }
                Behavior on y {
                    NumberAnimation {
                        duration: flow.animeDuration
                    }
                }
                Behavior on opacity {
                    NumberAnimation {
                        duration: flow.animeDuration
                    }
                }
                onOpacityChanged: {
                    if (opacity <=0)
                        destroy()
                }
                Component.onCompleted:
                    opacity = 1
            }
        }
        onColumnsChanged: {
            console.log("gg0",length);
            bottoms = []//初始化底部数组
            for (var i=0;i<columns;i++)
                bottoms.push(dummy)
            for (var i=0;i<length;i++)
                update(cards[i])
        }
    }
    Timer {
        repeat: true
        interval: flow.animeDuration * 2
        running: true
        triggeredOnStart: true
        onTriggered: {
            var r = Math.random()
            if (r>flow.length/50) {
                info.text = "Append to flow at %1".arg(flow.length)
                flow.push(card.createObject(flow))
            }
//            else {
//                r = Math.random()
//                r = parseInt(r*flow.length)
//                info.text = "Remove from flow at %1".arg(r)
//                flow.remove(r)
//            }
        }
    }
    Text {
        id: info
        x: 8
        y: parent.height - font.pixelSize - 8
    }
}

