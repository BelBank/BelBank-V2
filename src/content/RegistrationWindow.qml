import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {
    id: registration_window
    width: 800
    height: 600
    visible: true

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
    Rectangle {
        id: rectangler
        anchors {
            fill: parent
        }
        color: "white"

        Image {
            id: logo_on_background
            source: "/images/Logo.png"
            width: 445
            height: 250
            anchors {
                horizontalCenter: rectangler.horizontalCenter
                bottom: rectangler.verticalCenter
            }
        }

        Rectangle {
            id: name_text
            width: 200
            height: 40
            color: "#d5e2ff"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            anchors {
                left: rectangler.left
                leftMargin: 100
                top: logo_on_background.bottom
                margins: 15
            }
            Text {
                text: "Имя"
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
            id: nickname_text
            width: 200
            height: 40
            color: "#d5e2ff"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            anchors {
                left: rectangler.left
                leftMargin: 100
                top: name_text.bottom
                margins: 15
            }
            Text {
                text: "Логин"
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
            id: password_text
            width: 200
            height: nickname_text.height
            color: "#d5e2ff"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            anchors {
                left: rectangler.left
                leftMargin: 100
                top: nickname_text.bottom
                margins: 15
            }
            Text {
                text: "Пароль"
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
            id: repeat_password_text
            width: 200
            height: nickname_text.height
            color: "#d5e2ff"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            anchors {
                left: rectangler.left
                leftMargin: 100
                top: password_text.bottom
                margins: 15
            }
            Text {
                text: "Повторите пароль"
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
            id: name
            anchors {
                leftMargin: 15

                top: name_text.top
                left: name_text.right
                right: rectangler.right
                rightMargin: 100
            }

            height: nickname_text.height
            color: "white"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            TextInput {
                id: name_input
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
            id: nickname
            anchors {
                leftMargin: 15

                top: nickname_text.top
                left: nickname_text.right
                right: rectangler.right
                rightMargin: 100
            }

            height: nickname_text.height
            color: "white"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            TextInput {
                id: nickname_input
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
            id: password

            anchors {
                leftMargin: 15

                top: password_text.top
                left: password_text.right
                right: rectangler.right
                rightMargin: 100
            }

            height: nickname_text.height
            color: "white"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            TextInput {
                id: text_password
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
                echoMode: TextInput.Password
                passwordMaskDelay: 500
                onFocusChanged: {
                    if (activeFocus) {
                        cursorPosition = 0
                    }
                }
            }
        }

        Rectangle {
            id: repeat_password
            anchors {
                top: repeat_password_text.top
                left: repeat_password_text.right
                right: rectangler.right
                rightMargin: 100
                leftMargin: 15
            }

            height: nickname_text.height
            color: "white"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            TextInput {
                id: text_repeat_password
                maximumLength: 16
                anchors {
                    top: repeat_password.top
                    left: repeat_password.left
                    right: repeat_password.right
                    bottom: repeat_password.bottom
                    topMargin: 10
                    leftMargin: 15
                }
                color: activeFocus ? "black" : "gray"
                focus: true
                activeFocusOnTab: true
                font.family: "Helvetica"
                font.pointSize: 16
                echoMode: TextInput.Password
                passwordMaskDelay: 500
                onFocusChanged: {
                    if (activeFocus) {
                        cursorPosition = 0
                    }
                }
            }
        }

        Rectangle {
            id: register

            height: 40
            anchors {
                top: repeat_password.bottom
                left: repeat_password_text.left
                right: repeat_password.right
                topMargin: 14
            }

            color: "#6e91de"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Зарегистрироваться"
                color: "white"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true
            }

            MouseArea {

                anchors.fill: parent
                onClicked: {
                    if (name_input.text == "") {
                        set_error("Введите имя!")
                    }else if (nickname_input.text == "") {
                        set_error("Введите никнейм!")
                    }else if (text_password.length < 8) {
                        set_error("Пароль обязан состоять из 8 и более символов!")
                    }else if (text_password.text != text_repeat_password.text) {
                        set_error("Пароли не совпадают!")
                    } else if (!Controller.registration(nickname_input.text,
                                                        text_password.text,
                                                        name_input.text)) {
                        set_error("Ошибка регистрации!")
                    } else {
                        set_error("Пользователь успешно зарегистрирован!",
                                  "auth")
                    }
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
            id: back_to_auth

            height: 30
            width: 230
            anchors {
                top: rectangler.top
                right: rectangler.right
                margins: 15
            }
            color: "#6e91de"
            border.color: "#386cde"
            border.width: 3
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Вернуться на окно входа"
                color: "white"
                font.family: "Helvetica"
                font.pointSize: 12
                font.bold: true
            }

            MouseArea {

                anchors.fill: parent
                onClicked: {
                    set_authorization_window()
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
