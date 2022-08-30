import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12





Window {
    id: mainwindow
    width: 1920
    height: 1080
    visible: true
    flags: {

        Qt.WindowFullScreen


    }
    property alias cardlist: card_model
    property alias cardview: lv

    Rectangle {
        id: header
        height: 100
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
        }
        color: "#dbaaf2"

        Image {
            id: logo
            width: 143
            height: 100
            source: "/images/capture_20220617214014956.png"
            anchors {
                margins: 15
                left: header.left
                top: header.top
                bottom: header.bottom
            }
        }

        Text {
            id: clientname
            anchors {
                margins: 45
                left: logo.right
                verticalCenter: logo.verticalCenter
            }
            font.pixelSize: 28
            font.bold: true

            text: Controller.getUserName() ///тут должен присваиваться ник клиента.
        }

        Rectangle {
            id: exit
            width: 200
            height: 200
            anchors {
                top: header.top
                right: header.right
                verticalCenter: header.verticalCenter
                margins: 15
            }
            color: "#e18eff"
            border.color: "#7d3a9c"
            border.width: 2
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Выйти"
                color: "#222024"
                font.family: "Helvetica"
                font.pointSize: 17
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    set_authorization_window()
                }
                onPressed: {
                    parent.color = "#7d3a9c"
                    parent.border.color = "dark gray"
                }
                onReleased: {
                    parent.color = "#d088f2"
                    parent.border.color = "#7d3a9c"
                }
            }
        }

        Text {
            id: call_number
            anchors {
                top: header.top
                topMargin: 12
                right: exit.left
                rightMargin: 45
            }
            text: "142"
            font.pixelSize: 35
            font.bold: true
        }

        Image {
            id: phone_icon
            width: 44
            height: 44
            anchors {
                verticalCenter: call_number.verticalCenter
                rightMargin: 15
                right: call_number.left
            }
            source: "/images/free-icon-telephone-4996346 (1).png"
        }

        Text {
            anchors {
                top: phone_icon.bottom
                topMargin: 3
                rightMargin: 37
                right: exit.left
            }
            font.pixelSize: 20
            font.bold: true
            text: "+375336314010"
        }

        Text {
            id: our_session
            anchors {
                verticalCenter: call_number.verticalCenter
                horizontalCenter: header.horizontalCenter
            }
            font.pixelSize: 20
            text: "Текущая сессия:"
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: time.text = Date().toString()
        }

        Text {
            anchors {
                horizontalCenter: header.horizontalCenter
                bottom: header.bottom
                bottomMargin: 23
            }
            font.pixelSize: 18
            id: time
        }
    }

    Rectangle {
        id: body
        anchors {
            top: header.bottom
            bottom: footer.top
            right: parent.right
            left: parent.left
        }
        color: "#fdffcc"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: finance
            width: 600
            anchors {
                top: body.top
                bottom: body.bottom
                left: body.left
                margins: 10
            }
            radius: 8
            border.width: 3
            border.color: "#dbaaf2"
            color: "#fdffbd"

            Text {
                id: finance_text
                anchors {
                    horizontalCenter: finance.horizontalCenter
                    top: finance.top
                }
                text: "Финансы"
                font.pixelSize: 30
            }

            ListView {
                id: lv
                height: 240
                width: 500
                anchors {
                    top: finance_text.top
                    left: finance.left
                    right: finance.right
                    margins: 40
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
                        type: "silver"
                        system: "visa"
                    }
//                    ListElement {
//                        name: "Шурик Скворцов"
//                        number: "1234 5678 7654 5678"
//                        valid: "35/08"
//                        type: "silver"
//                        system: "visa"
//                    }
//                    ListElement {
//                        name: "PaShampusik"
//                        number: "1346 5678 1234 5678"
//                        valid: "25/08"
//                        type: "gold"
//                        system: "mastercard"
//                    }
//                    ListElement {
//                        name: "Павел Староста"
//                        number: "1234 5678 1234 5678"
//                        valid: "25/08"
//                        type: "gold"
//                        system: "visa"
//                    }
                }
                Component {
                    id: card_delegate
                    Rectangle {
                        id: rect_for_flip_card

                        width: 500
                        height: 240
                        color: "#fdffbd"

                        function getCard() {
                            var sorce
                            if (card.type) {
                                if (card.system) {
                                    sorce = "/images/Golden card VISA.png"
                                } else {
                                    sorce = "/images/Golden Card Mastercard.png"
                                }
                            } else {
                                if (card.system) {
                                    sorce = "/images/Silver card VISA.png"
                                } else {
                                    sorce = "/images/Silver card Mastercard.png"
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
                                width: 480
                                anchors {
                                    //fill: parent
                                    centerIn: parent
                                }
                                source: getCard()
                            }
                            back: Rectangle {
                                id: card_info
                                height: 180
                                width: 480
                                radius: 15
                                anchors {
                                    //fill: parent
                                    centerIn: parent
                                }
                                Image {
                                    anchors {
                                        fill: parent
                                    }
                                    source: "/images/card_background.jpg"
                                    opacity: 0.8
                                }

                                border.width: 2
                                border.color: "gray"

                                Text {
                                    text: "Данные о карте:"
                                    anchors {
                                        horizontalCenter: card_info.horizontalCenter
                                        top: card_info.top
                                        topMargin: 10
                                    }
                                    font.pixelSize: 22
                                }
                                Text {
                                    id: cardholder_name_text
                                    anchors {
                                        left: card_info.left
                                        top: card_info.top
                                        topMargin: 50
                                        leftMargin: 15
                                    }
                                    text: "Имя держателя:"
                                    font.pixelSize: 20
                                    Text {
                                        ///////////////////////////////
                                        id: cardholder_name
                                        anchors {
                                            verticalCenter: cardholder_name_text.verticalCenter
                                            left: cardholder_name_text.right
                                            leftMargin: 13
                                        }
                                        text: model.name
                                        font.pixelSize: 20
                                    }
                                }
                                Text {
                                    id: card_number_text
                                    text: "Номер карты:"
                                    font.pixelSize: 20
                                    anchors {
                                        left: card_info.left
                                        top: card_info.top
                                        topMargin: 85
                                        leftMargin: 15
                                    }
                                    Text {
                                        ///////////////////////////////
                                        id: card_number
                                        anchors {
                                            verticalCenter: card_number_text.verticalCenter
                                            left: card_number_text.right
                                            leftMargin: 13
                                        }
                                        text: model.number
                                        font.pixelSize: 20
                                    }
                                }
                                Text {
                                    id: valid_thru_text
                                    text: "Годна до:"
                                    font.pixelSize: 20
                                    anchors {
                                        left: card_info.left
                                        top: card_info.top
                                        topMargin: 120
                                        leftMargin: 15
                                    }
                                    Text {
                                        ///////////////////////////////
                                        id: valid_thru
                                        anchors {
                                            verticalCenter: valid_thru_text.verticalCenter
                                            left: valid_thru_text.right
                                            leftMargin: 13
                                        }
                                        text: model.valid
                                        font.pixelSize: 20
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

                id: cash
                height: 230
                color: "#fcdd6d"
                anchors {
                    top: new_card.bottom
                    topMargin: 40
                    bottom: finance.bottom
                    left: finance.left
                    right: finance.right
                    bottomMargin: 20
                    rightMargin: 50
                    leftMargin: 50
                }
                radius: 8

                GridLayout {
                    anchors.bottomMargin: 20
                    anchors.topMargin: 8
                    rows: 7
                    columns: 4
                    anchors {
                        fill: parent
                        margins: 20
                    }

                    Text {
                        Layout.row: 0
                        Layout.columnSpan: 4
                        Layout.column: 0

                        id: cash_title
                        font.pixelSize: 23
                        font.bold: true

                        Layout.alignment: Qt.AlignCenter
                        text: "Курсы валют в отделениях БелБанка"
                    }
                    Text {
                        Layout.row: 1
                        Layout.columnSpan: 2
                        Layout.column: 0
                        font.pixelSize: 21
                        font.bold: true
                        text: "    Валюта:"
                    }
                    Text {
                        id: sell
                        Layout.row: 1
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 21
                        font.bold: true

                        text: "   Продажа:"
                    }
                    Text {
                        id: buy
                        Layout.row: 1
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 21
                        font.bold: true

                        text: "Покупка:"
                    }
                    Text {
                        Layout.row: 2
                        Layout.columnSpan: 2
                        Layout.column: 0
                        id: rub
                        text: "100RUB"
                        font.pixelSize: 20
                        Image {
                            width: 40
                            height: 30
                            source: "/images/RUB.png"
                            anchors {
                                left: rub.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 2
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 22
//                        text: Controller.exchangeRatesToQML()[0];
                        anchors {
                            horizontalCenter: sell.horizontalCenter
                        }
                    }
                    Text {
                        Layout.row: 2
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 22
//                        text: Controller.exchangeRatesToQML()[1];
                        anchors {
                            horizontalCenter: buy.horizontalCenter
                        }
                    }
                    Text {
                        Layout.row: 3
                        Layout.columnSpan: 2
                        Layout.column: 0
                        id: usd
                        text: "1USD"
                        font.pixelSize: 20
                        Image {
                            width: 40
                            height: 30
                            source: "/images/USD.png"
                            anchors {
                                left: usd.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 3
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 22
                        text: "2.63"
                        anchors {
                            horizontalCenter: sell.horizontalCenter
                        }
                    }
                    Text {
                        Layout.row: 3
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 22
                        text: "2.59"
                        anchors {
                            horizontalCenter: buy.horizontalCenter
                        }
                    }
                    Text {
                        Layout.row: 4
                        Layout.columnSpan: 2
                        Layout.column: 0
                        id: euro
                        text: "1EUR"
                        font.pixelSize: 20
                        Image {
                            width: 40
                            height: 30
                            source: "/images/EURO.png"
                            anchors {
                                left: euro.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 4
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 22
                        text: "3.2"
                        anchors {
                            horizontalCenter: sell.horizontalCenter
                        }
                    }
                    Text {
                        Layout.row: 4
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 22
                        text: "3.15"
                        anchors {
                            horizontalCenter: buy.horizontalCenter
                        }
                    }

                    Text {
                        Layout.row: 5
                        Layout.columnSpan: 2
                        Layout.column: 0
                        id: china
                        text: "10CNY"
                        font.pixelSize: 20
                        Image {
                            width: 40
                            height: 30
                            source: "/images/china.jpg"
                            anchors {
                                left: china.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 5
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 22
                        text: "4"
                        anchors {
                            horizontalCenter: sell.horizontalCenter
                        }
                    }
                    Text {
                        Layout.row: 5
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 22
                        text: "3.679"
                        anchors {
                            horizontalCenter: buy.horizontalCenter
                        }
                    }

                    Text {
                        Layout.row: 6
                        Layout.columnSpan: 2
                        Layout.column: 0
                        id: pln
                        text: "10PLN"
                        font.pixelSize: 20
                        Image {
                            width: 40
                            height: 30
                            source: "/images/PLN.jpg"
                            anchors {
                                left: pln.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 6
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 22
                        text: "5.64"
                        anchors {
                            horizontalCenter: sell.horizontalCenter
                        }
                    }
                    Text {
                        Layout.row: 6
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 22
                        text: "5.14"
                        anchors {
                            horizontalCenter: buy.horizontalCenter
                        }
                    }
                }
            }

            Rectangle {
                id: new_card
                height: 40
                anchors {
                    top: lv.bottom
                    left: finance.left
                    right: finance.right
                    rightMargin: 50
                    leftMargin: 50
                    topMargin: 10
                    bottomMargin: 40
                }
                color: "#dbaaf2"
                border.color: "#7d3a9c"
                border.width: 2
                radius: 10
                Text {
                    anchors.centerIn: parent
                    text: "Создать новую карту"
                    color: "#222024"
                    font.family: "Helvetica"
                    font.pointSize: 17
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        set_new_card_window()
                    }

                    onPressed: {
                        parent.color = "#d599f2"
                        parent.border.color = "dark gray"
                    }
                    onReleased: {
                        parent.color = "#dbaaf2"
                        parent.border.color = "#7d3a9c"
                    }
                }
            }
        }

        Rectangle {
            id: payments
            anchors {
                top: body.top
                bottom: body.bottom
                left: finance.right
                right: body.right
                margins: 10
            }
            radius: 8
            border.width: 3
            anchors.rightMargin: 8
            anchors.bottomMargin: 10
            anchors.leftMargin: 12
            anchors.topMargin: 10
            border.color: "#dbaaf2"
            color: "#fdffbd"

            Text {
                id: payments_text
                anchors {
                    top: payments.top
                    horizontalCenter: payments.horizontalCenter
                }
                text: "Платежи и переводы"
                font.pixelSize: 30
            }

            Text {
                id: erip_text
                x: 30
                y: 60
                width: 295
                height: 37
                text: qsTr("Система Расчета ЕРИП")
                font.pixelSize: 28
                anchors {
                    horizontalCenter: erip.horizontalCenter
                    top: payments_text.bottom
                    topMargin: 15
                }
            }

            Rectangle {
                id: popular_payments

                height: payments.height / 2 - 70
                //                border.color: "#d088f2"
                //                color: "#fdffbd"
                //                border.width: 3
                radius: 20
                color: "transparent"
                anchors {
                    left: erip.right
                    leftMargin: 25
                    right: payments.right
                    rightMargin: 30
                    top: erip.top
                }

                Flipable {
                    id: popular_or_selected
                    property bool flipped: false

                    anchors.fill: parent
                    front: Rectangle {
                        id: popular
                        anchors {
                            fill: parent
                            margins: 2
                        }

                        color: "#fcdd6d"
                        radius: 10
                        Rectangle {
                            width: 40
                            height: 40
                            radius: 10
                            color: "transparent"
                            id: swap_button_to_selected
                            anchors {
                                bottom: popular.bottom
                                left: popular.left
                                margins: 10
                            }
                            Image {
                                id: img_1
                                visible: true
                                width: 40
                                height: 40

                                anchors {
                                    centerIn: parent
                                }
                                source: "/images/swap.png"
                            }

                            Rectangle {
                                id: swap_rect_1
                                // rounded corners for img
                                anchors.fill: img_1
                                color: "transparent"
                                border.color: "#d088f2"
                                border.width: 1
                                radius: 10
                            }
                            MouseArea {

                                anchors {
                                    fill: swap_rect_1
                                }
                                function popular_text() {
                                    popular_payments_text.text = "Избранные платежи"
                                }

                                onClicked: {
                                    popular_or_selected.flipped = !popular_or_selected.flipped
                                    popular_text()
                                }
                                onPressed: {
                                    swap_rect_1.border.width = 3
                                }
                                onReleased: {
                                    swap_rect_1.border.width = 1
                                }
                            }
                        }

                        GridLayout {
                            rows: 5

                            columns: 4
                            anchors {
                                leftMargin: 80
                                topMargin: 30
                                rightMargin: 30
                                bottomMargin: 50
                                fill: parent
                            }

                            MouseArea {
                                id: mts_mouse_area
                                Layout.row: 0
                                Layout.column: 0
                                Layout.rowSpan: 2
                                Layout.columnSpan: 1

                                width: 60
                                height: 140
                                onClicked: {
                                    set_payment_window()
                                }
                                onPressed: {
                                    mts_text.font.bold = true
                                }
                                onReleased: {
                                    mts_text.font.bold = false
                                }
                            }

                            MouseArea {
                                id: a1_mouse_area
                                Layout.row: 0
                                Layout.column: 1
                                Layout.rowSpan: 2
                                Layout.columnSpan: 1

                                width: 60
                                height: 140
                                onClicked: {
                                    set_payment_window()
                                }
                                onPressed: {
                                    a1_text.font.bold = true
                                }
                                onReleased: {
                                    a1_text.font.bold = false
                                }
                            }

                            MouseArea {
                                id: life_mouse_area
                                Layout.row: 0
                                Layout.column: 2
                                Layout.rowSpan: 2
                                Layout.columnSpan: 1

                                width: 60
                                height: 140
                                onClicked: {
                                    set_payment_window()
                                }
                                onPressed: {
                                    life_text.font.bold = true
                                }
                                onReleased: {
                                    life_text.font.bold = false
                                }
                            }

                            MouseArea {
                                id: beltelecom_mouse_area
                                Layout.row: 0
                                Layout.column: 3
                                Layout.rowSpan: 2
                                Layout.columnSpan: 1

                                width: 110
                                height: 140
                                onClicked: {
                                    set_payment_window()
                                }
                                onPressed: {
                                    beltelecom_text.font.bold = true
                                }
                                onReleased: {
                                    beltelecom_text.font.bold = false
                                }
                            }

                            MouseArea {
                                id: byfly_mouse_area
                                Layout.row: 3
                                Layout.column: 0
                                Layout.rowSpan: 2
                                Layout.columnSpan: 1

                                width: 60
                                height: 140
                                onClicked: {
                                    set_payment_window()
                                }
                                onPressed: {
                                    byfly_text.font.bold = true
                                }
                                onReleased: {
                                    byfly_text.font.bold = false
                                }
                            }

                            Rectangle {
                                id: mts

                                Layout.row: 0
                                Layout.column: 0
                                width: 60
                                height: 60

                                clip: true
                                radius: 30

                                Image {
                                    fillMode: Image.Stretch
                                    anchors {
                                        fill: parent
                                    }
                                    smooth: true
                                    source: "/images/MTS.png"
                                }
                            }
                            Text {
                                id: mts_text
                                Layout.row: 1
                                Layout.column: 0
                                font.pixelSize: 20
                                text: " МТС"
                            }

                            Rectangle {
                                Layout.row: 0
                                Layout.column: 1
                                width: 60
                                height: 60

                                Image {
                                    fillMode: Image.Stretch
                                    anchors {
                                        fill: parent
                                    }
                                    source: "/images/A1.jpg"
                                }
                            }
                            Text {
                                id: a1_text
                                Layout.row: 1
                                Layout.column: 1
                                font.pixelSize: 20
                                text: "    А1"
                            }

                            Rectangle {
                                Layout.row: 0
                                Layout.column: 2
                                width: 60
                                height: 60

                                Image {
                                    fillMode: Image.Stretch
                                    anchors {
                                        fill: parent
                                    }
                                    source: "/images/LIFE.png"
                                }
                            }
                            Text {
                                id: life_text
                                Layout.row: 1
                                Layout.column: 2
                                font.pixelSize: 20
                                text: "   Life"
                            }

                            Rectangle {
                                Layout.row: 0
                                Layout.column: 3
                                width: 60
                                height: 60
                                color: "transparent"

                                Image {
                                    fillMode: Image.Stretch
                                    anchors {
                                        fill: parent
                                    }
                                    source: "/images/Beltelecom.png"
                                    anchors.rightMargin: -21
                                    anchors.bottomMargin: 0
                                    anchors.leftMargin: 21
                                    anchors.topMargin: 0
                                }
                            }
                            Text {
                                id: beltelecom_text
                                Layout.row: 1
                                Layout.column: 3
                                font.pixelSize: 20
                                text: "Белтелеком"
                            }

                            Rectangle {
                                Layout.row: 3
                                Layout.column: 0
                                width: 60
                                height: 60

                                Image {
                                    fillMode: Image.Stretch
                                    anchors {
                                        fill: parent
                                    }
                                    source: "/images/ByFly.jpg"
                                }
                            }
                            Text {
                                id: byfly_text
                                Layout.row: 4
                                Layout.column: 0
                                font.pixelSize: 20
                                text: " ByFly"
                            }
                        }
                    }
                    back: Rectangle {
                        id: selected

                        anchors {
                            fill: parent
                            margins: 3
                        }
                        color: "#fcdd6d"
                        radius: 10

                        Rectangle {
                            width: 40
                            height: 40
                            radius: 10
                            color: "transparent"
                            id: swap_button_to_popular
                            anchors {
                                bottom: selected.bottom
                                left: selected.left
                                margins: 10
                            }
                            Image {
                                id: img_2
                                visible: true
                                width: 40
                                height: 40

                                anchors {
                                    centerIn: parent
                                }
                                source: "/images/swap.png"
                            }

                            Rectangle {
                                id: swap_rect_2
                                // rounded corners for img
                                anchors.fill: img_2
                                color: "transparent"
                                border.color: "#d088f2"
                                border.width: 1
                                radius: 10
                            }
                            MouseArea {

                                anchors {
                                    fill: swap_rect_2
                                }

                                function selected_text() {
                                    popular_payments_text.text = "Популярные платежи"
                                }

                                onClicked: {
                                    popular_or_selected.flipped = !popular_or_selected.flipped
                                    selected_text()
                                }
                                onPressed: {
                                    swap_rect_2.border.width = 3
                                }
                                onReleased: {
                                    swap_rect_2.border.width = 1
                                }
                            }
                        }

                        ListView {
                            currentIndex: -1
                            id: selected_payments
                            x: 41
                            y: 112
                            width: 385
                            height: 719
                            anchors {
                                fill: parent
                                margins: 50
                            }
                            model: selected_paymentModel
                            delegate: selected_paymentDelegate

                            focus: true
                            clip: true
                            highlight: Rectangle {
                                z: 1
                                color: "transparent"
                                border.width: 3
                                border.color: "#d088f2"
                            }
                        }

                        ListModel {
                            id: selected_paymentModel
                            ListElement {
                                name: "Приорбанк"
                            }
                            ListElement {
                                name: "Гаи"
                            }
                            ListElement {
                                name: "Погашение кредита"
                            }
                            ListElement {

                                name: "Коммунальные платежи"
                            }
                            ListElement {

                                name: "МТС"
                            }
                            ListElement {
                                name: "Приорбанк"
                            }
                            ListElement {
                                name: "Гаи"
                            }
                            ListElement {
                                name: "Погашение кредита"
                            }
                            ListElement {

                                name: "Коммунальные платежи"
                            }
                            ListElement {

                                name: "МТС"
                            }
                            ListElement {
                                name: "Приорбанк"
                            }
                            ListElement {
                                name: "Гаи"
                            }
                            ListElement {
                                name: "Погашение кредита"
                            }
                            ListElement {

                                name: "Коммунальные платежи"
                            }
                            ListElement {

                                name: "МТС"
                            }
                        }
                        Component {
                            id: selected_paymentDelegate

                            Rectangle {
                                radius: 3
                                color: index % 2 ? "#fcfa72" : "#fccf53"
                                height: 30
                                clip: true
                                width: 385
                                border.width: 1
                                border.color: "gray"
                                readonly property ListView __lv: ListView.view

                                anchors {
                                    left: parent.left
                                    right: parent.right
                                }
                                Text {

                                    height: parent.height
                                    text: model.name
                                    font.pixelSize: 20
                                    anchors {
                                        horizontalCenter: parent.horizontalCenter
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: __lv.currentIndex = index
                                    onDoubleClicked: {
                                        set_payment_window()
                                    }
                                }
                            }
                        }
                    }

                    transform: Rotation {
                        origin.x: popular_or_selected.width / 2
                        origin.y: popular_or_selected.height / 2
                        axis.x: 0
                        axis.y: 1
                        axis.z: 0
                        angle: popular_or_selected.flipped ? 180 : 0

                        Behavior on angle {
                            NumberAnimation {
                                duration: 600
                            }
                        }
                    }
                }
            }

            Text {
                id: popular_payments_text

                text: qsTr("Популярные платежи")
                font.pixelSize: 28
                anchors {
                    top: erip_text.top
                    horizontalCenter: popular_payments.horizontalCenter
                }
            }

            Text {
                id: payments_history_text
                text: "История платежей"
                font.pixelSize: 28
                anchors {
                    top: popular_payments.bottom
                    topMargin: 10
                    horizontalCenter: popular_payments.horizontalCenter
                }
            }

            Rectangle {
                id: payments_history

                anchors {

                    top: payments_history_text.bottom
                    topMargin: 15
                    left: erip.right
                    leftMargin: 25
                    right: payments.right
                    rightMargin: 30
                    bottom: payments.bottom
                    bottomMargin: 20
                }
                //                border.color: "#d088f2"
                color: "#fdffbd"

                //                border.width: 3
                //                radius: 8
                ListView {
                    currentIndex: -1
                    id: history
                    x: 41
                    y: 112
                    width: 385
                    height: 719
                    anchors {
                        fill: parent
                    }
                    model: historyModel
                    delegate: historyDelegate

                    focus: true
                    clip: true
                    highlight: Rectangle {
                        z: 1
                        color: "transparent"
                        border.width: 3
                        border.color: "#d088f2"
                    }
                }

                ListModel {
                    id: historyModel
                    ListElement {
                        value: "32"
                        name: "Приорбанк"
                        date: "12.12.21"
                    }
                    ListElement {
                        value: "32"

                        name: "Гаи"
                        date: "12.12.21"
                    }
                    ListElement {
                        value: "32"
                        date: "12.12.21"

                        name: "Погашение кредита"
                    }
                    ListElement {
                        value: "33472"
                        date: "12.12.21"

                        name: "Коммунальные платежи"
                    }
                    ListElement {
                        value: "32"
                        date: "12.12.21"

                        name: "МТС"
                    }
                    ListElement {
                        name: "Приорбанк"
                        value: "32"
                        date: "12.12.21"
                    }
                    ListElement {
                        name: "Гаи"
                        value: "32"
                        date: "12.12.21"
                    }
                    ListElement {
                        name: "Погашение кредита"
                        value: "32"
                        date: "12.12.21"
                    }
                    ListElement {

                        name: "Коммунальные платежи"
                        value: "32"
                        date: "12.12.21"
                    }
                    ListElement {

                        name: "МТС"
                        value: "32"
                        date: "12.12.21"
                    }
                    ListElement {
                        name: "Приорбанк"
                        value: "32"
                        date: "12.12.21"
                    }
                    ListElement {
                        name: "Гаи"
                        value: "32"
                        date: "12.12.21"
                    }
                    ListElement {
                        name: "Погашение кредита"
                        value: "32"
                        date: "12.12.21"
                    }
                    ListElement {

                        name: "Коммунальные платежи"
                        value: "329"
                        date: "12.12.21"
                    }
                    ListElement {

                        name: "МТС"
                        value: "37962"
                        date: "12.12.21"
                    }
                }
                Component {
                    id: historyDelegate

                    Rectangle {
                        radius: 8
                        color: index % 2 ? "#fcfa72" : "#fcdd6d"
                        height: 30
                        clip: true
                        width: 385
                        border.width: 1
                        border.color: "#dbaaf2"
                        readonly property ListView __lv: ListView.view

                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                        Text {

                            height: parent.height
                            text: model.name
                            font.pixelSize: 20
                            anchors {
                                left: parent.left
                                leftMargin: 15
                            }
                        }
                        Text {

                            height: parent.height
                            text: model.value
                            font.pixelSize: 20
                            anchors {
                                right: parent.right
                                rightMargin: 15
                            }
                        }
                        Text {

                            height: parent.height
                            text: model.date
                            font.pixelSize: 20
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: __lv.currentIndex = index
                            onDoubleClicked: {
                                set_payment_window()
                            }
                        }
                    }
                }
            }

            ListView {
                currentIndex: -1
                id: erip
                property var collapsed: ({})
                x: 41
                y: 112
                width: 385
                height: 719
                anchors {
                    left: payments.left
                    leftMargin: 40
                    bottom: payments.bottom
                    bottomMargin: 20
                    top: erip_text.bottom
                    topMargin: 15
                }
                model: nameModel
                delegate: nameDelegate

                focus: true
                clip: true

                highlight: Rectangle {
                    z: 1
                    color: "transparent"
                    border.width: 3
                    border.color: "#d088f2"
                }
                section {
                    property: "team"
                    criteria: ViewSection.FullString
                    delegate: Rectangle {

                        id: section_
                        signal clicked

                        radius: 4
                        color: "#dbaaf2"
                        width: 385
                        height: 40

                        border.width: 2
                        border.color: "black"
                        Text {
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                                verticalCenter: parent.verticalCenter
                            }

                            font.pixelSize: 16
                            font.bold: true
                            text: section
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                section_.clicked()
                                erip.toggleSection(section)
                            }
                        }
                        Component.onCompleted: erip.hideSection(section)
                    }
                }

                function isSectionExpanded(section) {
                    return !(section in collapsed)
                }

                function showSection(section) {
                    delete collapsed[section]
                    collapsedChanged()
                }

                function hideSection(section) {
                    collapsed[section] = true
                    collapsedChanged()
                }

                function toggleSection(section) {
                    if (isSectionExpanded((section))) {
                        hideSection(section)
                    } else {
                        showSection(section)
                    }
                }

                ListModel {
                    id: nameModel
                    ListElement {
                        name: "Погашение кредита"
                        team: "Банки, НКФО"
                    }
                    ListElement {
                        name: "Пополнение счета"
                        team: "Банки, НКФО"
                    }
                    ListElement {
                        name: "Пополнение безотзывного вклада"
                        team: "Банки, НКФО"
                    }
                    ListElement {
                        name: "Bynex"
                        team: "Криптобиржи, криптообменники"
                    }
                    ListElement {
                        name: "Currency.com"
                        team: "Криптобиржи, криптообменники"
                    }
                    ListElement {
                        name: "Free2x.com"
                        team: "Криптобиржи, криптообменники"
                    }
                    ListElement {
                        name: "Пополнение QIWI Кошелька"
                        team: "Электронные деньги"
                    }
                    ListElement {
                        name: "Пополнение ЮMoney"
                        team: "Электронные деньги"
                    }
                    ListElement {
                        name: "Продажа WMB (эл.денег)"
                        team: "Электронные деньги"
                    }
                    ListElement {
                        name: "Интернет, ТВ"
                        team: "А1"
                    }
                    ListElement {
                        name: "Кабельное ТВ"
                        team: "А1"
                    }
                    ListElement {
                        name: "Абонентская плата"
                        team: "А1"
                    }
                    ListElement {
                        name: "Услуга VOKA"
                        team: "А1"
                    }
                    ListElement {
                        name: "ZALA, byfly, Умный дом, пакеты"
                        team: "Белтелеком"
                    }
                    ListElement {
                        name: "Закрытый телефон"
                        team: "Белтелеком"
                    }
                    ListElement {
                        name: "Разовый платеж"
                        team: "Белтелеком"
                    }
                    ListElement {
                        name: "Реализация товаров"
                        team: "Белтелеком"
                    }
                    ListElement {
                        name: "Телефон"
                        team: "Белтелеком"
                    }
                    ListElement {
                        name: "ТСИС:карт/абон/корпоратив.счет"
                        team: "Белтелеком"
                    }
                    ListElement {
                        name: "Домашний интернет"
                        team: "МТС"
                    }
                    ListElement {
                        name: "Промывка водопроводных сетей"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Приемка в эксплуатацию"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Утилизация сточных вод"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Экспертная проверка водомера"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Вывоз мусора"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Газоснабжение"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Прочие услуги"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "ТО, ремонт, услуги"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Коммун. платежи АИС Расчет-ЖКУ"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Платно-бытовые услуги"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Платежи через ЦИТ"
                        team: "Коммунальные платежи"
                    }
                    ListElement {
                        name: "Выдача ВУ"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Выдача дубликата ВУ"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Компьютерные услуги"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Оформление заявления"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Практический экзамен на авто"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Практический экзамен на мото"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Предоставление автодрома"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Предоставление ТС для экзамена"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Теоретический экзамен"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Тестирование знаний ПДД"
                        team: "ГАИ"
                    }
                    ListElement {
                        name: "Репетиционное тестирование"
                        team: "Образование и развитие"
                    }
                    ListElement {
                        name: "Централизованное тестирование"
                        team: "Образование и развитие"
                    }
                    ListElement {
                        name: "Физкультурно-оздоровит. услуги"
                        team: "Образование и развитие"
                    }
                    ListElement {
                        name: "Посещение бассейна"
                        team: "Образование и развитие"
                    }
                }
                Component {
                    id: nameDelegate

                    Rectangle {
                        radius: 8
                        color: index % 2 ? "#fcfa72" : "#fcdd6d"
                        height: expanded ? 30 : 0
                        clip: true
                        width: 385
                        border.width: 1
                        border.color: "gray"
                        readonly property ListView __lv: ListView.view
                        property bool expanded: __lv.isSectionExpanded(
                                                    model.team)

                        Text {
                            id: delegate_text

                            height: parent.height
                            text: model.name
                            font.pixelSize: 20
                            anchors {
                                horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Behavior on height {
                            NumberAnimation {
                                duration: 300
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: __lv.currentIndex = index
                            onDoubleClicked: {
                                set_payment_window()
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: footer
        property int index

        height: 130
        anchors {
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }

        color: "#dbaaf2"

        PageIndicator {
            id: control
            count: 2
            currentIndex: info_lv.currentIndex

            anchors {
                top: info_lv.bottom
                topMargin: 5
                horizontalCenter: info_lv.horizontalCenter
            }

            delegate: Rectangle {
                implicitWidth: 8
                implicitHeight: 8

                radius: width / 2
                color: "#f9b54c"

                opacity: index === control.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 100
                    }
                }
            }
        }

        ListView {
            id: info_lv

            width: 400
            height: 90

            anchors {
                top: footer.top

                bottomMargin: 5
                topMargin: 10
                horizontalCenter: footer.horizontalCenter
            }
            highlightRangeMode: ListView.StrictlyEnforceRange
            clip: true
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal
            delegate: info_delegate
            model: ListModel {
                id: info_model
                ListElement {
                    source__: "/images/password_safety.jpg"
                    text__: '<html><style type="text/css"></style><a href="https://belarusbank.by/ru/33139/press/bank_news/36608">google</a></html>'
                }
                ListElement {
                    source__: "/images/news.jpg"
                    text__: '<html><style type="text/css"></style><a href="https://primepress.by/news/finansi/">google</a></html>'
                }
            }
            Component {
                id: info_delegate
                Rectangle {
                    id: rect_for_flip_card
                    width: info_lv.width
                    height: info_lv.height
                    color: "transparent"

                    Image {
                        anchors {
                            fill: parent
                        }
                        source: source__

                        Text {
                            anchors {
                                fill: parent
                            }
                            font.pixelSize: 500
                            id: link_Text
                            text: text__
                            onLinkActivated: Qt.openUrlExternally(link)
                        }
                    }
                }
            }
        }

        Text {
            anchors {
                right: footer.right
                verticalCenter: footer.verticalCenter
                rightMargin: 45
            }
            font.bold: true
            font.pixelSize: 26
            text: "Белбанк, 2022"
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}D{i:2}D{i:3}D{i:5}D{i:6}D{i:4}D{i:7}D{i:8}D{i:9}D{i:10}
D{i:11}D{i:12}D{i:1}D{i:15}D{i:22}D{i:16}D{i:39}D{i:40}D{i:41}D{i:42}D{i:44}D{i:43}
D{i:45}D{i:46}D{i:48}D{i:47}D{i:49}D{i:50}D{i:52}D{i:51}D{i:53}D{i:54}D{i:56}D{i:55}
D{i:57}D{i:58}D{i:60}D{i:59}D{i:61}D{i:62}D{i:38}D{i:37}D{i:64}D{i:65}D{i:63}D{i:14}
D{i:67}D{i:68}D{i:70}D{i:69}D{i:125}D{i:126}D{i:128}D{i:130}D{i:146}D{i:127}D{i:154}
D{i:200}D{i:152}D{i:66}D{i:13}D{i:205}D{i:211}D{i:207}D{i:215}D{i:204}
}
##^##*/

