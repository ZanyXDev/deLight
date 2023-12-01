import QtQuick 2.15

import "qrc:/res/js/logic.js" as Logic

ListModel {
    id: root
    ListElement {
        level_id:1
        level_model: [
            ListElement { cell: 1},
            ListElement { cell: 1},
            ListElement { cell: 0},
            ListElement { cell: 1},
            ListElement { cell: 1},
            ListElement { cell: 1},
            ListElement { cell: 0},
            ListElement { cell: 1},
            ListElement { cell: 0},
            ListElement { cell: 1},
            ListElement { cell: 0},
            ListElement { cell: 1},
            ListElement { cell: 1},
            ListElement { cell: 1},
            ListElement { cell: 0},
            ListElement { cell: 1},
            ListElement { cell: 0},
            ListElement { cell: 1},
            ListElement { cell: 0},
            ListElement { cell: 1},
            ListElement { cell: 1},
            ListElement { cell: 1},
            ListElement { cell: 0},
            ListElement { cell: 1},
            ListElement { cell: 1}
        ]
    }


    // @disable-check M16
    onDataChanged: Logic.updateModel(  topLeft, bottomRight, roles )
}
