import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {
    id: successfulPayment_window
    title: "Уведомление"
    visible: true
    width: 300
    height: 200

    Rectangle {
        id: successfulPaymentWindow_rect
        width: successfulPayment_window.width
        height: successfulPayment_window.height
        border.width: 3
        border.color: "#dbaaf2"
        radius: 10
        clip: true

        Image {
            id: backgroundImage
            source: "images/MountainForSuccessfulPayment.png"
            anchors.fill: successfulPaymentWindow_rect
            opacity: 0.3
            anchors.margins: 5
        }

        Image {
            id: logo_image
            source: "images/capture_20220617214014956.png"
            width: successfulPaymentWindow_rect.width/2.3
            height: successfulPaymentWindow_rect.height/2.3
            anchors {
                horizontalCenter: successfulPaymentWindow_rect.horizontalCenter
                top: successfulPaymentWindow_rect.top
                margins: 5
            }
        }

        Rectangle {
            id: message_rect
            width: successfulPaymentWindow_rect.width/1.5
            anchors {
                top: logo_image.bottom
                bottom: ok_button.top
                horizontalCenter: successfulPaymentWindow_rect.horizontalCenter
                topMargin: 10
                bottomMargin: 10
            }
            radius: 3
            border.width: 2
            border.color: "#d088f2"

            Flickable {
                id: flick_message_rect
                clip: true
                anchors.fill: message_rect
                anchors.margins: 3
                contentWidth: message.width
                contentHeight: message.height

                Text {
                    id: message
                    text: "Ваш платёж был успешно совершён."
                    width: message_rect.width - 10
                    font.family: "Helvetica"
                    font.pointSize: 13
                    anchors.fill: message_rect
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }
            }
        }

        Rectangle {
            id: ok_button
            width: 70
            height: 30
            radius: 25
            color: "#d088f2"
            border.color: "#28aaf5"
            anchors {
                bottom: successfulPaymentWindow_rect.bottom
                horizontalCenter: successfulPaymentWindow_rect.horizontalCenter
                bottomMargin: successfulPaymentWindow_rect.border.width + 3

            }

            Text {
                text: "OK"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true
                anchors {
                    fill: ok_button
                    rightMargin: 20
                    leftMargin: 20
                    topMargin: 5
                    bottomMargin: 5
                    centerIn: ok_button
                }
            }

            MouseArea {
                anchors.fill: ok_button
                onClicked: {
                    successfulPayment_window.close()
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
