import QtQuick 2.0

Rectangle {

    width: 800

    height: 600



    color: "brown"



    Repeater{

        id:myrepeater

        model:2

        Item {



            Timer {

                id: timer



            }



            function delay(delayTime, cb) {

                timer.interval = delayTime;

                timer.repeat = false;

                timer.triggered.connect(cb);

                timer.start();

                }



            Text { id: mytext; text:"test"}



        }

    }







    Rectangle {



        id: rectangle

        color: "yellow"

        anchors.fill: parent

        anchors.margins: 100

        opacity: 0



        Behavior on opacity {

            NumberAnimation {

                duration: 5000

            }

        }

    }



    Rectangle {

        id: rectangle2

        color: "Green"

        anchors.fill: parent

        anchors.margins: 200

        opacity: 0



        Behavior on opacity {

            NumberAnimation {

                duration: 0

            }

        }

    }



    Component.onCompleted: {

        print("I'm printed right away..")

        myrepeater.itemAt(0).delay(2000, function() {

            print("And I'm printed after 2 second!")

            rectangle.opacity = 1

        })

        myrepeater.itemAt(1).delay(5000, function() {

            print("And I'm printed after 5 second!")

            rectangle2.opacity = 1

        })

    }

}
