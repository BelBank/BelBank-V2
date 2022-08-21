import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

Window {
    id: registration_window
    width: 800
    height: 600
    visible: true
    Rectangle {
        id: rectangler
        anchors {
            fill: parent
        }
        color: "white"

        Image {
            id: logo_on_background
            source: "images/capture_20220617214014956.png"
            width: 350
            height: 250
            anchors {
                horizontalCenter: rectangler.horizontalCenter
                bottom: rectangler.verticalCenter
            }
        }

        Rectangle {
            id: nickname_text
            width: 200
            height: 40
            color: "#fdffbd"
            border.color: "#d088f2"
            border.width: 3
            radius: 10

            anchors {
                left: rectangler.left
                leftMargin: 100
                top: logo_on_background.bottom
                margins: 15
            }
            Text {
                text: "Никнейм"
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
            color: "#fdffbd"
            border.color: "#d088f2"
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
            color: "#fdffbd"
            border.color: "#d088f2"
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
                passwordMaskDelay: 500
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
            border.color: "#d088f2"
            border.width: 3
            radius: 10

            TextInput {
                id: text1
                maximumLength: 25
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

            color: "#d088f2"
            border.color: "#7d3a9c"
            border.width: 3
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Зарегистрироваться"
                color: "#222024"
                font.family: "Helvetica"
                font.pointSize: 14
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

        Rectangle {
            id: back_to_auth

            height: 30
            width: 230
            anchors {
                top: rectangler.top
                right: rectangler.right
                margins: 15
            }
            color: "#d088f2"
            border.color: "#7d3a9c"
            border.width: 3
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "Вернуться на окно входа"
                color: "#222024"
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
}
