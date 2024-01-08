import QtQuick 2.15
import QtQuick.Timeline 1.0
import QtQuick.Controls 2.15

Rectangle {
    width: 500
    height: 400
    visible: true

    Component {
        id: keyframeComponent
        KeyframeGroup {
            property int startFrame: 0
            property int endFrame: 0
            property int startValue: 0
            property: "height"
            Keyframe { frame: startFrame; value: startValue }
            Keyframe { frame: (startFrame + endFrame) / 2; value: 300 }
            Keyframe { frame: endFrame; value: startValue }
        }
    }
    Row {
        width: parent.width
        height: 300
        spacing: 1
        Repeater {
            model: 10
            Rectangle {
                id: rect
                width: 49
                height: Math.round(Math.random() * parent.height)
                color: "orange"
                Component.onCompleted: {
                    var startFrame = Math.round(Math.random() * 100);
                    var endFrame = Math.round(Math.random() * 100);
                    if(startFrame > endFrame)
                    {
                        var temp = endFrame;
                        endFrame = startFrame;
                        startFrame = temp;
                    }
                    var group = keyframeComponent.createObject(timelineAnimation, {
                        startFrame: startFrame,
                        endFrame: endFrame,
                        startValue: rect.height,
                    target: rect });
                    timeline.keyframeGroups.push(group);
                }
            }
        }
    }
    Button {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10
        text: "Start"
        onClicked: {
            timelineAnimation.start();
        }
    }

    Timeline {
        id: timeline
        startFrame: 0
        endFrame: 100
        enabled: true

        animations: [
            TimelineAnimation {
                duration: 1000;
                from: 0;
                to: 100;
                running: false;
                id: timelineAnimation
            }
        ]
        keyframeGroups: []
    }
}

