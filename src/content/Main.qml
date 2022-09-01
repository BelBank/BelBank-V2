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
        function onTest() {
            console.log("Test is working")
        }
        function onCardToQML(number, owner_name, is_gold, valid, balance) {
//                    onCardToQML: {
            console.log(mainwindow.cardlist.rowCount())
//            mainwindow.cardlist.append({"name" : owner_name, "number" : number, "valid" : valid,
//                                  "type" : is_gold ? "gold" : "silver", "system" : "visa"})

         mainwindow.cardview.model = mainwindow.cardlist.append({name : "admin", number : "5143 5478 6589 5412", valid : "24/07",
                                  type : "gold", system : "visa"})
//            mainwindow.lv
        }
    }

    MainWindow {
        id: mainwindow
    }

    Loader {
        id: loader
        anchors.fill: parent
        source: "AuthorizationWindow.qml"
    }

    //    StackView {
    //        id: error_stack
    //        initialItem: universal_message_window
    //        visible: false
    //    }
    //    Component {
    //        id: auth_window
    //        AuthorizationWindow {}
    //    }
    //    Component {
    //        id: main_window
    //        MainWindow {}
    //    }

    //    Component {
    //        id: reg_window
    //        RegistrationWindow {}
    //    }
    //    Component {
    //        id: card_window
    //        NewCardWindow {}
    //    }
    //    Component {
    //        id: payment_window
    //        PaymentWindow {}
    //    }
    //    Component {
    //        id: universal_message_window
    //        UniversalMessage {

    //        }
    //    }

    //    Component {
    //        id: insufficient_funds_error_window
    //        InsufficientFundsMessage {}
    //    }
    //    Component {
    //        id: successful_payment_message_window
    //        SuccessfulPaymentMessage {}
    //    }

    function set_text(text_) {
        idiot.text__ = text_
        idiot.visible = true
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
