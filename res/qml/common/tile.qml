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
    property alias snailAnimation:_anim
    property int delay

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

    SequentialAnimation {
        id: _anim

        PauseAnimation {duration: root.delay}
        ScaleAnimator {
            target: root
            from: 1.0
            to: 0.5
            duration: AppSingleton.timer200
        }
        ParallelAnimation{
            ScaleAnimator {
                target: root
                from: 0.5
                to: 1.2
                duration: AppSingleton.timer200
            }
            /**
              @link https://www.appsloveworld.com/cplus/100/156/animating-the-color-of-qml-rectangles-after-a-button-is-clicked
            */
            PropertyAnimation {
                target: root
                property: "color"
                from:"black"
                to: "green"
                duration: AppSingleton.timer200
            }
        }
        ScaleAnimator {
            target: root
            from: 1.3
            to: 1.0
            duration: AppSingleton.timer200
        }
    }
}

