import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0


import common 1.0
import datamodels 1.0
import "qrc:/res/js/logic.js" as Logic

QQC2.Page {
    id: root
    // ----- Property Declarations
    // Required properties should be at the top.

    // https://doc.qt.io/qt-5/qtqml-syntax-objectattributes.html#a-note-about-accessing-attached-properties-and-signal-handlers
    property bool pageActive: false
    property ListModel levelsModel:LevelsDataModel{}
    property int currentLevel: 0

    // ----- Signal declarations
    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    onPageActiveChanged: {
        AppSingleton.toLog(`GamePage.onActivated pageActive ${pageActive}`)
        //gameTicTimer.restart()
    }
    // ----- Visual children.
    background: {
        null
    }
    Component.onCompleted: {
        AppSingleton.toLog(`GamePage [${root.height}h,${root.width}w]`)
        gameTicTimer.start()
    }

    //-------------
    GridLayout{
        id:gameGridLayout
        columns: 5
        columnSpacing: 4*DevicePixelRatio
        rowSpacing: 4*DevicePixelRatio

        Repeater {
            model:levelsModel.get(currentLevel).level_model

            delegate:Rectangle{
                property int idx: index
                height: 48 * DevicePixelRatio
                width: 48 * DevicePixelRatio
                border.color: "darkgrey"
                border.width: 2* DevicePixelRatio
                radius: 6*DevicePixelRatio
                smooth: true
                gradient: Gradient {
                    GradientStop { position: 0.0; color: (cell)? "lightblue" :"lightgrey" }
                    GradientStop { position: 1.0; color: (cell)? "steelblue" :"black" }
                }
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 3* DevicePixelRatio
                    verticalOffset: 4* DevicePixelRatio
                    radius: 6
                    samples: 11
                    color: "black"
                    opacity: 0.75
                }
                MouseArea{
                    id:mArea
                    anchors.fill: parent
                    onClicked:{
                        Logic.test(  idx, model.cell )

                        model.cell = (model.cell) ? 0:1
                        levelsModel.get(0).level_model.setProperty(1,"cell",0)

                    }
                }
            }
            Component.onCompleted: {
                AppSingleton.toLog(`Repeater model ${model.count}`)
            }
        }

    }
    QQC2.Button{
        id:test
        anchors.bottom: parent.bottom
        text: "Test"
        onClicked: {

            levelsModel.get(0).level_model.setProperty(1,"cell",0)
        }
    }


    //-------------
    // ----- Qt provided non-visual children

    ListModel{
        id:itemsModel
        ListElement{
            type_id:1
            src: "qrc:/res/images/ball_in_yan.png"
            pos_x: 10
            pos_y: 10
            size_hw: 32
            speed: 1.0
            angle: 10.5
            desc: "ball"
        }
    }

    Timer {
        id: gameTicTimer
        interval: AppSingleton.timer16
        repeat: true
        running: false
        onTriggered: {
            //Logic.updateWord(BallData)
            itemsModel.get(0).pos_x += 1
            //itemsModel.setProperty(1, "pos_x", pos_x + 2)
        }
    }


}
