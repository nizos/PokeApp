import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: viewSubMenu
    property int selectedOption: 0
    signal optionSelected(int selectedOption)
    width: subMenu.width
    height: 30
    z: 2

    Rectangle {
        id: viewSubMenuBanner
        radius: 2
        height: 30
        width: parent.width
        color: "#FFFFFF"

        RowLayout {
            id: viewRow
            height: 30
            width: parent.width
            spacing: 0

            // TABLE VIEW
            Rectangle {
                id: tableViewButton
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Table view"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        viewSubMenu.selectedOption = 0;
                        viewSubMenu.optionSelected(viewSubMenu.selectedOption);
                    }
                }
            }

            // IMAGE VIEW
            Rectangle {
                id: imageViewButton
                color: "Transparent"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Image view"
                    font.pointSize: 12
                    font.family: "Quicksand"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        viewSubMenu.selectedOption = 1;
                        viewSubMenu.optionSelected(viewSubMenu.selectedOption);
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: viewSubMenuBanner
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: viewSubMenuBanner
        z: 3
    }
}
