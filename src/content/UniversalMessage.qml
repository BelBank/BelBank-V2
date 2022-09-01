import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {

    id: universalMessage_window

    property string text__: "error"
    property string next_window: ""
    flags: {
        Qt.CustomizeWindowHint
        Qt.Dialog
        Qt.FramelessWindowHint
    }

    visible: true
    width: 400
    height: 225

    Rectangle {
        id: message_window_rect
        width: universalMessage_window.width
        height: universalMessage_window.height

        border.width: 5
        border.color: "#6e91de"
        clip: true

        Image {
            id: logo_image
            source: "/images/Logo.png"
            width: 250
            height: logo_image.width / 16 * 9
            anchors {
                top: message_window_rect.top
                horizontalCenter: message_window_rect.horizontalCenter
            }
        }

        //        Rectangle{
        //            id: messa
        //        }
        Rectangle {
            id: ok_button
            width: 200
            height: 25
            radius: 25
            border.width: 2
            color: "#6e91de"
            border.color: "#264892"
            anchors {
                bottom: message_window_rect.bottom
                horizontalCenter: message_window_rect.horizontalCenter
                bottomMargin: message_window_rect.border.width + 3
            }

            Text {
                text: "Ок"
                font.family: "Helvetica"
                color: "black"
                font.pointSize: 14
                //font.bold: true
                anchors {
                    centreIn: parent
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
