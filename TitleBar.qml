import QtQuick 2.0
import QtQuick.Window 2.0

Rectangle {
    id: customWindowFrame
    color: "#474747"
    height: 20
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    radius: 5
    property QtObject container
    MouseArea {
            id: titleBarMouseRegion
            property var clickPos
            anchors.fill: parent
            onPressed: {
                clickPos = { x: mouse.x, y: mouse.y }
            }
            onPositionChanged: {
                container.x = mousePosition.cursorPos().x - clickPos.x
                container.y = mousePosition.cursorPos().y - clickPos.y
            }
        }

    Rectangle {
        id: customWindowFrameBottom
        color: "#474747"
        height: customWindowFrame.radius
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z:0
    }
    Rectangle {
        id: closeWindowButton
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.topMargin: 2
        anchors.rightMargin: 8
        anchors.bottomMargin: 2
        color: "transparent"
        width: 18

        Text {
            id: closeWindowButtonIcon
            text: "\uf2d3"
            color: "#c4c4c4"
            font.pointSize: 10
            font.family: fontAwesome.name
            anchors.centerIn: parent
        }
        MouseArea {
            id: closeWindowButtonMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: closeWindowButtonIcon.color = "#FFFFFF";
            onExited: closeWindowButtonIcon.color = "#c4c4c4";
            onClicked: {
                applicationWindow.close();
            }
        }
    }
    Rectangle {
        id: resizeWindowButton
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: closeWindowButton.left
        anchors.topMargin: 2
        anchors.rightMargin: 2
        anchors.bottomMargin: 2
        color: "transparent"
        width: 18
        Text {
            id: resizeWindowButtonIcon
            text: "\uf2d0"
            color: "#c4c4c4"
            font.pointSize: 10
            font.family: fontAwesome.name
            anchors.centerIn: parent
        }
        MouseArea {
            id: resizeWindowButtonMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: resizeWindowButtonIcon.color = "#FFFFFF";
            onExited: resizeWindowButtonIcon.color = "#c4c4c4";
            onClicked: {
                if(applicationWindow.visibility === Window.FullScreen)
                {

                    applicationWindow.visibility = Window.Windowed;

                }
                else if(applicationWindow.visibility === Window.Windowed)
                {
                    applicationWindow.visibility = Window.FullScreen;

                }
            }
        }
    }
    Rectangle {
        id: minimizeWindowButton
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: resizeWindowButton.left
        anchors.topMargin: 2
        anchors.rightMargin: 2
        anchors.bottomMargin: 2
        color: "transparent"
        width: 18
        Text {
            id: minimizeWindowButtonIcon
            text: "\uf2d1"
            color: "#c4c4c4"
            font.pointSize: 10
            font.family: fontAwesome.name
            anchors.centerIn: parent
        }
        MouseArea {
            id: minimizeWindowButtonMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: applicationWindow.visibility = Window.Minimized;
            onEntered: minimizeWindowButtonIcon.color = "#FFFFFF";
            onExited: minimizeWindowButtonIcon.color = "#c4c4c4";
        }
    }
}
