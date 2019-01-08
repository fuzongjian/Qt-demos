import QtQuick 2.0

Item {
    width: 100
    height: 100
    // 使用Loader动态加载组件
    Loader{
        id: myLoader
        source: "LoaderItem.qml"
    }
    Connections{
        target: myLoader.item
        onMessage:console.log(msg+" good")
    }
}
