import QtQuick 2.15

ListModel {
    id: root

    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 0}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 0}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 0}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 0}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 0}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 0}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 0}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 0}
    ListElement {lvl:1;  cell: 1}
    ListElement {lvl:1;  cell: 1}
    // level 2
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
    ListElement {lvl:2;  cell: 0}
    ListElement {lvl:2;  cell: 1}
}

/**
int levels[1250]={
1,1,0,1,1,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,1,1,0,1,1,
0,1,0,1,0,1,1,0,1,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,1,
1,0,0,0,1,1,1,0,1,1,0,0,1,0,0,1,0,1,0,0,1,0,1,1,0,
1,1,0,1,1,0,0,0,0,0,1,1,0,1,1,0,0,0,0,1,1,1,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,0,1,1,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,1,1,0,0,0,
0,0,0,0,0,0,1,1,1,0,1,1,1,1,1,0,1,1,1,0,0,0,0,0,0,
0,0,0,0,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,0,0,0,0,
1,1,0,1,1,1,1,0,1,1,0,0,0,0,0,1,1,0,1,1,1,1,0,1,1,
// 10
1,1,1,1,1,0,1,1,1,0,0,0,1,0,0,0,1,1,1,0,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,1,1,1,1,1,
0,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,0,0,
1,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0,1,0,1,0,1,0,0,0,1,
1,1,1,1,1,1,0,1,0,1,1,1,1,1,1,1,0,1,0,1,1,1,1,1,1,
1,0,0,0,0,0,1,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,
1,0,1,0,1,0,1,0,1,0,0,0,1,0,0,0,1,0,1,0,1,0,1,0,1,
1,1,1,0,1,1,1,1,0,1,0,0,0,0,0,1,0,1,1,1,1,0,1,1,1,
1,1,0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1,1,1,0,1,1,
// 20
1,1,1,1,1,1,0,0,0,1,1,1,0,1,1,1,1,0,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,1,
1,1,1,0,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,1,
1,1,1,1,1,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,1,1,1,1,
0,0,0,0,0,0,1,1,0,0,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,
0,0,0,1,1,0,0,1,1,1,0,0,1,0,0,1,1,1,0,0,1,1,0,0,0,
0,0,0,1,1,1,1,0,1,1,1,1,0,0,0,1,1,0,0,0,1,1,0,1,1,
1,0,0,0,1,0,1,1,1,0,0,1,1,1,0,0,1,1,1,0,1,0,0,0,1,
1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,
0,0,1,0,0,1,0,0,1,0,0,1,1,1,1,1,0,0,0,0,1,1,0,1,0,
// 30
0,0,0,0,1,0,0,0,1,1,0,0,1,0,1,0,1,0,0,1,1,1,1,1,1,
1,1,0,1,1,0,1,0,1,0,1,1,1,1,1,1,1,0,1,1,1,0,0,0,1,
0,1,1,0,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,0,1,1,1,1,0,
0,0,0,0,1,1,1,1,0,0,1,0,1,1,1,1,1,1,1,0,1,0,0,1,0,
1,0,1,1,1,0,0,1,0,1,0,0,0,0,0,1,1,1,1,0,1,1,0,1,0,
1,1,0,1,1,0,1,0,1,1,0,0,0,1,0,1,1,0,0,0,1,1,1,1,0,
1,1,1,1,1,0,0,0,1,0,0,1,0,1,1,1,1,1,0,1,1,0,1,0,0,
0,0,0,1,1,1,0,1,1,0,0,0,1,0,0,0,1,1,1,1,1,0,0,1,0,
0,0,0,0,1,0,0,1,1,1,1,1,0,0,1,1,1,1,0,0,0,0,1,0,0,
0,0,1,1,1,1,0,1,1,1,1,1,1,0,0,0,0,1,0,0,1,1,0,1,1,
// 40
0,1,1,1,1,0,0,1,1,1,0,0,1,1,1,1,1,1,1,0,0,0,0,1,0,
1,1,1,1,1,1,0,0,0,0,0,1,0,0,1,0,0,0,1,1,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,0,1,1,1,0,0,1,0,0,1,
0,0,0,0,0,0,0,0,1,0,1,1,0,1,1,0,1,1,0,0,1,1,1,1,1,
0,0,0,1,1,0,1,1,0,0,0,1,0,0,0,1,1,1,1,0,1,1,1,1,0,
0,0,0,1,0,1,1,1,1,1,0,0,0,0,0,0,0,1,0,0,1,1,1,1,0,
0,1,0,1,0,0,0,0,1,0,0,1,0,1,0,0,0,1,0,0,0,1,1,1,0,
1,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,1,0,0,
1,1,0,0,1,0,1,0,0,1,0,1,1,1,1,0,1,0,1,0,1,1,1,1,1,
1,1,1,1,1,0,0,1,0,0,0,1,1,0,0,0,0,1,1,0,1,1,1,0,1,
1,0,1,0,1,1,0,1,0,0,0,0,0,1,1,0,1,0,1,0,1,0,0,1,0
  */
