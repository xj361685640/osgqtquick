import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0
import osg 2.0 as OSG
import osgDB 2.0  as OSGDB
import osgGA 2.0 as OSGGA
import osgViewer 2.0 as OSGViewer

Rectangle {
    width: 500; height: 500

    OSGDB.Loader {
        id: loader
        source: "axes.osgt"
        onNodeChanged: {
            console.log("loader: " + getNode())
            view.cameraManipulator.home()
        }
    }

    OSG.PositionAttitudeTransform {
        id: group
        position: Qt.vector3d(xSlider.value, ySlider.value, zSlider.value)
        Component.onCompleted: {
            addChild(loader)
            console.log("group: " + group)
        }
    }

    OSGViewer.View {
        id: view
        anchors.fill: parent
        sceneData: group
        cameraManipulator: OSGGA.TrackballManipulator {}
    }

    Button {
        text: "Home"
        onClicked: view.cameraManipulator.home()
    }

    ColumnLayout {
        Slider { id: xSlider; minimumValue: -1; maximumValue: 1; Layout.fillWidth: true }
        Slider { id: ySlider; minimumValue: -1; maximumValue: 1; Layout.fillWidth: true }
        Slider { id: zSlider; minimumValue: -1; maximumValue: 1; Layout.fillWidth: true }
        width: parent.width
        anchors.bottom: parent.bottom
    }
}
