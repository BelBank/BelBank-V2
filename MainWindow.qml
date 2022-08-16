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
            width: 143
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
                        text: "1EUR"
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
                            source: "images/china.jpg"
                            anchors {
                                left: china.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 5
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 24
                        text: "4"
                    }
                    Text {
                        Layout.row: 5
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 24
                        text: "3.679"
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
                            source: "images/PLN.jpg"
                            anchors {
                                left: pln.right
                            }
                        }
                    }
                    Text {
                        Layout.row: 6
                        Layout.columnSpan: 1
                        Layout.column: 2
                        font.pixelSize: 24
                        text: "5.64"
                    }
                    Text {
                        Layout.row: 6
                        Layout.columnSpan: 1
                        Layout.column: 3
                        font.pixelSize: 24
                        text: "5.14"
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

                height: payments.height / 2 - 70
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

                Flipable {
                    id: popular_or_selected
                    property bool flipped: false

                    anchors.fill: parent
                    front: Item {
                        id: popular
                        anchors {
                            fill: parent
                            margins: 15
                        }

                        Rectangle {
                            width: 40
                            height: 40
                            radius: 10
                            color: "black"
                            id: swap_button_to_selected
                            anchors {
                                bottom: popular.bottom
                                left: popular.left
                            }
                            Image {
                                visible: false
                                width: 40
                                height: 40

                                anchors {
                                    centerIn: parent
                                }
                                source: "images/swap.png"
                            }
                        }
                    }
                    back: Item {
                        id: selected
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
                    MouseArea {
                        anchors.fill: parent
                        onClicked: popular_or_selected.flipped = !popular_or_selected.flipped
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
                text: qsTr("История платежей")
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
                border.color: "#d088f2"
                color: "#fdffbd"
                border.width: 3
                radius: 8
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
                onCurrentItemChanged: console.log(
                                          model.get(
                                              erip.currentIndex).name + ' selected')
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
                        color: "#d088f2"
                        width: 385
                        height: 30
                        border.width: 2
                        border.color: "gray"
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
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
                        name: "Alice"
                        team: "Crypto"
                    }
                    ListElement {
                        name: "Bob"
                        team: "Crypto"
                    }
                    ListElement {
                        name: "Jane"
                        team: "Crypto"
                    }
                    ListElement {
                        name: "Victor"
                        team: "QA"
                    }
                    ListElement {
                        name: "Wendy"
                        team: "Graphics"
                    }
                }
                Component {
                    id: nameDelegate

                    Rectangle {
                        radius: 3
                        color: "#fcfa72"
                        height: expanded ? 30 : 0
                        clip: true
                        width: 385
                        border.width: 1
                        border.color: "gray"
                        readonly property ListView __lv: ListView.view
                        property bool expanded: __lv.isSectionExpanded(
                                                    model.team)
                        anchors {
                            left: parent.left
                            right: parent.right
                        }
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
                                duration: 200
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: __lv.currentIndex = index
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:2}D{i:3}D{i:5}D{i:6}D{i:4}D{i:7}D{i:8}D{i:9}D{i:10}D{i:11}
D{i:12}D{i:1}D{i:14}D{i:13}D{i:17}D{i:24}D{i:18}D{i:40}D{i:41}D{i:42}D{i:43}D{i:45}
D{i:44}D{i:46}D{i:47}D{i:49}D{i:48}D{i:50}D{i:51}D{i:53}D{i:52}D{i:54}D{i:55}D{i:57}
D{i:56}D{i:58}D{i:59}D{i:61}D{i:60}D{i:62}D{i:63}D{i:39}D{i:38}D{i:65}D{i:66}D{i:64}
D{i:16}D{i:68}D{i:69}D{i:77}D{i:71}D{i:70}D{i:78}D{i:79}D{i:80}D{i:83}D{i:89}D{i:81}
D{i:67}D{i:15}
}
##^##*/

