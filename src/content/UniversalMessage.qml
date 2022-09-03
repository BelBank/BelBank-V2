import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {

    id: universalMessage_window

    property string text__: "error"
    property string next_window: ""
    property bool error_information: false
    flags: {
        Qt.CustomizeWindowHint
        Qt.Dialog
        Qt.FramelessWindowHint
    }

    visible: true
    width: message.implicitWidth + 150

    height: 225

    Rectangle {
        id: message_window_rect
        width: universalMessage_window.width
        height: universalMessage_window.height

        border.width: 6
        border.color: "#264892"
        clip: true

        Image {
            id: logo_image
            source: "/images/Logo_for_error.png"
            width: 110
            height: 110
            anchors {
                top: message_window_rect.top
                topMargin: 15
                horizontalCenter: message_window_rect.horizontalCenter
            }
        }

        Rectangle {
            id: message_rect
            width: message.implicitWidth + 28
            height: message.implicitHeight + 16
            radius: height / 2
            anchors {
                top: logo_image.bottom
                topMargin: 10
                left: error_icon.right
                leftMargin: 5
                right: message_window_rect.right
                rightMargin: 25
            }
            color: "#d5e2ff"

            Text {
                id: message
                text: text__
                color: "black"
                font.pointSize: 15
                anchors {
                    centerIn: parent
                }
                font.bold: true
            }
        }

        Rectangle {
            id: error_icon
            width: 50
            height: 50
            radius: height / 2
            anchors {
                top: logo_image.bottom
                topMargin: 5
                left: message_window_rect.left
                leftMargin: 25
            }
            Image {
                anchors {
                    fill: parent
                }
                source: error_information ? "/images/error_icon.png" : "/images/information_icon.png"
            }
        }

        Rectangle {
            id: ok_button
            width: 100
            height: 23
            radius: 25
            border.width: 2
            color: "#6e91de"
            border.color: "#264892"
            anchors {
                bottom: message_window_rect.bottom
                horizontalCenter: message_window_rect.horizontalCenter
                bottomMargin: 15
            }

            Text {
                text: "ОК"
                font.family: "Helvetica"
                color: "black"
                font.pointSize: 13
                anchors {
                    centerIn: parent
                }
            }

            MouseArea {
                anchors.fill: ok_button
                onClicked: {
                    universalMessage_window.close()
                    if (next_window === "") {

                    } else if (next_window === "auth") {
                        set_authorization_window()
                    } else if (next_window === "add_card") {
                        set_add_card_window()
                    } else if (next_window === "payment") {
                        set_payment_window()
                    } else if (next_window === "regiser") {
                        set_registration_window()
                    } else if (next_window === "main") {
                        set_main_window()
                    }
                }
                onPressed: {
                    ok_button.color = "#274cac"
                    ok_button.border.color = "gray"
                }
                onReleased: {
                    ok_button.color = "#6e91de"
                    ok_button.border.color = "#264892"
                }
            }
        }
    }
}
