import QtQuick 2.7
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.2
import PokeApp.Classes.Core 1.0
import "../Pages"

Item {
    id: cardsTableView
    objectName: "cardsTableView"
    property string searchBoxText: ""
    property string cardImageUrl: ""
    property string cardInAlbum: ""
    property string cardCondition: ""
    property string cardStatus: ""
    property int cardID
    signal rowDoubleClicked(string cardImageUrl)
    z: 20

    Rectangle {
        id: tableArea
        anchors.fill: parent
        color: "#FFFFFF"
        radius: 2

        // Table
        TableView {
            id: cardsTable
            objectName: "cardsTable"
            frameVisible: false
            sortIndicatorVisible: true
            z: 20
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            style: TableViewStyle  {
                headerDelegate: Rectangle {
                    height: 30
                    width: headerTextItem.implicitWidth
                    color: "#FFFFFF"
                    Text {
                        id: headerTextItem
                        anchors.fill: parent
                        font.family: "Quicksand"
                        font.pointSize: 12
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: styleData.textAlignment
                        anchors.leftMargin: 6
                        text: styleData.value
                        elide: Text.ElideRight
                        color: "#474747"
                        renderType: Text.NativeRendering
                    }
                    Rectangle {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        anchors.topMargin: 1
                        width: 1
                        color: "#ccc"
                    }
                }
                rowDelegate: Rectangle {
                    color: styleData.selected ? "#63beff" : (styleData.alternate? "#f4f4f4" : "#fff")
                }
            }

//            // Table columns
//            TableViewColumn {
//                id: idColumn
//                role: "ID"
//                title: "ID"
//                width: 40
//                delegate: Text {
//                    anchors.fill: parent
//                    font.family: "Quicksand"
//                    font.pointSize: 10
//                    verticalAlignment: Text.AlignVCenter
//                    horizontalAlignment: styleData.textAlignment
//                    anchors.leftMargin: 6
//                    elide: Text.ElideRight
//                    color: styleData.selected ? "#FFFFFF" : "#474747"
//                    renderType: Text.NativeRendering
//                    text: styleData.value
//                }
//            }
            TableViewColumn {
                id: nameColumn
                role: "name"
                title: "Name"
                width: 100
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: supertypeColumn
                role: "supertype"
                title: "Supertype"
                width: 80
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: subtypeColumn
                role: "subtype"
                title: "Subtype"
                width: 80
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: setNameColumn
                role: "setName"
                title: "Set"
                width: 100
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: seriesColumn
                role: "series"
                title: "Series"
                width: 70
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: cardIDColumn
                role: "cardID"
                title: "ID"
                width: 50
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: rarityColumn
                role: "rarity"
                title: "Rarity"
                width: 100
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: artistColumn
                role: "artist"
                title: "Artist"
                width: 90
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: statusColumn
                role: "status"
                title: "Status"
                width: 90
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: conditionColumn
                role: "condition"
                title: "Condition"
                width: 90
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }
            TableViewColumn {
                id: albumColumn
                role: "albumMID"
                title: "Album"
                width: 90
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: styleData.value
                }
            }


//            TableViewColumn {
//                id: cardAddedColumn
//                role: "cardAdded"
//                title: "Added on"
//                width: 120
//            }

//            TableViewColumn {
//                id: cardEditedColumn
//                role: "cardEdited"
//                title: "Edited on"
//                width: 120
//            }

            TableViewColumn {
                title: "Added"
                width: 120
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: Qt.formatDateTime(cardsManager.getAdded(model.ID),'dd/MMM/yy HH:mm')
                }
            }

            TableViewColumn {
                title: "Last edited"
                width: 120
                delegate: Text {
                    anchors.fill: parent
                    font.family: "Quicksand"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: styleData.textAlignment
                    anchors.leftMargin: 6
                    elide: Text.ElideRight
                    color: styleData.selected ? "#FFFFFF" : "#474747"
                    renderType: Text.NativeRendering
                    text: Qt.formatDateTime(cardsManager.getEdited(model.ID),'dd/MMM/yy HH:mm')
                }
            }

            // Table model
            model: ProxyModel {
                id: cardsProxyModel
                source: cardsModel.count > 0 ? cardsModel : null

                sortOrder: cardsTable.sortIndicatorOrder
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: cardsModel.count > 0 ? cardsTable.getColumn(cardsTable.sortIndicatorColumn).role : ""

                filterString: "*" + cardsTableView.searchBoxText + "*"
                filterSyntax: ProxyModel.Wildcard
                filterCaseSensitivity: Qt.CaseInsensitive
            }

            // Table signal
            onDoubleClicked: {
                cardsTableView.cardID = cardsProxyModel.get(row).ID;
                cardsTableView.cardImageUrl = cardsProxyModel.get(row).imageURL;
                cardsTableView.cardInAlbum = cardsProxyModel.get(row).albumMID;
                cardsTableView.cardCondition = cardsProxyModel.get(row).condition;
                cardsTableView.cardStatus = cardsProxyModel.get(row).status;
                cardsTableView.rowDoubleClicked(cardsProxyModel.get(row).imageURL);
//                console.log("cardsTable.rowDoubleClicked(cardImageUrl) signal sent " + cardsProxyModel.get(row).imageURL);
            }
        }
    }
    // Table shadow
    DropShadow {
        anchors.fill: tableArea
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#22000000"
        source: tableArea
        z: 3
    }

    // Connection
    Connections {
        id: cardsTableViewConnection
        target: cardsPage
        onSearch: {
            cardsTableView.searchBoxText = cardsPage.searchFieldText
        }
    }
}
