import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0


import common 1.0
import datamodels 1.0
import effects 1.0

import "qrc:/res/js/logic.js" as Logic

QQC2.Page {
    id: root
    // ----- Property Declarations
    // Required properties should be at the top.

    // https://doc.qt.io/qt-5/qtqml-syntax-objectattributes.html#a-note-about-accessing-attached-properties-and-signal-handlers
    property bool pageActive: false

    property int currentLevel: 0
    property int moves: 0
    property int score: 0

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
    }

    //-------------
    ColumnLayout{
        id: mainVerticalLayout
        anchors.fill: parent
        spacing: 2 *DevicePixelRatio
        component ProportionalRect:Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 1 * DevicePixelRatio
        }
        component InfoLabel:QQC2.Label {
            font { family: AppSingleton.digitalFont.name}
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 2 * DevicePixelRatio
            color:"black"
        }


        ProportionalRect {
            id:boxMoveScore
            Layout.preferredHeight: 64 * DevicePixelRatio
            RowLayout {
                id:infoLayout
                spacing: 5 * DevicePixelRatio
                Item {
                    // spacer item
                    Layout.fillHeight: true
                    Layout.preferredWidth:  5 * DevicePixelRatio
                }
                Item {
                    id:movePanel
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  72 * DevicePixelRatio
                    Layout.preferredHeight: 64 * DevicePixelRatio

                    opacity: 0.9
                    Item {
                        id:movesBox
                        ColumnLayout{
                            id:moveBoxColLayout
                            Item {
                                // spacer item
                                Layout.fillWidth: true
                                Layout.preferredHeight:  5 * DevicePixelRatio
                            }
                            InfoLabel{
                                id:textMoves
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                font.pointSize: AppSingleton.averageFontSize
                                text:qsTr("Moves")
                            }
                            Item {
                                // spacer item
                                Layout.fillWidth: true
                                Layout.preferredHeight:  5 * DevicePixelRatio
                            }
                            InfoLabel {
                                id:valueMoves
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                                font.pointSize: AppSingleton.middleFontSize
                                text: moves
                            }
                        }
                    }
                }
                Item {
                    id:scorePanel
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  72 * DevicePixelRatio
                    Layout.preferredHeight: 64 * DevicePixelRatio
                    opacity: 0.9
                    ColumnLayout {
                        id:scoreBoxColLayout
                        Item {
                            // spacer item
                            Layout.fillWidth: true
                            Layout.preferredHeight:  5 * DevicePixelRatio
                        }
                        InfoLabel {
                            id:textScore
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                            font.pointSize: AppSingleton.averageFontSize
                            text:qsTr("Score")
                        }
                        Item {
                            // spacer item
                            Layout.fillWidth: true
                            Layout.preferredHeight:  5 * DevicePixelRatio
                        }
                        InfoLabel {
                            id:valueScore
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                            font.pointSize: AppSingleton.middleFontSize
                            text:score
                        }
                    }
                }

                BaseButton{
                    id:newGameButton
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  64 * DevicePixelRatio
                    Layout.preferredHeight: 24 * DevicePixelRatio
                    text: "New"
                    onClicked: {

                    }
                }
                BaseButton{
                    id:restartGameButton
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  64 * DevicePixelRatio
                    Layout.preferredHeight: 24 * DevicePixelRatio
                    text: "Restart"
                    onClicked: {
                        explosion.explode()
                    }
                }
                Item {
                    // spacer item
                    Layout.fillHeight: true
                    Layout.preferredWidth:  5 * DevicePixelRatio
                }
            }
        }

        ProportionalRect{
            id:gameGridRectangle
            Layout.fillWidth: true
            Layout.preferredHeight: 262 * DevicePixelRatio
            Layout.alignment:  Qt.AlignHCenter

            GridLayout{
                id:gameGridLayout
                anchors.fill: parent
                anchors.leftMargin: 8 * DevicePixelRatio

                columns: 5
                columnSpacing: 8*DevicePixelRatio
                rowSpacing: 8*DevicePixelRatio

                Repeater {
                    model:levelsModel
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
                            radius: 6 * DevicePixelRatio
                            samples: 11
                            color: "black"
                            opacity: 0.75
                        }
                        MouseArea{
                            id:mouseArea
                            anchors.fill: parent
                            onClicked:{
                                explosion.parent = parent
                                explosion.explode()

                                model.cell = (model.cell) ? 0:1

                                let m_col = model.index  % 5
                                let m_row = Math.floor(model.index / 5 )
                                let m_index;
                                if ( m_col-1 >=0){
                                    m_index = (m_col-1) + (m_row *5 )
                                    levelsModel.setProperty(m_index, "cell", model.cell & 1)
                                }
                                moves ++;

                            }
                        }
                    }
                    Component.onCompleted: {
                        AppSingleton.toLog(`Repeater model ${model.count}`)
                    }
                }
            }

        }
        Item {
            // spacer item
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    //-------------
    // ----- Qt provided non-visual children

    LevelsDataModel{
        id:levelsModel
    }
    Explosion {
        id: explosion
    }

}
