import QtQuick 2.0

Item {
    width: 500
    height: 500
    Column{
        id: column
        spacing: 10

        Rectangle{ color: "red"; width: 50; height: 50 }
        Rectangle{ color: "blue"; width: 20; height: 20 }
        Rectangle{ color: "gray"; width: 20; height: 20 }
    }

    Row{
        id: row
        anchors.top: column.bottom
        spacing: 10
        anchors.margins: 10
        Rectangle{ color: "red"; width: 50; height: 50 }
        Rectangle{ color: "red"; width: 50; height: 50 }
        Rectangle{ color: "red"; width: 50; height: 50 }
        Rectangle{ color: "red"; width: 50; height: 50 }
    }

    Grid{
        id: grid
        anchors.top: row.bottom
        columns: 3
        spacing: 10
        anchors.margins: 10

        Rectangle{ color: "red"; width: 50; height: 50 }
        Rectangle{ color: "blue"; width: 50; height: 50 }
        Rectangle{ color: "orange"; width: 50; height: 50 }
        Rectangle{ color: "black"; width: 50; height: 50 }
        Rectangle{ color: "orange"; width: 50; height: 50 }
        Rectangle{ color: "gray"; width: 50; height: 50 }
    }


}
