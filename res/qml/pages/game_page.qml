import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0


import common 1.0
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
    property int animCellCount
    property bool doTileAnimation: false
    property bool statusWinLose: false


    // ----- Signal declarations
    signal levelUp( int currentLevel )

    // ----- Size information
    // ----- Then comes the other properties. There's no predefined order to these.
    onAnimCellCountChanged: {
        if (animCellCount === 0) {

            animCellCount = AppSingleton.cellsCount
            /// @note all cell animation finished
            if (root.statusWinLose){
                root.currentLevel++
                root.levelUp( currentLevel )
                root.statusWinLose = false
            }
            root.moves = 0
            Logic.fillModelFromLevels( workModel,currentLevel )
        }
    }
    onCurrentLevelChanged: {
        currentLevel= ((currentLevel >= 0) && (currentLevel < 50)) ? currentLevel : 0
    }

    onMovesChanged: {
        if (moves >0){
            if (moves < 99){
                if ( Logic.isWinGame( workModel) ){
                    root.animCellCount = AppSingleton.cellsCount
                    root.doTileAnimation = true
                    root.statusWinLose = true
                }
            }else{
                /// start lose animation
                root.statusWinLose = false
                root.doTileAnimation = true
            }
        }
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
        Logic.fillModelFromLevels( workModel,currentLevel )
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
                    id:levelPanel
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  72 * DevicePixelRatio
                    Layout.preferredHeight: 64 * DevicePixelRatio
                    opacity: 0.9
                    ColumnLayout {
                        id:levelBoxColLayout
                        Item {
                            // spacer item
                            Layout.fillWidth: true
                            Layout.preferredHeight:  5 * DevicePixelRatio
                        }
                        InfoLabel {
                            id:textScore
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                            font.pointSize: AppSingleton.averageFontSize
                            text:qsTr("Level")
                        }
                        Item {
                            // spacer item
                            Layout.fillWidth: true
                            Layout.preferredHeight:  5 * DevicePixelRatio
                        }
                        InfoLabel {
                            id:valueLevel
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                            font.pointSize: AppSingleton.middleFontSize
                            text:root.currentLevel + 1
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
                        Logic.fillModelFromLevels(workModel,currentLevel)
                    }
                }
                BaseButton{
                    id:testButton

                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                    Layout.preferredWidth:  64 * DevicePixelRatio
                    Layout.preferredHeight: 24 * DevicePixelRatio
                    text: qsTr("TEST")
                    onClicked: {

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
                        startAimation: root.doTileAnimation
                        delayWin: model.delayWin
                        delayLose: model.delayLose
                        statusWinLose:root.statusWinLose

                        onClicked:{
                            explosion.parent = this
                            explosion.explode()
                            model.cell = (model.cell) ? 0 : 1
                            Logic.clickOnTile(workModel,x_pos,y_pos)
                            moves ++
                        }
                        onAnimationFinished: {
                            root.animCellCount--
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
            visible: isDebugMode
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
                    //Text { text: delay; anchors.horizontalCenter: parent.horizontalCenter }
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
    ListModel{
        id:workModel
    }
    Explosion {
        id: explosion
    }
}
