import QtQuick 2.7
import QtGraphicalEffects 1.0

// MAIN BAR
Rectangle {
    id: mainBar
    color: "Transparent"
    Rectangle {
        id: mainBarArea
        color: "#FFFFFF"
        height: 60
        width: parent.width
        anchors.top: parent.top
        z:3
        Text {
            anchors.centerIn: parent
            text: "PokéManager"
            font.pointSize: 16
            font.family: "Quicksand"
        }
        Text {
            id: menuButton
            text: "\uf0c9"
            color: "#777777"
            font.pointSize: 10
            font.family: fontAwesome.name
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onClicked: window.showSideBar(1);
            }
        }
    }

}

