import QtQuick 2.15
import QtGraphicalEffects 1.0


import common 1.0

Rectangle {
    id:root

    property int idx
    property int x_pos: 0
    property int y_pos: 0
    property int delay
    property bool isPressed: mouseArea.pressed
    property bool lighting: false
    property bool startAimation: false

    height: 48 * DevicePixelRatio
    width: 48 * DevicePixelRatio
    border.color: lighting ? "black": "steelblue"
    border.width: 2* DevicePixelRatio
    radius: lighting ? 30 : 5
    smooth: true

    signal clicked
    signal animationFinished

    onStartAimationChanged: {

        (startAimation) ? _anim.restart() :_anim.stop()
    }

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

        PropertyAnimation {
            target: root
            property: "color"
            to: "black"
            duration: AppSingleton.timer100
        }
        PropertyAnimation {
            target: root
            property: "lighting"
            to: false
        }
        PauseAnimation {duration: root.delay}
        ScaleAnimator {
            target: root
            from: 1.0
            to: 0.5
            duration: AppSingleton.timer100
        }
        ParallelAnimation{
            ScaleAnimator {
                target: root
                from: 0.5
                to: 1.2
                duration: AppSingleton.timer100
            }
            /**
              @link https://www.appsloveworld.com/cplus/100/156/animating-the-color-of-qml-rectangles-after-a-button-is-clicked
            */
            PropertyAnimation {
                target: root
                property: "color"
                from:"black"
                to: "green"
                duration: AppSingleton.timer100
            }
        }
        ScaleAnimator {
            target: root
            from: 1.2
            to: 1.0
            duration: AppSingleton.timer100
        }
        onFinished: {
            root.animationFinished()
        }
    }
}

