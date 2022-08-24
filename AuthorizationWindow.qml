import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {
    id: main
    width: 1920
    visible: true
    height: 1080
    flags: {
        Qt.CustomizeWindowHint
        Qt.WindowFullScreen
    }

    Image {
        width: 1920
        height: 1080
        anchors.fill: parent
        source: "images/Fon.jpg"
    }

    Rectangle {
        id: phone
        x: main.width / 2 - 120
        y: main.height / 2 + 90
        width: 350
        height: 40
        color: "white"
        border.color: "#d088f2"
        border.width: 3
        radius: 10

        TextInput {
            maximumLength: 27
            anchors {
                fill: parent
                topMargin: 10
                leftMargin: 15
            }
            color: activeFocus ? "black" : "gray"
            focus: true
            activeFocusOnTab: true
            font.family: "Helvetica"
            font.pointSize: 16
        }
    }

    Rectangle {
        id: phoneid
        x: main.width / 2 - 80
        y: main.height / 2 + 70
        anchors.right: phone.left
        anchors.rightMargin: 10
        anchors.top: phone.top
        width: 100
        height: 40
        color: "#fdffbd"
        border.color: "#d088f2"
        border.width: 3
        radius: 10

        Text {
            anchors.centerIn: parent
            text: "Телефон"
            color: "#222024"
            font.family: "Helvetica"
            font.pointSize: 14
            font.bold: true
        }
    }

    Rectangle {
        id: password
        anchors {
            top: phone.bottom
            topMargin: 15
            right: phone.right
            left: phone.left
        }
        x: main.width / 2 - 120
        width: 380
        height: 40
        color: "white"
        border.color: "#d088f2"
        border.width: 3
        radius: 10

        TextInput {
            id: text0
            maximumLength: 25
            anchors {
                top: password.top
                left: password.left
                right: password.right
                bottom: password.bottom
                topMargin: 10
                leftMargin: 15
            }
            color: activeFocus ? "black" : "gray"
            focus: true
            activeFocusOnTab: true
            font.family: "Helvetica"
            font.pointSize: 16
            echoMode: TextInput.Password
            //passwordCharacter: QString
            passwordMaskDelay: 500
        }
    }

    Rectangle {
        id: passwordid
        x: main.width / 2 - 120
        y: main.height / 2 + 2
        anchors.right: password.left
        anchors.rightMargin: 10
        anchors.top: password.top
        anchors.left: phoneid.left
        width: 140
        height: 40
        color: "#fdffbd"
        border.color: "#d088f2"
        border.width: 3
        radius: 10

        Text {
            anchors.centerIn: parent
            text: "Пароль"
            color: "#222024"
            font.family: "Helvetica"
            font.pointSize: 14
            font.bold: true
        }
    }

    Rectangle {
        id: enter
        width: 530
        height: 45
        anchors {
            top: password.bottom
            right: password.right
            left: phoneid.left
            topMargin: 15
        }
        color: "#d088f2"
        border.color: "#7d3a9c"
        border.width: 2
        radius: 10

        Text {
            anchors.centerIn: parent
            text: "Войти"
            color: "#222024"
            font.family: "Helvetica"
            font.pointSize: 17
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                set_main_window()
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

    Rectangle {
        id: register
        width: 530
        height: 30
        anchors {
            top: enter.bottom
            right: password.right
            left: enter.left
            topMargin: 10
        }
        color: "#d088f2"
        border.color: "#7d3a9c"
        border.width: 2
        radius: 10

        Text {
            anchors.centerIn: parent
            text: "Зарегистрироваться"
            color: "#222024"
            font.family: "Helvetica"
            font.pointSize: 12
            font.bold: true
        }

        MouseArea {

            anchors.fill: parent
            onClicked: {
                set_registration_window()
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
