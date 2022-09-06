import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.12

ApplicationWindow {
    id: main_stack_window
    width: 1920
    height: 1080
    property var payment_name
    property bool requisites: false

    Connections {
        target: Controller
        function onCardToQML(number, owner_name, type, valid, system, balance) {
            console.log("Row count: ", loader.item.cardlist.rowCount())
            console.log("Cards count: ", Controller.getCardsCount())
            if (loader.item.cardlist.rowCount(
                        ) === Controller.getCardsCount()) {
                loader.item.cardview.clearModel()
            }
            console.log("card to qml, number: " + number)
            loader.item.cardview.addElement(number, owner_name, type, valid,
                                            system, balance)

            console.warn("name ", loader.item.cardlist.get(0).name)
            console.warn("number ", loader.item.cardlist.get(0).number)
            console.warn("valid ", loader.item.cardlist.get(0).valid)
            console.warn("type ", loader.item.cardlist.get(0).type)
            console.warn("system ", loader.item.cardlist.get(0).system)
        }
        function onPaymentToQML(payment) {
            if (loader.item.paymentlist.rowCount(
                        ) === Controller.getFavPaymentsCount()) {
                loader.item.paymentview.clearModel()
            }
            loader.item.paymentview.addFavPayment(payment)
        }

        function onRecPaymentsToQML(name, date, time, cost) {
            console.log("Recent payment " + name + ' ' + date)
            loader.item.recentPaymentView.addElement(name, date, time, cost)
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
        property alias loaderItem: loader.item

        asynchronous: true
        visible: true
        id: loader
        anchors.fill: parent
        anchors.centerIn: parent

        source: "AuthorizationWindow.qml"
        onLoaded: {
            console.log("Loader name ", loader.item.name)
            if (loader.item.name === "payment") {
                loader.item.name = payment_name
                loader.item.requisites = main_stack_window.requisites
            }
            loader.item.cardview.clearModel()
            Controller.prepareQML(loader.source)
        }
    }

    function set_main_window() {

        loader.item.transientParent = null
        loader.source = "MainWindow.qml"
    }

    function set_authorization_window() {
        // loader.item.transientParent = null
        loader.source = "AuthorizationWindow.qml"
        //loader.item.transientParent = null
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

    function set_payment_window(str, req = false) {
        loader.source = "PaymentWindow.qml"
        payment_name = str
        requisites = req
    }
}
