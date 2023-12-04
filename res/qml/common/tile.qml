import QtQuick 2.15
import QtGraphicalEffects 1.0


import common 1.0

Rectangle {
    id:root

    property int idx:  -1
    property int x_pos: 0
    property int y_pos: 0
    property bool isPressed: mouseArea.pressed
    property bool lighting: false

    height: 48 * DevicePixelRatio
    width: 48 * DevicePixelRatio
    border.color: lighting ? "black": "steelblue"
    border.width: 2* DevicePixelRatio
    radius: lighting ? 30 : 5
    smooth: true
    signal clicked

    color:  lighting ? "steelblue": "black"

    Behavior on radius {
        NumberAnimation {
            easing.type: Easing.InOutCubic
            duration: AppSingleton.timer500
        }
    }

    MouseArea{
        id:mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: root.clicked()
    }

}

