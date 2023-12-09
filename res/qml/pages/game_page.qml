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

    property int currentLevel: 1
    property int moves: 0
    property int score: 0
    property var animateFuncs: ([ ])

    // ----- Signal declarations
    signal levelUp( int currentLevel )

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    onCurrentLevelChanged: {
        if (isDebugMode){
            AppSingleton.toLog(`onCurrentLevelChanged ${currentLevel}`)
        }
        currentLevel= ((currentLevel > 1) && (currentLevel < 51)) ? currentLevel : 1
        Logic.fillModelFromLevel(levelsModel,workModel,currentLevel)
        root.levelUp( currentLevel )
    }

    onPageActiveChanged: {
        if (isDebugMode){
            AppSingleton.toLog(`GamePage.onActivated pageActive ${pageActive}`)
        }
    }
    // ----- Visual children.
    background: {
        null
    }
    Component.onCompleted: {
        Logic.fillModelFromLevel(levelsModel,workModel,currentLevel)
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
                    Layout.preferredWidth:  72 * DevicePixelRatio
                    Layout.preferredHeight: 24 * DevicePixelRatio
                    text: qsTr("NEW_TR")
                    onClicked: {
                        Logic.fillModelFromLevel(levelsModel,workModel,currentLevel)
                    }
                }
                BaseButton{
                    id:testButton

                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  64 * DevicePixelRatio
                    Layout.preferredHeight: 24 * DevicePixelRatio
                    text: qsTr("TST_ANI")
                    onClicked: {
                        Logic.clearAll(workModel)
                        let pick = Math.floor(Math.random() * 6);
                        animateFuncs[pick](0);
                        animateFuncs[pick+1](300);
                        animateFuncs[pick+2](600);
                        animateFuncs[pick+3](900);
                        animateFuncs[pick+4](1200);
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
                    model:workModel
                    delegate:Tile{
                        id :_rect
                        idx: index
                        x_pos: idx % 5
                        y_pos: idx / 5
                        lighting: model.cell

                        onClicked:{
                            explosion.parent = this
                            explosion.explode()
                            moves ++
                            model.cell = (model.cell) ? 0 : 1
                            Logic.clickOnTile(workModel,x_pos,y_pos)
                            if ( Logic.isWinGame(workModel) ){
                                currentLevel++
                            }
                        }
                        SequentialAnimation {
                            id: anim
                            property int delay
                            PauseAnimation {duration: anim.delay}
                            NumberAnimation {
                                target: _rect
                                property: "height"
                                from: 50
                                to: 150
                            }
                            NumberAnimation {
                                target: _rect
                                property: "height"
                                from: 150
                                to: 50
                            }
                        }
                        function animateWithDelay(delay) {
                            anim.delay = delay;
                            anim.start();
                        }
                        Component.onCompleted: {
                            animateFuncs[index] = animateWithDelay
                        }
                    }
                }
            }
        }
        Item {
            // spacer item
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        ProportionalRect{
            id:debugGrid
            Layout.fillWidth: true
            Layout.preferredHeight: 42 * DevicePixelRatio
            Layout.alignment:  Qt.AlignHCenter
            GridView {
                id:grid
                anchors.fill: parent
                anchors.leftMargin: 24 * DevicePixelRatio
                cellWidth: grid.width/5       // if you want 2 columns for example
                cellHeight: grid.height/5     //
                model: workModel
                delegate: Column {
                    Text { text: cell; anchors.horizontalCenter: parent.horizontalCenter }
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
    ListModel{
        id:workModel
    }
    Explosion {
        id: explosion
    }

    ParallelAnimation {
        id:winAnim
        PauseAnimation {
            duration: AppSingleton.timer200
        }
        ScriptAction { script: clearAll(); }
    }

}
