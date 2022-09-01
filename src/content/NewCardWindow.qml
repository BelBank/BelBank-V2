import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {
    id: new_card_window
    width: 800
    height: 600
    visible: true
    title: "Создание новой карты"
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
        width: 364
        height: 118
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
        id: visa
        property bool visa_active: false
        color: visa_active ? "#d5e2ff" : "white"
        height: 30
        width: 210
        anchors {
            top: logo_on_background.bottom
            topMargin: 10
            left: card_rectangle.left
            leftMargin: 50
        }
        radius: 8
        border.width: 3
        border.color: "#264892"
        Text {
            id: visa_text
            text: "VISA"
            anchors {
                top: visa.top
                topMargin: 1
                horizontalCenter: visa.horizontalCenter
            }
            font.pixelSize: 20
        }

        MouseArea {
            anchors {
                fill: parent
            }
            onClicked: if (mir.mir_active || mastercard.mastercard_active) {
                           if (mir.mir_active) {
                               mir.mir_active = !mir.mir_active
                               visa.visa_active = !visa.visa_active
                           } else {
                               mastercard.mastercard_active = !mastercard.mastercard_active
                               visa.visa_active = !visa.visa_active
                           }
                       } else {
                           visa.visa_active = !visa.visa_active
                       }
        }
    }

    Rectangle {
        id: mastercard
        property bool mastercard_active: false
        color: mastercard_active ? "#d5e2ff" : "white"
        height: 30
        width: 210
        anchors {
            top: logo_on_background.bottom
            topMargin: 10
            right: card_rectangle.right
            rightMargin: 50
        }
        radius: 8
        border.width: 3
        border.color: "#264892"
        Text {
            id: mastercard_text
            text: "MASTERCARD"
            anchors {
                top: mastercard.top
                topMargin: 1
                horizontalCenter: mastercard.horizontalCenter
            }
            font.pixelSize: 20
        }

        MouseArea {
            anchors {
                fill: parent
            }
            onClicked: if (mir.mir_active || visa.visa_active) {
                           if (mir.mir_active) {
                               mir.mir_active = !mir.mir_active
                               mastercard.mastercard_active = !mastercard.mastercard_active
                           } else {
                               mastercard.mastercard_active = !mastercard.mastercard_active
                               visa.visa_active = !visa.visa_active
                           }
                       } else {
                           mastercard.mastercard_active = !mastercard.mastercard_active
                       }
        }
    }

    Rectangle {
        id: mir
        property bool mir_active: false
        color: mir_active ? "#d5e2ff" : "white"
        height: 30
        width: 210
        anchors {
            top: logo_on_background.bottom
            topMargin: 10
            horizontalCenter: logo_on_background.horizontalCenter
        }
        radius: 8
        border.width: 3
        border.color: "#264892"
        Text {
            id: mir_text
            text: "МИР"
            anchors {
                top: mir.top
                topMargin: 1
                horizontalCenter: mir.horizontalCenter
            }
            font.pixelSize: 20
        }

        MouseArea {
            anchors {
                fill: parent
            }
            onClicked: if (mastercard.mastercard_active || visa.visa_active) {
                           if (visa.visa_active) {
                               mir.mir_active = !mir.mir_active
                               visa.visa_active = !visa.visa_active
                           } else {
                               mastercard.mastercard_active = !mastercard.mastercard_active
                               mir.mir_active = !mir.mir_active
                           }
                       } else {
                           mir.mir_active = !mir.mir_active
                       }
        }
    }

    Rectangle {
        property bool active: false
        id: silver_card
        height: card_rectangle.height / 2 + 100
        width: card_rectangle.height / 2 + 30
        anchors {
            top: visa.bottom
            topMargin: 15
            left: card_rectangle.left
            leftMargin: 50
            bottomMargin: 15
            bottom: create_new_card.top
        }
        color: active ? "#d5e2ff" : "white"
        radius: 8
        border.width: 3
        border.color: "#264892"

        Text {
            id: silver_rate_text
            text: "Тариф 'Серебрянный' (0 BYN/мес)"
            anchors {
                top: silver_card.top
                topMargin: 5
                horizontalCenter: silver_card.horizontalCenter
            }
            font.pixelSize: 19
        }

        Image {
            id: silver_image
            width: card_rectangle.height / 2 - 30
            height: 130
            source: "/images/Silver card MIR.png"
            anchors {
                horizontalCenter: silver_card.horizontalCenter
                top: silver_rate_text.bottom
                topMargin: 10
            }
        }

        GridLayout {
            width: 300
            height: 165
            anchors {
                horizontalCenter: silver_image.horizontalCenter
                top: silver_image.bottom
                bottom: silver_card.bottom
                bottomMargin: 10
                topMargin: 10
            }
            rows: 4
            columns: 5

            Rectangle {
                Layout.row: 0
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                width: 8
                height: 8
                radius: 4
                color: "Black"
            }

            Rectangle {
                Layout.row: 1
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                width: 8
                height: 8
                radius: 4
                color: "Black"
            }

            Rectangle {
                Layout.row: 2
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                width: 8
                height: 8
                radius: 4
                color: "Black"
            }

            Rectangle {
                Layout.row: 3
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                width: 8
                height: 8
                radius: 4
                color: "Black"
            }

            Text {
                Layout.row: 0
                Layout.column: 1
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                text: "Бесплатное обслуживание 4 года"
                font.pixelSize: 18
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                Layout.row: 1
                Layout.column: 1
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                text: "Cash-back 3% в магазинах партнерах"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                Layout.row: 2
                Layout.column: 1
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                text: "Начисление 3% годовых на остаток"
                font.pixelSize: 17
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                Layout.row: 3
                Layout.column: 1
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                text: "Программа лояльности 'KeyCard'"
                font.pixelSize: 18
                Layout.alignment: Qt.AlignHCenter
            }
        }

        MouseArea {
            anchors {
                fill: parent
            }
            //onClicked: silver_card.active = !silver_card.active
            onClicked: if (gold_card.active) {
                           gold_card.active = false
                           silver_card.active = !silver_card.active
                       } else {
                           silver_card.active = !silver_card.active
                       }
        }
    }

    Rectangle {
        id: gold_card
        property bool active: false
        color: active ? "#d5e2ff" : "white"
        height: card_rectangle.height / 2 + 100
        width: card_rectangle.height / 2 + 30
        anchors {
            top: visa.bottom
            topMargin: 15
            right: card_rectangle.right
            rightMargin: 50
            bottom: create_new_card.top
            bottomMargin: 15
        }
        radius: 8
        border.width: 3
        border.color: "#264892"

        Text {
            id: gold_rate_text
            text: "Тариф 'Золотой' (6 BYN / мес)"
            anchors {
                top: gold_card.top
                topMargin: 5
                horizontalCenter: gold_card.horizontalCenter
            }
            font.pixelSize: 20
        }

        Image {
            id: gold_image
            anchors {
                horizontalCenter: gold_card.horizontalCenter
                top: gold_rate_text.bottom
                topMargin: 10
            }

            width: card_rectangle.height / 2 - 30
            height: 130
            source: "/images/Golden card MIR .png"
        }

        GridLayout {
            width: 300
            height: 194
            anchors {
                horizontalCenter: gold_image.horizontalCenter
                top: gold_image.bottom
                topMargin: 10
                bottom: gold_card.bottom
                bottomMargin: 10
            }
            rows: 4
            columns: 5

            Rectangle {
                Layout.row: 0
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                width: 8
                height: 8
                radius: 4
                color: "Black"
            }

            Rectangle {
                Layout.row: 1
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                width: 8
                height: 8
                radius: 4
                color: "Black"
            }

            Rectangle {
                Layout.row: 2
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                width: 8
                height: 8
                radius: 4
                color: "Black"
            }

            Rectangle {
                Layout.row: 3
                Layout.column: 0
                Layout.rowSpan: 1
                Layout.columnSpan: 1
                width: 8
                height: 8
                radius: 4
                color: "Black"
            }

            Text {
                Layout.row: 0
                Layout.column: 1
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                text: "Возможность бесконтакных платежей"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                Layout.row: 1
                Layout.column: 1
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                text: "Программа лояльности 'BelBankPlus'"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                Layout.row: 2
                Layout.column: 1
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                text: "Бесплатное снятие до 5000 BYN в банкоматах"
                font.pixelSize: 13
                Layout.alignment: Qt.AlignHCenter
            }
            Text {
                Layout.row: 3
                Layout.column: 1
                Layout.rowSpan: 1
                Layout.columnSpan: 4
                text: "Бесплатный выпуск карточки для 3-го лица"
                font.pixelSize: 13
                Layout.alignment: Qt.AlignHCenter
            }
        }

        MouseArea {
            anchors {
                fill: parent
            }
            onClicked: if (silver_card.active) {
                           silver_card.active = false
                           gold_card.active = !gold_card.active
                       } else {
                           gold_card.active = !gold_card.active
                       }
        }
    }

    Rectangle {
        id: create_new_card

        height: 30
        anchors {
            bottom: card_rectangle.bottom
            right: card_rectangle.right
            left: card_rectangle.left
            bottomMargin: 10
            leftMargin: 50
            rightMargin: 50
        }

        color: "#6e91de"
        border.color: "#264892"
        border.width: 3
        radius: 10

        Text {
            anchors.centerIn: parent
            text: "Создать новую карту"

            font.family: "Helvetica"
            font.pointSize: 12
            font.bold: true
            color: "white"
        }

        MouseArea {

            anchors.fill: parent
            onClicked: {
                if (!visa.visa_active && !mastercard.mastercard_active && !mir.mir_active) {
                    // ошибка не выбрана платежная система
                } else if (!silver_card.active && !gold_card.active) {
                    // ошибка не выбран tariff
                } else {
                    var payment_system
                    if (visa.visa_active) {
                        payment_system = 4
                    } else if (mastercard.mastercard_active) {
                            payment_system = 5
                    } else {
                        payment_system = 3
                    }
                    var tariff = gold_card.active ? 1 : 2
                    if (Controller.makeNewCard(tariff, payment_system)) {
                        set_main_window()
                    }
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
