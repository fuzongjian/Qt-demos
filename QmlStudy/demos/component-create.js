var component;
var _parent;
var _callback;
function createImageObject(source,parent,callback) {

    _parent = parent;
    _callback = callback;

    component = Qt.createComponent(source);
    if(component.status === Component.Ready || component.status === Component.Error){
        finishCreation();
    }else{
        component.statusChanged.connect(finishCreation);
    }
}
function finishCreation(){
    if(component.status === Component.Ready){
        var image = component.createObject(_parent,{"x": 10, "y": 10});
        if(image === null){
            console.log("Error creating iamge");
        }else{
            _callback(image);
        }
    }else if(component.status === Component.Error){
        console.log("Error loading component:" + component.errorString());
    }
}
