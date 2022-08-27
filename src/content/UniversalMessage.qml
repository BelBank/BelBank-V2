import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {
    id: universalMessage_window
    title: "Уведомление"
    visible: true
    width: 350
    height: 250

    Rectangle {
        id: message_window_rect
        //anchors.fill: message_window
        width: universalMessage_window.width
        height: universalMessage_window.height
        radius: 20
        Image {
            source: "/images/MountainForBackground.png"
            anchors.fill: message_window_rect
        }
        border.width: 3
        border.color: "#dbaaf2"
        clip: true

        Image {
            id: logo_image
            source: "/images/capture_20220617214014956.png"
            width: message_window_rect.width/3.5
            height: message_window_rect.height/3.5
            anchors.horizontalCenter: message_window_rect.horizontalCenter
            anchors.top: message_window_rect.top
            anchors.topMargin: message_window_rect.border.width + 2
        }

        Rectangle {
            id: message_rect
            width: message_window_rect.width/2 + 50
            anchors {
                top: logo_image.bottom
                bottom: ok_button.top
                horizontalCenter: message_window_rect.horizontalCenter
                topMargin: 2
                bottomMargin: 2
            }
            color: "white"
            border.width: 2
            border.color: "#dbaaf2"
            radius: 5

            Flickable {
                id: flick_message_rect
                anchors.fill: message_rect
                anchors.margins: 2
                contentWidth: message.width
                contentHeight: message.height
                ScrollBar.vertical: ScrollBar { opacity: 0.2; visible: true; }
                clip: true

                Text {
                    id: message
                    text: "Message about incorrect data"
                    width: message_rect.width - 10
                    wrapMode: Text.WordWrap
                    padding: 7
                    font.family: "Helvetica"
                    font.pointSize: 12
                }
            }
        }

        Rectangle {
            id: ok_button
            width: 80
            height: 40
            radius: 25
            color: "#d088f2"
            border.color: "#28aaf5"
            anchors {
                bottom: message_window_rect.bottom
                horizontalCenter: message_window_rect.horizontalCenter
                bottomMargin: message_window_rect.border.width + 3
            }

            Text {
                text: "OK"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true
                anchors {
                    fill: ok_button
                    rightMargin: 25
                    leftMargin: 25
                    topMargin: 10
                    bottomMargin: 5
                    centerIn: ok_button
                }
            }

            MouseArea {
                anchors.fill: ok_button
                onClicked: {
                    universalMessage_window.close()
                }
                onPressed: {
                    ok_button.color = "#7d3a9c"
                    ok_button.border.color = "dark gray"
                }
                onReleased: {
                    ok_button.color = "#d088f2"
                    ok_button.border.color = "#28aaf5"
                }
            }
        }
    }
}
