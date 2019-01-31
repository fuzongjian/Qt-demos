
function func() {
    return "func"
}
// 随机函数
function random(num){
    var idx = parseInt(Math.random()*num)
    if(idx === 0){
        idx = 1
    }
    return idx
}
// 勾股定理计算
//parentW、parentH、childW、childH、item
//function
