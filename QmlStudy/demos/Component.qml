import QtQuick 2.0
import "component-create.js" as ImageCreator
Rectangle{
    id: root
    width: 1024
    height: 600
    Component.onCompleted: {
        ImageCreator.createImageObject("component-image.qml",root,function getImage(obj){
            obj.x = 100;
            console.log(obj.x);
        });
    }

}
