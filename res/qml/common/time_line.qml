import QtQuick 2.15

Item {
  id: root
  property alias keyFrameInterval: frameTimer.interval
  property alias running: frameTimer.running
  property ListModel m_model
  property int frameMin
  property int frameMax
  property int frameCurrent: 0
  property string m_state

  property bool active: (m_model !== undefined) && (m_state !== undefined)
                        && (m_model.count <= frameMax)
  signal finished

  onFrameCurrentChanged: {
    if (frameCurrent > frameMax) {
      finished()
    }
  }

  Timer {
    id: frameTimer

    onTriggered: {
      if (root.active && (frameCurrent <= frameMax)) {
        m_model.setProperty(frameCurrent, "m_state", m_state)
        frameCurrent++
      }
    }
  }
}
