import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
ApplicationWindow{
    visible: true
    width: 640
    height: 480
    SwipeView{
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

    }
    header: TabBar{
        id: headerTabBar
        currentIndex: swipeView.currentIndex
        TabButton{
            text: "header one"
        }
        TabButton{
            text: "header two"
        }
        TabButton{
            text: "header three"
        }
        TabButton{
            text: "header four"
        }
    }
    footer: TabBar{
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton{
            text: "footer one"
        }
        TabButton{
            text: "footer two"
        }
        TabButton{
            text: "footer three"
        }
        TabButton{
            text: "footer four"
        }
    }
}
