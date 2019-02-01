import QtQuick 2.0
import "WaterFall.js" as WaterFall
Item {
    width: 1200
    height: 900
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
        property int radius: 300 // 定义半径
        property var selectedX: 0
        property var selectedY: 0
        property var selectedW: 0
        property var selectedH: 0
        property var selectedaAngle: 0
        property int selectNum: 10000  // 标记选中的卡片
        property var isReset: false
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
                    /********************************* 开启销毁 *****************************/
                    startDestroy();
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
            disappear.willStart(1,function start(){
                var randomN = WaterFall.randomX(cards.length,selectNum)
                var itm = cards[randomN]
                if(flow.selects.indexOf(itm) > 0) return;
                var newitm = card.createObject(flow);
                newitm.x = itm.x
                newitm.y = itm.y
                newitm.width = itm.width
                newitm.height = itm.height
                newitm.rotation = itm.rotation
                newitm.scale = itm.scale
                newitm.z = itm.z
                cards[randomN] = newitm
                itm.opacity = 0


//                resetCircle()
            })

        }
        function remove(idx){
            // 如果数组中没有卡片了，就启动添加
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
            // 重组剩下的卡片
            var item = cards[idx]
            cards = cards.slice(0,idx).concat(cards.slice(idx+1));
            item.z = 1000;
            item.y = flow.height + flow.cardHeight;
            item.opacity = 0;
        }
        function resetLayout(){
            // 筛选出需要变化的卡片
            for(var i = 0; i < cards.length; i ++){
                var item = cards[i]
                dealDistance(item,function getState(state){
                    if(state === true){
                        item.x = flow.width*0.5
                        item.y = flow.height*0.5
                        item.scale = 0
                        flow.selects.push(item)
                    }
                })
            }
            // 对选中的卡片做处理
            /*
             * 1、根据半径、角度来计算坐标
             * 2、更换需要变化的卡片
            */
            var length = flow.selects.length,angle = (360/length).toFixed(3),allAngle = 0
            var halfWidth = flow.width*0.5,halfHeight = flow.height*0.5
            for(var j = 0; j < length; j ++){
                allAngle = (angle*j).toFixed(1) * Math.PI / 180
                var x = halfWidth + (radius-20) * Math.sin(allAngle)
                var y = halfHeight - (radius-20) * Math.cos(allAngle)
                var itm = selects[j]
                itm.z = 1000+j
                itm.x = x- cardWidth*0.5
                itm.y = y - cardHeight*0.5
                itm.scale = 0.8
                itm.rotation = (angle*i).toFixed(1)
            }
            destroyer.delay(5,function after(){
                console.log("time end")
                resetCircle()
            })
        }
        function resetCircle(){
            if(flow.selects.length === 0)return;

//            var a = WaterFall.random(flow.selects.length)
//            var b = WaterFall.random(flow.selects.length)
//            if(a === b) return;

//            var itemA = selects[a]
//            var itemB = selects[b]

//            var x = itemA.x,y = itemA.y,rotation = itemA.rotation



//            itemA.x = itemB.x
//            itemA.y = itemB.y
//            itemA.rotation = itemB.rotation

//            itemB.x = x
//            itemB.y = y
//            itemB.rotation = rotation
//            var length = flow.selects.length
//            for(var i = 0; i < length; i ++){
//                var j = i + 1
//                if(i === length - 1){
//                    j = 0
//                }
//            }

//            return;
            var length = flow.selects.length,angle = (360/length).toFixed(1)
            var halfWidth = flow.width*0.5,halfHeight = flow.height*0.5
            for(var k = 0; k < length; k ++){
                var itm = selects[k]
                var rotation = itm.rotation
//                angle =  parseFloat(angle)
//                console.log(typeof angle,typeof rotation)
//                rotation += angle
//                console.log(rotation)
//                itm.rotation = itm.rotation + angle

//                var x = halfWidth + (radius-20) * Math.sin(itm.rotation)
//                var y = halfHeight - (radius-20) * Math.cos(itm.rotation)
//                itm.z = 1000+k
//                itm.x = x - cardWidth*0.5
//                itm.y = y - cardHeight*0.5
//                itm.scale = 0.8
            }
        }
        // parentW、parentH、childW、childH、item
        function dealDistance(rect,callback){
            var x = flow.width * 0.5 - rect.x - flow.cardWidth*0.5
            var y = flow.height * 0.5 - rect.y - flow.cardHeight*0.5
            // 判断中心距离（勾股定理）
            var width = Math.abs(x)
            var height = Math.abs(y)
            var distance = Math.sqrt(width*width + height*height)
            var stat = false
            if(distance < radius){
                stat = true
            }
            callback(stat)
        }


       // 监听宽度变化，如果变化则需要进行重新布局
        onWidthChanged: {
//            console.log(width)
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
//                Behavior on rotation { NumberAnimation { duration: flow.duration }}
//                Behavior on width { NumberAnimation { duration: flow.duration }}
//                Behavior on height { NumberAnimation { duration: flow.duration }}
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
                        // 排除重复点击
                        if(flow.cards.indexOf(item) === flow.selectNum)return
                        // 在这里处理位置(如果布局已经重置，则不再执行)
                        if(flow.selectNum === 10000){
                            flow.resetLayout()
                            // 如果选中的是重置的卡片做延时处理
                            if(flow.selects.indexOf(item) !== -1){
                                // 标记第一次正在重置卡片状态
                                flow.isReset = true

                                destroyer.delay(1,function after(){
                                    // 记录卡片在数组中的位置、卡片的坐标
                                    flow.selectedX = item.x
                                    flow.selectedY = item.y
                                    flow.selectedW = item.width
                                    flow.selectedH = item.height
                                    flow.selectNum = flow.cards.indexOf(item)
                                    if(flow.selects.indexOf(item) != -1){
                                        flow.selectedaAngle = item.rotation
                                    }
                                    // 更改选中的卡片位置大小
                                    item.width = flow.radius*0.6
                                    item.height = flow.radius*0.8

                                    item.x = flow.width*0.5-item.width*0.5
                                    item.y = flow.height*0.5-item.height*0.5
                                    item.scale = 1.5
                                    item.rotation = 0
                                })
                                return;
                            }
                        }else{
                            // 还原
                            var itm = flow.cards[flow.selectNum]
                            itm.x = flow.selectedX
                            itm.y = flow.selectedY
                            itm.width = flow.selectedW
                            itm.height = flow.selectedH
                            itm.scale = 1.0
                            if(flow.selects.indexOf(itm) != -1){
                                itm.rotation = flow.selectedaAngle
                                itm.scale = 0.8
                            }
                        }
                        // 记录卡片在数组中的位置、卡片的坐标
                        flow.selectedX = item.x
                        flow.selectedY = item.y
                        flow.selectedW = item.width
                        flow.selectedH = item.height
                        flow.selectNum = flow.cards.indexOf(item)
                        if(flow.selects.indexOf(item) != -1){
                            flow.selectedaAngle = item.rotation
                        }
                        // 更改选中的卡片位置大小
                        item.width = flow.radius*0.6
                        item.height = flow.radius*0.8
                        item.x = flow.width*0.5-item.width*0.5
                        item.y = flow.height*0.5-item.height*0.5
                        item.scale = 1.5
                        item.rotation = 0
                    }
                }
//                Image {
//                    id: displayImage
//                    anchors.fill: parent
//                    source: "../images/0" + WaterFall.random(10) +".png"
//                }
            }
        }
    }
    // 定时器（创建卡片、销毁卡片）
    Timer{
        id: builder
        repeat: true
        interval: 5
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
    // 延时、停止、
    Item {
        id: destroyer
        Timer{
            id: timer
        }
        function delay(delayTime,callback){
            timer.interval = delayTime*1000;
            timer.repeat = false;
            timer.triggered.connect(callback);
            timer.restart()
        }
        function stop(){
            timer.stop()
        }
    }
    // 定时随机销毁
    Item {
        id: disappear
        Timer{
            id: disappear_timer
            repeat: true
            running: false
            triggeredOnStart: false
        }
        function willStart(time,callback){
            disappear_timer.interval  = time * 1000
            disappear_timer.triggered.connect(callback)
            disappear_timer.start()
        }
    }
}
