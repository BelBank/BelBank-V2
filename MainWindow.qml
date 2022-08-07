import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

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

            text: "Pidor" ///тут должен присваиваться ник клиента.
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
                font.pixelSize: 26
            }

            ListView {
                height: 240
                width: 450
                anchors {
                    top: finance_text.top
                    left: finance.left
                    margins: 40
                }

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
                                width: 450
                                anchors {
                                    //fill: parent
                                    centerIn: parent
                                }
                                source: getCard()
                            }
                            back: Rectangle {
                                id: card_info
                                height: 180
                                width: 450
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
                                        duration: 500
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
        }
    }
}
