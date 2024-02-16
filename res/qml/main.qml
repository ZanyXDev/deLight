import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.15
import Qt.labs.settings 1.0

import common 1.0
import pages 1.0

import "qrc:/res/js/logic.js" as Logic
import io.github.zanyxdev.delight 1.0

QQC2.ApplicationWindow {
  id: appWnd
  // ----- Property Declarations

  // Required properties should be at the top.
  readonly property int screenOrientation: (isMobile) ? Screen.orientation : Qt.PortraitOrientation
  readonly property bool appInForeground: Qt.application.state === Qt.ApplicationActive
  readonly property real winScale: Math.min(width / 1280.0, height / 720.0)
  property bool appInitialized: false

  // ----- Signal declarations
  signal screenOrientationUpdated(int screenOrientation)

  // ----- Size information
  width: (screenOrientation === Qt.PortraitOrientation) ? 320 * DevicePixelRatio : 480
                                                          * DevicePixelRatio
  height: (screenOrientation === Qt.PortraitOrientation) ? 480 * DevicePixelRatio : 320
                                                           * DevicePixelRatio
  maximumHeight: height
  maximumWidth: width

  minimumHeight: height
  minimumWidth: width
  // ----- Then comes the other properties. There's no predefined order to these.
  visible: true
  visibility: (isMobile) ? Window.FullScreen : Window.Windowed
  flags: Qt.Dialog
  title: qsTr(" ")
  //Screen.orientationUpdateMask: Qt.LandscapeOrientation

  // ----- Then attached properties and attached signal handlers.

  // ----- Signal handlers
  onScreenOrientationChanged: {
    screenOrientationUpdated(screenOrientation)
  }
  Component.onCompleted: {
    AppSingleton.toLog(`DevicePixelRatio :[${DevicePixelRatio}]`)
    timerT1.start()
    AppSingleton.toLog(`Screen height ${height},width ${width}`)
    AppSingleton.toLog(`Qt verion build ${HAL.getAppBuildInfo()}`)
    ///TODO select level and fill Model
  }

  Component.onDestruction: {
    let bgrIndex = mSettings.currentBgrIndex
    bgrIndex++
    mSettings.currentBgrIndex = (bgrIndex < 20) ? bgrIndex : 0
    mSettings.currentLevelId = gamePage.currentLevel
    if (isDebugMode)
      AppSingleton.toLog(`currentLevel: [${gamePage.currentLevel} ]`)
  }

  onAppInForegroundChanged: {
    if (appInForeground) {
      if (!appInitialized) {
        appInitialized = true
      }
    } else {
      if (isDebugMode)
        AppSingleton.toLog(
              `appInForeground: [${appInForeground} , appInitialized: ${appInitialized}]`)
    }
  }

  background: Image {
    id: background
    anchors.fill: parent
    source: Logic.getRandomBgrImage(mSettings.currentBgrIndex)
    fillMode: Image.PreserveAspectCrop
    opacity: 0.8
  }

  // ----- Visual children
   FadeStackLayout {
        id: fadeLayout
        InitPage {
            id:initPage
            onShowNextPage: {
                console.trace()
                AppSingleton.toLog(`onShowNextPage`);
                if (fadeLayout.count > 1){
                    fadeLayout.currentIndex++
                }
            }
        }

        GamePage {
            id:gamePage
        }
        Component.onCompleted: {
            initPage.pageActive= true
        }
    }

  //  ----- non visual children
  Settings {
    id: mSettings
    category: "Settings"
    property int currentBgrIndex
    property alias currentLevelId: gamePage.currentLevel
  }

  Timer {
    id: timerT1
    interval: AppSingleton.timer2000
    repeat: true
    running: false
    onTriggered: {
      if (isDebugMode) {

        // fadeLayout.currentIndex = 1
      } else {
        var idx = fadeLayout.currentIndex

        if (idx < fadeLayout.count) {
          idx++
        }
        if (idx == fadeLayout.count) {
          idx = 0
        }
        fadeLayout.currentIndex = idx
      }
    }
  }

  // ----- JavaScript functions
}

/**
    Item {
  splashScreen
      /**
       //3..2..1..go
                  Timer {
                      id: countdownTimer
                      interval: 1000
                      running: root.countdown < 5
                      repeat: true
                      onTriggered: root.countdown++
                  }
                  Repeater {
                      model: ["content/gfx/text-blank.png", "content/gfx/text-3.png", "content/gfx/text-2.png", "content/gfx/text-1.png", "content/gfx/text-go.png"]
                      delegate: Image {
                          visible: root.countdown <= index
                          opacity: root.countdown == index ? 0.5 : 0.1
                          scale: root.countdown >= index ? 1.0 : 0.0
                          source: modelData
                          Behavior on opacity { NumberAnimation {} }
                          Behavior on scale { NumberAnimation {} }
                      }
                  }


    }
  */

