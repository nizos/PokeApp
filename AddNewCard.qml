import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {
    id: addNewCard
    Rectangle {
        id: addNewCardContainer
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
            width: 100
            z: 3
            color: 'Transparent'
            TextField {
                id: addTextField
                anchors.fill: parent
                placeholderText: qsTr("Card ID")
                onAccepted:albumsManager.addCard(selectedAlbumComboBox.currentText, addTextField.text);
            }
        }

        // ComboBox
        Rectangle {
            id: selectedAlbum
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 100
            height: 30
            width: 200
            z: 3
            color: 'Transparent'
            ComboBox {
                id: selectedAlbumComboBox
                width: 200
                height: 30
                anchors.top: parent.top
                anchors.left: parent.left
                model: albumsModel
                textRole: 'albumName'
            }
        }

        // Add button
        Rectangle {
            id: addButton
            anchors.top: parent.top
            anchors.right: parent.right
            height: 30
            width: 100
            z: 3
            color: "#FFFFFF"
            Text {
                id: newIconText
                text: "Add card"
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
                onClicked: albumsManager.addCard(selectedAlbumComboBox.currentText, addTextField.text);
            }
        }
    }

    DropShadow {
        anchors.fill: addNewCardContainer
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: addNewCardContainer
        z: 3
    }
}
