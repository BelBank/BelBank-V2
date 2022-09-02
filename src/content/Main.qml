import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

ApplicationWindow {
    id: main_stack_window
    width: 1920
    height: 1080

    Connections {
        target: Controller
        function onSetError(error) {
            console.warn("Error!")
            mainwindow.set_error(error)
        }
    }

    MainWindow {
        id: mainwindow
    }


    Loader {

        asynchronous: true
        visible: true
        id: loader
        anchors.fill: parent
        source: "AuthorizationWindow.qml"
    }



    function set_main_window() {

        loader.source = "MainWindow.qml"
    }

    function set_authorization_window() {
        loader.source = "AuthorizationWindow.qml"
    }

    function set_registration_window() {
        loader.source = "RegistrationWindow.qml"
    }

    function set_new_card_window() {
        loader.source = "NewCardWindow.qml"
    }

    function set_add_card_window() {
        loader.source = "AddCardWindow.qml"
    }

    function set_payment_window() {
        loader.source = "PaymentWindow.qml"
    }
}
