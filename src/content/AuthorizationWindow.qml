import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {

    id: main
    width: 1920
    visible: true
    height: 1080

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
    Image {
        width: 1920
        height: 1080
        anchors.fill: parent
        source: "/images/Fon.jpg"
    }

    Rectangle {
        id: phone
        x: main.width / 2 - 120
        y: main.height / 2 + 90
        width: 350
        height: 40
        color: "white"
        border.color: "#264892"
        border.width: 3
        radius: 10

        TextInput {
            id: login_text
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
            onFocusChanged: {
                if (activeFocus) {
                    cursorPosition = 0
                }
            }
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
        color: "#d5e2ff"
        border.color: "#264892"
        border.width: 3
        radius: 10

        Text {
            anchors.centerIn: parent
            text: "Логин"
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
        border.color: "#264892"
        border.width: 3
        radius: 10

        TextInput {
            property bool showText: false
            property bool onFocus: false

            id: text0
            maximumLength: 16
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
            echoMode: showText ? TextField.Normal : TextField.Password
            passwordMaskDelay: 100
            onFocusChanged: {
                if (activeFocus) {
                    cursorPosition = 0
                }
            }
        }

        Rectangle {
            width: parent.height
            height: parent.height
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: 4
            }
            radius: 4
            color: text0.showText ? "#d5e2ff" : "transparent"
            Image {
                id: visible_password_icon
                width: parent.height
                height: parent.height
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                }
                source: "/images/password_visible.png"
                MouseArea {
                    anchors {
                        fill: parent
                    }
                    onPressed: {
                        text0.showText = true
                    }
                    onReleased: {
                        text0.showText = false
                    }
                }
            }
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
        color: "#d5e2ff"
        border.color: "#264892"
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
        color: "#6e91de"
        radius: 8
        border.width: 3
        border.color: "#264892"

        Text {
            anchors.centerIn: parent
            text: "Войти"
            font.family: "Helvetica"
            font.pointSize: 12
            font.bold: true
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (Controller.enterToBank(login_text.text, text0.text)) {
                    set_main_window()
                } else {
                    set_error("Проверьте правильность введённых данных!",
                              "main") //убрать "main" при релизе
                }
            }

            onPressed: {
                parent.color = "#242f67"
                parent.border.color = "dark gray"
            }
            onReleased: {
                parent.color = "#6e91de"
                parent.border.color = "#264892"
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
        color: "#6e91de"
        radius: 8
        border.width: 3
        border.color: "#264892"

        Text {
            anchors.centerIn: parent
            text: "Зарегистрироваться"
            font.family: "Helvetica"
            font.pointSize: 12
            font.bold: true
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                set_registration_window()
            }

            onPressed: {
                parent.color = "#242f67"
                parent.border.color = "dark gray"
            }
            onReleased: {
                parent.color = "#6e91de"
                parent.border.color = "#264892"
            }
        }
    }
}
