import QtQuick 2.15
import QtQuick.Particles 2.15

// https://russianblogs.com/article/2292554914/
Item {
    anchors.fill: parent

    Rectangle {
        id: target;
        color: "transparent";
        width: parent.width/2;
        height: 100;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: 4;
    }

    function explode(){
        if (particleSystem.running) {
            particleSystem.reset()
        }

        particles.burst(particles.emitRate)
    }

    ParticleSystem {
        id: particleSystem
        anchors.fill: parent
    }

    ImageParticle {
        source: "qrc:/res/images/particle.png"
        system: particleSystem
    }

    Emitter{
        id: particles
        system: particleSystem
        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
        enabled: false
        startTime: 0

        anchors.centerIn: parent
        height:  parent.height / 2
        width: parent.width / 2

        emitRate: 50
        lifeSpan: 1000
        lifeSpanVariation: 2000

        maximumEmitted: 1000
        size: 4
        endSize: 48

        velocity: TargetDirection {
            targetItem: target;
            targetX: target.width/2;
            targetY: 0;
            targetVariation: target.width/2;
            magnitude: 32
        }

    }
}

