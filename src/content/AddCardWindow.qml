import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {
    id: new_card_window
    width: 800
    height: 600
    visible: true
    title: "Добавление карты банка"
    flags: {
        Qt.CustomizeWindowHint
        Qt.WindowFullScreen
    }

    /////////////////////////////////////////////////////use function set_error("TEXT") to set an error
    UniversalMessage {
        visible: false
        id: error
    }

    function set_error(text_) {
        error.text__ = text_
        error.visible = true
    }

    ///////////////////////////////////////////////////////
    Rectangle {
        id: card_rectangle
        anchors.fill: parent
    }

    color: "white"

    Image {
        id: logo_on_background
        source: "/images/Logo.png"
        width: new_card_window.width * 0.55
        height: new_card_window.height * 0.39
        anchors {
            horizontalCenter: card_rectangle.horizontalCenter
            top: card_rectangle.top
        }
    }

    Rectangle {
        id: back_to_main

        height: 30
        width: 230
        anchors {
            top: card_rectangle.top
            right: card_rectangle.right
            margins: 15
        }
        color: "#6e91de"
        border.color: "#264892"
        border.width: 3
        radius: 10

        Text {
            anchors.centerIn: parent
            text: "Вернуться на главную страницу"
            font.family: "Helvetica"
            font.pointSize: 9
            font.bold: true
            color: "white"
        }

        MouseArea {

            anchors.fill: parent
            onClicked: {
                set_main_window()
            }

            onPressed: {
                parent.color = "#274cac"
                parent.border.color = "dark gray"
            }
            onReleased: {
                parent.color = "#6e91de"
                parent.border.color = "#7d3a9c"
            }
        }
    }

    Rectangle {
        id: enter_card_number_text
        height: 30
        width: 170
        anchors {
            top: logo_on_background.bottom
            topMargin: 15
            left: silver_card.left
        }
        radius: 8
        border.width: 3
        border.color: "#264892"
        Text {
            id: number_text
            text: "Введите номер карты"
            anchors {
                centerIn: parent
            }
            font.pixelSize: 16
        }
    }

    Rectangle {
        id: card_number

        width: 350
        height: 40
        radius: 8
        border.width: 3
        border.color: "#264892"
        anchors {
            left: enter_card_number_text.right
            top: enter_card_number_text.top
            bottom: enter_card_number_text.bottom
            right: gold_card.right
            leftMargin: 30
        }

        TextInput {
            id: number
            maximumLength: 19
            anchors {
                centerIn: parent
                left: parent.left
                leftMargin: 10
            }
            color: activeFocus ? "black" : "gray"
            focus: true
            activeFocusOnTab: true
            font.family: "Helvetica"
            font.pointSize: 16
        }
    }

    Rectangle {
        id: enter_card_validity_text
        height: 30
        width: 170
        anchors {
            top: card_number.bottom
            topMargin: 15
            left: silver_card.left
        }
        radius: 8
        border.width: 3
        border.color: "#264892"
        Text {
            id: validity_text
            text: "Годна до"
            anchors {
                centerIn: parent
            }
            font.pixelSize: 16
        }
    }

    Rectangle {
        id: card_validity

        width: 100
        height: 40
        radius: 8
        border.width: 3
        border.color: "#264892"
        anchors {
            left: enter_card_validity_text.right
            top: enter_card_validity_text.top
            bottom: enter_card_validity_text.bottom
            leftMargin: 30
        }

        TextInput {
            id: validity
            maximumLength: 16
            anchors {
                centerIn: parent
                left: parent.left
                leftMargin: 10
            }
            color: activeFocus ? "black" : "gray"
            focus: true
            activeFocusOnTab: true
            font.family: "Helvetica"
            font.pointSize: 16
        }
    }

    Rectangle {
        id: add_new_card

        height: 30
        anchors {
            top: card_validity.bottom
            topMargin: 15

            right: card_rectangle.right
            left: card_rectangle.left

            leftMargin: 50
            rightMargin: 50
        }

        color: "#6e91de"
        radius: 8
        border.width: 3
        border.color: "#264892"

        Text {
            anchors.centerIn: parent
            text: "Добавить карту"

            font.family: "Helvetica"
            font.pointSize: 12
            font.bold: true
            color: "white"
        }

        MouseArea {

            anchors.fill: parent
            onClicked: {
                if (number.text[0] !== '2' && number.text[0] !== '4' && number.text[0] !== '5') {
                    // ошибка неправильный номер карты (платежная система)
                }
                if (number.text[1] !== '1' || number.text[2] !== '4' || number.text[3] !== '3') {
                    // ошибка карта не нашего банка
                }
                if (number.text[5] !== '1' && number.text[5] !== '2') {
                    // ошибка хз, что хочешь пиши, но тут неправильно введен тариф
                }

                if (Controller.makeCard(number.text, validity.text)) {
                    console.info("Success adding card!")
                    set_main_window()
                } else {
                    // ошибка добавления
                }

            }

            onPressed: {
                parent.color = "#274cac"
                parent.border.color = "dark gray"
            }
            onReleased: {
                parent.color = "#6e91de"
                parent.border.color = "#7d3a9c"
            }
        }
    }
}
