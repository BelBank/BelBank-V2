import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

ApplicationWindow {
    id: main_stack_window
    width: 1920
    height: 1080

    Loader {
        id: loader
        anchors.fill: parent
        source: "AuthorizationWindow.qml"
    }

    StackView {
        id: error_stack
    }

    Component {
        id: auth_window
        AuthorizationWindow {}
    }
    Component {
        id: main_window
        MainWindow {
            onErrored: {

                universal_message_window.message_ = text_
                error_stack.push(universal_message_window)
            }
        }
    }
    Component {
        id: reg_window
        RegistrationWindow {}
    }
    Component {
        id: card_window
        NewCardWindow {}
    }
    Component {
        id: payment_window
        PaymentWindow {}
    }
    Component {
        id: universal_message_window
        UniversalMessage {}
    }
    Component {
        id: insufficient_funds_error_window
        InsufficientFundsMessage {}
    }
    Component {
        id: successful_payment_message_window
        SuccessfulPaymentMessage {}
    }

    function set_universal_message(text) {

        loader.source = "UniversalMessage.qml"
        universal_message_window.message__ = text
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

    function set_payment_window() {
        loader.source = "PaymentWindow.qml"
    }
}
