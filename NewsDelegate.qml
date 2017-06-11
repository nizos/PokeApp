import QtQuick 2.7

Column {
    id: delegate
    width: delegate.ListView.view.width
    spacing: 8

    Item { height: 0; width: delegate.width }

    Row {
        width: parent.width
        spacing: 10

        Text {
            id: newsIcon
            text: "\uf0f6"
            color: "#777777"
            font.pointSize: 8
            font.family: fontAwesome.name
            anchors.top: parent.top
            anchors.topMargin: 6
        }
        Text {
            id: titleText
            textFormat: Text.RichText
            text: "<style>a:link { text-decoration: none; color: #777777;} a:hover { text-decoration: underline; }</style><a href=\"" + link + "\">" + title + "</a>"
            width: delegate.width - newsIcon.width
            wrapMode: Text.WordWrap
            color: "#777777"
            font.pointSize: 10
            font.family: "Quicksand"
            linkColor : "#777777"
            onLinkActivated: {
                Qt.openUrlExternally(link)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: newsIcon.text = "\uf15c"
                onExited: newsIcon.text = "\uf0f6"
                onClicked: Qt.openUrlExternally(link)
            }
        }
    }
}
