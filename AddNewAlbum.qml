import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {
    id: addNewAlbum
    Rectangle {
        id: addNewAlbumContainer
        height: 30
        width: 400
        color: "Transparent"
        z: 3

        // Text field
        Rectangle {
            id: addTextFieldRec
            anchors.top: parent.top
            anchors.left: parent.left
            height: 30
            width: 200
            z: 3
            color: 'Transparent'
            TextField {
                id: addTextField
                anchors.fill: parent
                placeholderText: qsTr("Album name")
                onAccepted:albumsManager.addAlbum(addTextField.text);
            }
        }

        // Add button
        Rectangle {
            id: addButton
            anchors.top: parent.top
            anchors.right: parent.right
            height: 30
            width: 200
            z: 3
            color: "#FFFFFF"
            Text {
                id: newIconText
                text: "Create new album"
                color: "#474747"
                font.pointSize: 12
                font.family: "Quicksand"
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.right: parent.right
                anchors.rightMargin: 20
            }
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onClicked: albumsManager.addAlbum(addTextField.text);
            }
        }
    }

    DropShadow {
        anchors.fill: addNewAlbumContainer
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: addNewAlbumContainer
        z: 3
    }
}
