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
        function onCardToQML(number, owner_name, type, valid, system, balance) {
            console.log("Row count: ", loader.item.cardlist.rowCount())
            console.log("Cards count: ", Controller.getCardsCount())
            if (loader.item.cardlist.rowCount() === Controller.getCardsCount()) {
                loader.item.cardview.clearModel();

            }
            console.log("card to qml, number: " + number)
            loader.item.cardview.addElement(number, owner_name, type, valid, system, balance)

            console.warn("name ", loader.item.cardlist.get(0).name)
            console.warn("number ", loader.item.cardlist.get(0).number)
            console.warn("valid ", loader.item.cardlist.get(0).valid)
            console.warn("type ", loader.item.cardlist.get(0).type)
            console.warn("system ", loader.item.cardlist.get(0).system)
        }
        function onSetError(error) {
            console.log("Error!")
            mainwindow.set_error(error)
        }
    }

    MainWindow {
        id: mainwindow
        visible: false
    }


    Loader {

        asynchronous: true
        visible: true
        id: loader
        anchors.fill: parent
        source: "AuthorizationWindow.qml"
        onLoaded: {
            loader.item.cardview.clearModel();
            Controller.prepareQML(loader.source)
        }
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
