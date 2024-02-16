import QtQuick 2.15
import effects.shine 1.0

Item {
  id: root
  property alias imageLogo: imgLogo.source

  Image {
    id: imgLogo
    sourceSize {
      width: root.width
      height: root.height
    }
    Shine {
      anchors {
        leftMargin: 10 * DevicePixelRatio
        topMargin: 10 * DevicePixelRatio
      }
    }
  }

}
