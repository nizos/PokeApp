import QtQuick 2.0

Item {
    id: sideBar
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: parent.width
    z: 5

    // Sub Header
    Rectangle {
        id: subHeader
        property int subHeaderAnimDuration: 500
        property int subHeaderWidth: 300
        property int subHeaderSeizurWidth: 15
        anchors.fill: parent
        color: "#FFFFFF"
        z: 5
    }
}
