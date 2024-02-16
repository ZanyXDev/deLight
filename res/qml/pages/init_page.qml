import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import common 1.0


QQC2.Page  {
    id: root

    // ----- Property Declarations
    // Required properties should be at the top.


    // ----- Signal declarations
    signal showNextPage
    property bool pageActive: false
    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.

    onPageActiveChanged: {
        AppSingleton.toLog(`InitPage.pageActive [${root.pageActive}]`)
        if (root.pageActive === true){
            showAnimation.start()
        }
    }

    Component.onCompleted: {
        AppSingleton.toLog(`InitPage [${root.height}h,${root.width}w]`)
    }
    // ----- Visual children.
    background: {
        null
    }

    LogoItem {
        id: logoItem
        width: parent.width * 0.9
        height: parent.height * 0.9
        imageLogo: "qrc:/res/images/delight_logo.png"
        anchors {
            topMargin: 90 * DevicePixelRatio
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        opacity: 0
        z: 1
        visible: false
    }

    AppVersionTxt {
        id: appVerText
        text: "v. " + AppVersion
        color: "white"
        z: 1
        opacity: 0
        visible: false
        anchors {
            bottom: parent.bottom
            bottomMargin: 20 * DevicePixelRatio
            right: parent.right
            rightMargin: 20 * DevicePixelRatio
        }
    }

    // ----- Qt provided non-visual children


    SequentialAnimation {
        id: showAnimation
        PropertyAction {
            targets: [logoItem, appVerText]
            property: "visible"
            value: true
        }
        NumberAnimation {
            targets: [logoItem, appVerText]
            properties: "opacity"
            from: 0
            to: 1
            duration: AppSingleton.timer2000
            easing.type: Easing.Linear
        }
        ScriptAction {
            script: autoStartTimer.start()
          }


    }
    Timer {
       id: autoStartTimer
       interval: AppSingleton.timer2000
       repeat: false
       running: false
       onTriggered: {
        root.showNextPage()
       }
     }

}
