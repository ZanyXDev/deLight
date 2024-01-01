import QtQuick 2.15
import QtGraphicalEffects 1.0
import common 1.0

Rectangle {
  id: root

  property int idx
  property int x_pos: 0
  property int y_pos: 0
  property int delayWin
  property int delayLose
  property bool isPressed: mouseArea.pressed

  height: 48 * DevicePixelRatio
  width: 48 * DevicePixelRatio

  border.width: 2 * DevicePixelRatio
  smooth: true

  signal clicked

  MouseArea {
    id: mouseArea
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
      property: "lighting"
      to: false
    }
    PropertyAnimation {
      target: root
      property: "color"
      to: "black"
      duration: AppSingleton.timer100
    }

    PauseAnimation {
      duration: (statusWinLose) ? root.delayWin : root.delayLose
    }
    ScaleAnimator {
      target: root
      from: 1.0
      to: 0.5
      duration: AppSingleton.timer100
    }
    ParallelAnimation {
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
        from: "black"
        to: (statusWinLose) ? "green" : "darkorange"
        duration: AppSingleton.timer100
      }
    }
    ParallelAnimation {
      ScaleAnimator {
        target: root
        from: 1.2
        to: 1.0
        duration: AppSingleton.timer100
      }
      PropertyAnimation {
        target: root
        property: "color"
        from: (statusWinLose) ? "green" : "darkorange"
        to: "black"
        duration: AppSingleton.timer100
      }
    }
    onFinished: {
      root.animationFinished()
    }
  }
  state: "lightOFF"
  states: [
    State {
      name: "lightON"
      PropertyChanges {
        target: root
        color: "steelblue"
        border.color: "black"
        radius: 30
      }
    },
    State {
      name: "lightOFF"
      PropertyChanges {
        target: root
        color: "black"
        border.color: "steelblue"
        radius: 5
      }
    }
  ]
  transitions: Transition {
    to: "lightON"
    reversible: true
    ParallelAnimation {
      ColorAnimation {
        property: "color"

        duration: AppSingleton.timer500
      }
      ColorAnimation {
        property: "border.color"

        duration: AppSingleton.timer500
      }
      NumberAnimation {
        property: "radius"
        easing.type: Easing.InOutCubic
        duration: AppSingleton.timer500
      }
    }
  }
}
