import QtQuick 2.14
import QtQuick.Window 2.14
import QtMultimedia 5.14

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    Rectangle {
        anchors.fill: parent
        color: "lightblue"
        Text {
            text: "Click Me!";
            font.pointSize: 24;
            width: 150; height: 50;

            Audio {
                id: playMusic
                source: "https://phubq.com/upload/EA/toeic_practice/part1/toeic_practice_p1_s10_0.mp3"
                onPlaybackStateChanged: {
                    console.log("Current status: " + playMusic.playbackState)
                    console.log("Duration: " + playMusic.duration)
                }
            }
            MouseArea {
                id: playArea
                anchors.fill: parent
                onPressed:  { playMusic.play() }
            }
        }
    }
}
