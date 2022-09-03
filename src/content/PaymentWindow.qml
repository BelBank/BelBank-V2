import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {

    property var name
    //название платежа, как заказывали
    id: payment_window
    width: 800
    height: 600
    visible: true
    flags: Qt.CustomizeWindowHint

    /////////////////////////////////////////////////////use function set_error("TEXT") to set an error
    UniversalMessage {
        visible: false
        id: error
    }

    function set_error(text_, window = "", error_ = true) {
        error.text__ = text_
        error.visible = true
        error.next_window = window
        error.error_information = error_
    }

    ///////////////////////////////////////////////////////
    color: "white"
    title: "Оформление платежа"
    Rectangle {
        id: payment_rectangle

        anchors {
            fill: parent
        }

        Image {
            id: payment_logo
            source: "/images/Logo.png"
            width: 340
            height: 166
            anchors {
                horizontalCenter: payment_rectangle.horizontalCenter
                top: payment_rectangle.top
                topMargin: 60
            }
        }

        Rectangle {
            id: back_to_main_from_payment

            height: 30
            width: 230
            anchors {
                top: payment_rectangle.top
                right: payment_rectangle.right
                margins: 15
            }
            color: "#6e91de"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Вернуться на главную страницу"
                color: "white"
                font.family: "Helvetica"
                font.pointSize: 9
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    set_main_window()
                }

                onPressed: {
                    parent.color = "#2b53ab"
                    parent.border.color = "dark gray"
                }
                onReleased: {
                    parent.color = "#6e91de"
                    parent.border.color = "#386cde"
                }
            }
        }

        Rectangle {
            id: make_a_payment_selected

            height: 30
            width: 130
            property bool selected: false
            anchors {
                top: payment_rectangle.top
                left: payment_rectangle.left
                margins: 15
            }
            color: selected ? "#d5e2ff" : "white"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Избранный"
                color: "#222024"
                font.family: "Helvetica"
                font.pointSize: 9
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    make_a_payment_selected.selected = !make_a_payment_selected.selected
                }

                onPressed: {
                    parent.border.color = "dark gray"
                }
                onReleased: {
                    //parent.color = make_a_payment_selected.selected ? "#d5e2ff" : "white"
                    parent.border.color = "#386cde"
                }
            }
        }
        Rectangle {
            id: choose_card_text
            width: 200
            height: 35
            color: "#d5e2ff"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            anchors {
                left: payment_rectangle.left
                top: payment_logo.bottom
                topMargin: 60
                leftMargin: 150
            }
            Text {
                text: "Выберите карту:"
                color: "#222024"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true
                anchors {
                    margins: 10
                    centerIn: parent
                }
            }
        }

        ListView {
            id: card_choose
            x: 370
            height: 154
            width: 280
            anchors {
                top: payment_logo.bottom
                right: payment_rectangle.right
                rightMargin: 150
                topMargin: 20
            }
            highlightRangeMode: ListView.StrictlyEnforceRange
            clip: true
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal
            delegate: card_delegate
            model: ListModel {
                id: card_model
                ListElement {
                    name: "Петя Иванов"
                    number: "1234 5678 1234 5678"
                    valid: "25/08"
                    type: "gold"
                    system: "visa"
                    balance: "3.23"
                }
                ListElement {
                    name: "Шурик Скворцов"
                    number: "1234 5678 7654 5678"
                    valid: "35/08"
                    type: "silver"
                    system: "visa"
                    balance: "0"
                }
                ListElement {
                    name: "PaShampusik"
                    number: "1346 5678 1234 5678"
                    valid: "25/08"
                    type: "gold"
                    system: "mastercard"
                    balance: "33423.00"
                }
                ListElement {
                    name: "Павел Староста"
                    number: "1234 5678 1234 5678"
                    valid: "25/08"
                    type: "gold"
                    system: "visa"
                    balance: "323.24"
                }
            }
            Component {
                id: card_delegate
                Rectangle {
                    id: rect_for_flip_card

                    width: 270
                    height: 120
                    color: "white"

                    function getCard() {
                        var sorce
                        if (card.type) {
                            if (card.system) {
                                sorce = "/images/Golden card VISA.png"
                            } else if (model.system === "mastercard") {
                                sorce = "/images/Golden Card Mastercard.png"
                            } else {
                                sorce = "/images/Golden card MIR .png"
                            }
                        } else {
                            if (card.system) {
                                sorce = "/images/Silver card VISA.png"
                            } else if (model.system === "mastercard") {
                                sorce = "/images/Silver card Mastercard.png"
                            } else {
                                sorce = "/images/Silver card MIR.png"
                            }
                        }
                        return sorce
                    }

                    Flipable {
                        id: card
                        property bool flipped: false
                        property bool type: model.type === "gold"
                        property bool system: model.system === "visa"
                        anchors.fill: parent
                        front: Image {
                            id: card_img
                            width: 400
                            height: 190
                            anchors {
                                //fill: parent
                                centerIn: parent
                            }
                            source: getCard()
                            Text {
                                id: balance_text
                                anchors {
                                    left: parent.left
                                    leftMargin: 145
                                    top: card_img.top
                                    topMargin: card_img.height / 2 - 10
                                }
                                font.pixelSize: 22
                                text: "Баланс:"
                                color: "#0048ad"
                                //font.bold: true
                            }
                            Text {
                                id: balance
                                anchors {
                                    left: balance_text.right
                                    leftMargin: 10
                                    verticalCenter: balance_text.verticalCenter
                                }
                                font.pixelSize: 22
                                // font.bold: true
                                text: model.balance
                                color: "#0048ad"
                            }
                        }
                        back: Rectangle {
                            id: payment_card_info
                            height: 120
                            width: 250
                            anchors {
                                //fill: parent
                                centerIn: parent
                            }
                            color: "transparent"
                            Image {
                                anchors {
                                    fill: parent
                                }
                                source: "/images/card_background.jpg"
                                opacity: 0.75
                            }

                            Text {
                                id: card_info_text
                                text: "Данные о карте:"
                                color: "white"
                                anchors {
                                    horizontalCenter: payment_card_info.horizontalCenter
                                    top: payment_card_info.top
                                    topMargin: 10
                                }
                                font.pixelSize: 12
                            }
                            Text {
                                id: payment_cardholder_name_text
                                color: "white"

                                anchors {
                                    left: payment_card_info.left
                                    top: card_info_text.bottom
                                    topMargin: 15
                                    leftMargin: 15
                                }
                                text: "Имя держателя:"
                                font.pixelSize: 10
                                Text {
                                    ///////////////////////////////
                                    id: payment_cardholder_name
                                    color: "white"

                                    anchors {
                                        verticalCenter: payment_cardholder_name_text.verticalCenter
                                        left: payment_cardholder_name_text.right
                                        leftMargin: 13
                                    }
                                    text: model.name
                                    font.pixelSize: 10
                                }
                            }
                            Text {
                                id: payment_card_number_text
                                color: "white"

                                text: "Номер карты:"
                                font.pixelSize: 10
                                anchors {
                                    left: payment_card_info.left
                                    top: payment_cardholder_name_text.bottom
                                    topMargin: 15
                                    leftMargin: 15
                                }
                                Text {
                                    ///////////////////////////////
                                    id: payment_card_number
                                    color: "white"

                                    anchors {
                                        verticalCenter: payment_card_number_text.verticalCenter
                                        left: payment_card_number_text.right
                                        leftMargin: 13
                                    }
                                    text: model.number
                                    font.pixelSize: 10
                                }
                            }
                            Text {
                                id: payment_valid_thru_text
                                color: "white"

                                text: "Годна до:"
                                font.pixelSize: 10
                                anchors {
                                    left: payment_card_info.left
                                    top: payment_card_number_text.bottom
                                    topMargin: 15
                                    leftMargin: 15
                                }
                                Text {
                                    ///////////////////////////////
                                    id: payment_valid_thru
                                    color: "white"

                                    anchors {
                                        verticalCenter: payment_valid_thru_text.verticalCenter
                                        left: payment_valid_thru_text.right
                                        leftMargin: 13
                                    }
                                    text: model.valid
                                    font.pixelSize: 10
                                }
                            }
                        }

                        transform: Rotation {
                            origin.x: card.width / 2
                            origin.y: card.height / 2
                            axis.x: 1
                            axis.y: 0
                            axis.z: 0
                            angle: card.flipped ? 180 : 0

                            Behavior on angle {
                                NumberAnimation {
                                    duration: 600
                                }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: card.flipped = !card.flipped
                        }
                    }
                }
            }
        }

        Rectangle {
            id: check_text
            width: 150
            height: 35
            color: "#d5e2ff"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            anchors {
                left: choose_card_text.left
                top: card_choose.bottom
                right: choose_card_text.right
                topMargin: 15
            }
            Text {
                text: "Номер счета:"
                color: "#222024"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true
                anchors {
                    margins: 10
                    centerIn: parent
                }
            }
        }

        Rectangle {
            id: check
            width: 200
            height: 35
            anchors {
                verticalCenter: check_text.verticalCenter
                left: check_text.right
                leftMargin: 20
                right: card_choose.right
            }

            color: "white"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            TextInput {
                id: text0
                maximumLength: 25
                anchors {
                    top: check.top
                    left: check.left
                    right: check.right
                    bottom: check.bottom
                    topMargin: 10
                    leftMargin: 10
                    bottomMargin: 6
                }
                color: activeFocus ? "black" : "gray"
                focus: true
                activeFocusOnTab: true
                font.family: "Helvetica"
                font.pointSize: 16
            }
        }

        Rectangle {
            id: money_value_text
            width: 150
            height: 35
            color: "#d5e2ff"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            anchors {
                left: check_text.left
                top: check_text.bottom
                right: choose_card_text.right
                topMargin: 20
            }
            Text {
                text: "Сумма платежа:"
                color: "#222024"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true
                anchors {
                    margins: 10
                    centerIn: parent
                }
            }
        }

        Rectangle {
            id: money_value
            width: 200
            height: 35
            anchors {
                verticalCenter: money_value_text.verticalCenter
                left: check_text.right
                leftMargin: 20
                right: card_choose.right
            }

            color: "white"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            TextInput {
                id: text00
                maximumLength: 25
                anchors {
                    top: money_value.top
                    left: money_value.left
                    right: money_value.right
                    bottom: money_value.bottom
                    topMargin: 10
                    leftMargin: 10
                    bottomMargin: 6
                }
                color: activeFocus ? "black" : "gray"
                focus: true
                activeFocusOnTab: true
                font.family: "Helvetica"
                font.pointSize: 16
            }
        }

        Rectangle {
            id: proccess_payment

            height: 40
            anchors {
                left: choose_card_text.left
                right: card_choose.right
                top: money_value.bottom
                topMargin: 15
            }

            color: "#6e91de"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Совершить платеж"
                color: "white"
                font.family: "Helvetica"
                font.pointSize: 12
                font.bold: true
            }

            MouseArea {

                anchors.fill: parent
                onClicked: {
                    set_main_window()
                }

                onPressed: {
                    parent.color = "#2b53ab"
                    parent.border.color = "dark gray"
                }
                onReleased: {
                    parent.color = "#6e91de"
                    parent.border.color = "#386cde"
                }
            }
        }
    }
}
