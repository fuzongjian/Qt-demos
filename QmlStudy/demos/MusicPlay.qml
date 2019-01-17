import QtQuick 2.0
import QtMultimedia 5.5
Item {
    Text{
        text: "Click Me!"
        font.pixelSize: 24
        width: 150
        height: 50
    }
    MediaPlayer{
        id: playMusic
        autoPlay: true
        source: "../resources/bg music.ogg"
    }
    MouseArea{
        id: playArea
        anchors.fill: parent
        onPressed: {
            console.log("start")
            playMusic.play()
        }
    }
}
