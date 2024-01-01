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
  property bool isWin: false
  property bool isPressed: mouseArea.pressed

  height: 48 * DevicePixelRatio
  width: 48 * DevicePixelRatio

  border.width: 2 * DevicePixelRatio
  smooth: true

  signal clicked
  signal animationFinished()

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton
    onClicked: root.clicked()
  }

  state: "lightOFF"
  states: [
    State {
      name: "lightON"
      PropertyChanges {
        target: root
        color: "steelblue"
        border.color: "black"
        radius: 32
      }
    },
    State {
      name: "lightOFF"
      PropertyChanges {
        target: root
        color: "black"
        border.color: "steelblue"
        radius: 8
      }
    },
    State {
      name: "lightBLK"
      PropertyChanges { target: root; scale: 1.2 }
      PropertyChanges {
        target: root
        color: root.isWin ? "darkgreen": "darkred"
        border.color: "darkgrey"
        radius: 8
      }
      StateChangeScript{
        name: "changeStateScript"
        script: {
         // root.state = "lightOFF"
        }
      }
    }
  ]
  transitions:[
    Transition {
      to: "lightON"
      reversible: true
      ParallelAnimation {
        ColorAnimation { property: "color"; duration: AppSingleton.timer500 }
        ColorAnimation { property: "border.color"; duration: AppSingleton.timer500 }
        NumberAnimation {
          property: "radius"
          easing.type: Easing.InOutCubic
          duration: AppSingleton.timer500
        }
      }
    },
    Transition {
      to: "lightBLK"
      SequentialAnimation{
        PauseAnimation {
          duration: (root.isWin) ? root.delayWin : root.delayLose
        }
        ParallelAnimation {
          NumberAnimation {
            property: "scale"
            duration: AppSingleton.timer200
            easing.type: Easing.InOutBounce
          }
          ColorAnimation { property: "color"; duration: AppSingleton.timer500 }
          ColorAnimation { property: "border.color"; duration: AppSingleton.timer500 }
          NumberAnimation {
            property: "radius"
            easing.type: Easing.InOutCubic
            duration: AppSingleton.timer500
          }
        }
        onFinished: {
          root.animationFinished( )
        }
      }
    }
  ]
}
