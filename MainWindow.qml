import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {
    id: mainwindow
    width: 1920
    height: 1080
    visible: true

    Rectangle {
        id: header
        height: 100
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
        }
        color: "#d088f2"

        Image {
            id: logo
            width: 300
            height: 100
            source: "images/capture_20220617214014956.png"
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
            font.pixelSize: 30
            font.bold: true

            text: "Nickname" ///тут должен присваиваться ник клиента.
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
            color: "#b24bd1"
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
            source: "images/free-icon-telephone-4996346 (1).png"
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
            font.pixelSize: 18
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
        id: footer
        height: 100
        anchors {
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }
        color: "#7d3a9c"

        Text {
            anchors {
                right: footer.right
                verticalCenter: footer.verticalCenter
                rightMargin: 45
            }
            font.bold: true
            font.pixelSize: 24
            text: "Белбанк, 2022"
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
        color: "#fdffbd"
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
            border.color: "#d088f2"
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
                        type: "gold"
                        system: "visa"
                    }
                    ListElement {
                        name: "Шурик Скворцов"
                        number: "1234 5678 7654 5678"
                        valid: "35/08"
                        type: "silver"
                        system: "visa"
                    }
                    ListElement {
                        name: "PaShampusik"
                        number: "1346 5678 1234 5678"
                        valid: "25/08"
                        type: "gold"
                        system: "mastercard"
                    }
                    ListElement {
                        name: "Павел Староста"
                        number: "1234 5678 1234 5678"
                        valid: "25/08"
                        type: "gold"
                        system: "visa"
                    }
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
                                    sorce = "images/Golden card VISA.png"
                                } else {
                                    sorce = "images/Golden Card Mastercard.png"
                                }
                            } else {
                                if (card.system) {
                                    sorce = "images/Silver card VISA.png"
                                } else {
                                    sorce = "images/Silver card Mastercard.png"
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
                                anchors {
                                    //fill: parent
                                    centerIn: parent
                                }
                                color: "gray"
                                radius: 8
                                border.width: 3
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
                color: "#fdffbd"
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
                border.width: 3
                border.color: "#d088f2"
                GridLayout {
                    rows: 5
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
                        font.pixelSize: 25
                        font.bold: true

                        Layout.alignment: Qt.AlignCenter
                        text: "Курсы валют в отделениях БелБанка"
                    }
                    Text {
                        Layout.row: 1
                        Layout.columnSpan: 2
                        Layout.column: 0
                        font.pixelSize: 19
                        font.bold: true
                        text: "Валюта:"
                    }
                    Text {
                        Layout.row: 1
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 19
                        font.bold: true

                        text: "Продажа:"
                    }
                    Text {
                        Layout.row: 1
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 19
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
                            source: "images/RUB.png"
                            anchors {
                                left: rub.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 2
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 24
                        text: "4.32"
                    }
                    Text {
                        Layout.row: 2
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 24
                        text: "4.297"
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
                            source: "images/USD.png"
                            anchors {
                                left: usd.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 3
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 24
                        text: "2.63"
                    }
                    Text {
                        Layout.row: 3
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 24
                        text: "2.59"
                    }
                    Text {
                        Layout.row: 4
                        Layout.columnSpan: 2
                        Layout.column: 0
                        id: euro
                        text: "1EURO"
                        font.pixelSize: 20
                        Image {
                            width: 40
                            height: 30
                            source: "images/EURO.png"
                            anchors {
                                left: euro.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 4
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 24
                        text: "3.2"
                    }
                    Text {
                        Layout.row: 4
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 24
                        text: "3.15"
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
                color: "#d088f2"
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
                        parent.color = "#7d3a9c"
                        parent.border.color = "dark gray"
                    }
                    onReleased: {
                        parent.color = "#d088f2"
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
            border.color: "#d088f2"
            color: "#fdffbd"

            Text {
                id: payments_text
                anchors {
                    horizontalCenter: payments.horizontalCenter
                    top: payments.top
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

                height: payments.height / 4
                border.color: "#d088f2"
                color: "#fdffbd"
                border.width: 3
                radius: 8
                anchors {
                    left: erip.right
                    leftMargin: 25
                    right: payments.right
                    rightMargin: 30
                    top: erip.top
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

            Rectangle {
                id: selected_payments
                height: payments.height / 4
                anchors {

                    top: selected_payments_text.bottom
                    topMargin: 15
                    left: erip.right
                    leftMargin: 25
                    right: payments.right
                    rightMargin: 30
                }
                border.color: "#d088f2"
                color: "#fdffbd"
                border.width: 3
                radius: 8
            }

            Text {
                id: selected_payments_text
                text: qsTr("Избранные платежи")
                font.pixelSize: 28
                anchors {
                    top: popular_payments.bottom
                    topMargin: 10
                    horizontalCenter: popular_payments.horizontalCenter
                }
            }

            Text {
                id: payments_history_text
                text: qsTr("История платежей")
                font.pixelSize: 28
                anchors {
                    top: selected_payments.bottom
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
                border.color: "#d088f2"
                color: "#fdffbd"
                border.width: 3
                radius: 8
            }

            ListView {
                id: erip
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

                model: ListModel {
                    ListElement {
                        colorCode: "grey"
                    }

                    ListElement {
                        colorCode: "red"
                    }

                    ListElement {
                        colorCode: "blue"
                    }

                    ListElement {
                        colorCode: "green"
                    }
                }
                delegate: Item {
                    x: 5
                    width: 200
                    height: 40
                    Row {
                        id: row1
                        spacing: 10
                        Rectangle {
                            width: 385
                            height: 40
                            color: colorCode
                        }

                        Text {
                            text: "aaa"
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: true
                        }
                    }
                }
            }
        }

        //            Rectangle {
        //                width: 360
        //                height: 360

        //                ListModel {
        //                    id: dataModel

        //                    ListElement {
        //                        color: "orange"
        //                        text: "first"
        //                    }
        //                    ListElement {
        //                        color: "lightgreen"
        //                        text: "second"
        //                    }
        //                    ListElement {
        //                        color: "orchid"
        //                        text: "third"
        //                    }
        //                    ListElement {
        //                        color: "tomato"
        //                        text: "fourth"
        //                    }
        //                }

        //                GridView {
        //                    id: view

        //                    anchors.margins: 10
        //                    anchors.fill: parent
        //                    cellHeight: 100
        //                    cellWidth: cellHeight
        //                    model: dataModel
        //                    clip: true

        //                    highlight: Rectangle {
        //                        color: "skyblue"
        //                    }

        //                    delegate: Item {
        //                        property var view: GridView.view
        //                        property var isCurrent: GridView.isCurrentItem

        //                        height: view.cellHeight
        //                        width: view.cellWidth

        //                        Rectangle {
        //                            anchors.margins: 5
        //                            anchors.fill: parent
        //                            color: model.color
        //                            border {
        //                                color: "black"
        //                                width: 1
        //                            }

        //                            Text {
        //                                anchors.centerIn: parent
        //                                renderType: Text.NativeRendering
        //                                text: "%1%2".arg(model.text).arg(isCurrent ? " *" : "")
        //                            }

        //                            MouseArea {
        //                                anchors.fill: parent
        //                                onClicked: view.currentIndex = model.index
        //                            }
        //                        }
        //                    }
        //                }
        //            }

        //            Rectangle {
        //                width: 360
        //                height: 360

        //                ListModel {
        //                    id: dataModel

        //                    ListElement {
        //                        color: "orange"
        //                        text: "first"
        //                    }
        //                    ListElement {
        //                        color: "lightgreen"
        //                        text: "second"
        //                    }
        //                    ListElement {
        //                        color: "orchid"
        //                        text: "third"
        //                    }
        //                    ListElement {
        //                        color: "tomato"
        //                        text: "fourth"
        //                    }
        //                }

        //                TableView {
        //                    id: view

        //                    anchors.margins: 10
        //                    anchors.fill: parent
        //                    model: dataModel
        //                    clip: true

        //                    TableViewColumn {
        //                        width: 100
        //                        title: "Color"
        //                        role: "color"
        //                    }
        //                    TableViewColumn {
        //                        width: 100
        //                        title: "Text"
        //                        role: "text"
        //                    }

        //                    itemDelegate: Item {
        //                        Text {
        //                            anchors.centerIn: parent
        //                            renderType: Text.NativeRendering
        //                            text: styleData.value
        //                        }
        //                    }
        //                }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:2}D{i:3}D{i:5}D{i:6}D{i:4}D{i:7}D{i:8}D{i:9}D{i:10}D{i:11}
D{i:12}D{i:1}D{i:14}D{i:13}D{i:17}D{i:24}D{i:18}D{i:40}D{i:41}D{i:42}D{i:43}D{i:45}
D{i:44}D{i:46}D{i:47}D{i:49}D{i:48}D{i:50}D{i:51}D{i:53}D{i:52}D{i:54}D{i:55}D{i:39}
D{i:38}D{i:57}D{i:58}D{i:56}D{i:16}D{i:60}D{i:61}D{i:62}D{i:63}D{i:64}D{i:65}D{i:66}
D{i:67}D{i:68}D{i:59}D{i:15}
}
##^##*/

