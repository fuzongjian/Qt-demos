import QtQuick 2.0

Item {
    width: 1500
    height: 1500
    Item {
        id: flow
        anchors.fill: parent
        property int cardHeight: 80 // 每个格子的宽度
        property int cardWidth: 80  // 每个格子的高度
        property int margin: 8  // 间隔
        property int duration: 1000 // 动画时间
        property int originX: 0  // 记录X的值
        property int originY: margin // 记录Y的值
        property var cards: [] // 保存所有的卡片
        property var selects: [] // 被选中的卡片
        property int type: 1 // 1 创建  2 销毁
        property var path: "file:///C:/Users/fuzongjian/Desktop/Qt-Quick/testimage/image("
        function push(item){
            var x = originX + margin;

            // 判断是否换行
            if(x >= flow.width){
                x = margin;
                // 是否停止创建
                if(originY + margin + cardHeight > flow.height){
                    builder.stop();
                    // 销毁最后一个（多余）
                    item.opacity = 0;
                    /********************************* 开启销毁；需要延时 *****************************/
                    //startDestroy();
                }
                // 更新originY
                originY += (cardHeight + margin);
            }
            item.x = x;
            item.y = originY;
            // 保存
            cards.push(item);
            // 更新originX
            originX = x + cardWidth;

//            console.log(parseInt(Math.random()*50))

        }
        function startDestroy(){
            destroyer.delay(3,function start(){
                flow.type = 2;
                builder.interval = 100;
                builder.start();
            })
        }

        function remove(idx){
            if(cards.length == 0){
                builder.stop();
                destroyer.delay(3,function start(){
                    flow.type = 1;
                    builder.interval = 10;
                    flow.originX = 0;
                    flow.originY = flow.margin;
                    builder.start();
                })
                return;
            }
            var item = cards[idx]
            cards = cards.slice(0,idx).concat(cards.slice(idx+1));
            item.z = 1000;
            item.y = flow.height + flow.cardHeight;
            item.opacity = 0;
        }
        function resetLayout(){
            for(var i = 0; i < cards.length; i ++){
                var item = cards[i]
                dealDistance(item,function getState(state,idx){
                    if(state === true){
                        item.x = flow.width*0.5
                        item.y = flow.height*0.5
                        item.scale = 0
                        flow.selects.push(item)
                    }
//                    switch (idx){
//                    case 1:
//                        item.x += item.scale * item.width
//                        item.y -= item.scale * item.height
//                        item.z =  1000
//                        break
//                    case 2:
//                        item.x -= item.scale * item.width
//                        item.y -= item.scale * item.height
//                        item.z =  1000
//                        break
//                    case 3:
//                        item.x -= item.scale * item.width
//                        item.y += item.scale * item.height
//                        item.z =  1000
//                        break
//                    case 4:
//                        item.x += item.scale * item.width
//                        item.y += item.scale * item.height
//                        item.z =  1000
//                        break
//                    default:
//                        break
//                    }
                })
            }
            console.log(flow.selects.length)
        }
        function dealDistance(rect,callback){
            var x = flow.width * 0.5 - rect.x - flow.cardWidth*0.5
            var y = flow.height * 0.5 - rect.y - flow.cardWidth*0.5
            // 判断中心距离
            var width = Math.abs(x)
            var height = Math.abs(y)
            var distance = Math.sqrt(width*width + height*height)
            var stat = false
            if(distance < 300){
                stat = true
            }else{
                stat = false
            }
            // 判断象限
            var quadrant = 0
            if(stat == true){
                if(x < 0 && y > 0){
                    quadrant = 1
                }else if(x < 0 && y < 0){
                    quadrant = 4
                }else if(x > 0 && y > 0){
                    quadrant = 2
                }else{
                     quadrant = 3
                }
                callback(stat,quadrant)
            }

        }
        Component{
            id: card
            Rectangle{
                id: item
                // x和y的初始值为中心
                x: flow.width*0.5
                y: -flow.cardHeight
                width: flow.cardWidth
                height: flow.cardHeight
                opacity: 0  // 设置透明度为0
                color: Qt.hsla(Math.random(),.7,.5,1.)
                Behavior on x { NumberAnimation { duration: flow.duration }}  // x 动画
                Behavior on y { NumberAnimation { duration: flow.duration }}  // y 动画
                Behavior on opacity { NumberAnimation { duration: flow.duration }}
                Behavior on scale { NumberAnimation { duration: flow.duration }}
                // 先设置当opacity为0时，销毁
                onOpacityChanged: {
                    if(opacity == 0){
                        destroy()
                    }
                }
                // 加载完成时，设置opacity为1
                Component.onCompleted: { opacity = 1 }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        // 在这里处理位置
                        flow.resetLayout();

                    }
                }
//                Image {
//                    id: displayImage
//                    anchors.fill: parent
//                    source: "../images/0" + parseInt(Math.random()*10)+".png"
//                }
            }
        }
    }
    // 定时器
    Timer{
        id: builder
        repeat: true
        interval: 10
        running: true
        triggeredOnStart: true
        onTriggered: {
            switch(flow.type){
            case 1:
                 flow.push(card.createObject(flow));
                 break;
            case 2:
                flow.remove(0);
                break;
            default:
                break;
            }


        }
    }
    // 延时处理
    Item {
        id: destroyer
        Timer{
            id: timer
        }
        function delay(delayTime,callback){
            timer.interval = delayTime*1000;
            timer.repeat = false;
            timer.triggered.connect(callback);
            timer.start();
        }
    }
}
