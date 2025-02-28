import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Librum.style
import Librum.fonts

Item {
    id: root
    property bool active: false
    property bool currentlyHovered: mouseArea.containsMouse
    property bool currentlyPressed: mouseArea.pressed

    property string text
    property color textColor: Style.colorUnfocusedButtonText
    property int fontWeight: Font.Bold
    property double fontSize: Fonts.size11
    property color backgroundColor: Style.colorControlBackground
    property double opacityOnPressed: 0.9
    property int borderWidth: 1
    property color borderColor: Style.colorButtonBorder
    property color borderColorOnPressed: borderColor
    property int radius: 4
    property string imagePath
    property int imageSpacing: 8
    property int imageSize: 15
    property int imageLeftMargin: 0
    property int imageRotation: 0
    property int horizontalMargins: 1
    property bool imageToRight: false
    property bool centerContentVertically: true
    property bool centerContentHorizontally: true

    implicitHeight: 30
    implicitWidth: layout.implicitWidth + 2 * horizontalMargins

    signal clicked

    Rectangle {
        id: container
        anchors.fill: parent
        color: root.backgroundColor
        border.width: root.borderWidth
        border.color: mouseArea.pressed ? root.borderColorOnPressed : root.borderColor
        radius: root.radius
        opacity: mouseArea.pressed ? root.opacityOnPressed : 1
        antialiasing: true

        RowLayout {
            id: layout
            anchors.verticalCenter: root.centerContentVertically ? parent.verticalCenter : undefined
            anchors.horizontalCenter: root.centerContentHorizontally ? parent.horizontalCenter : undefined
            spacing: root.imageSpacing

            Image {
                id: imageToLeft
                Layout.leftMargin: root.imageLeftMargin
                visible: root.imagePath.length > 0 && !root.imageToRight
                source: root.imagePath
                sourceSize.width: root.imageSize
                fillMode: Image.PreserveAspectFit
                rotation: root.imageRotation
            }

            Label {
                id: loginButtonText
                visible: text.length > 0
                Layout.preferredWidth: container.width
                                       < implicitWidth ? container.width : implicitWidth
                text: root.text
                font.weight: root.fontWeight
                font.pointSize: root.fontSize
                color: root.textColor
                elide: Text.ElideRight
            }

            Image {
                id: imageToRight
                visible: root.imagePath.length > 0 && root.imageToRight
                source: root.imagePath
                sourceSize.width: root.imageSize
                fillMode: Image.PreserveAspectFit
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: root.clicked()
        }
    }

    function giveFocus() {
        root.forceActiveFocus()
    }
}
