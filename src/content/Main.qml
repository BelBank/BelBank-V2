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
            mainwindow.cardview.model = mainwindow.cardlist.append({
                                                                       "name": "admin",
                                                                       "number": "5143 5478 6589 5412",
                                                                       "valid": "24/07",
                                                                       "type": "gold",
                                                                       "system": "visa"
                                                                   })
            //            mainwindow.lv
        }
        function onSetError(error) {
            console.log("Error!")
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
