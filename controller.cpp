#include "controller.h"

#include <QDebug>

Controller::Controller(QObject *parent) : QObject{parent} {
    database = QSqlDatabase::addDatabase("QPSQL");
    database.setHostName("localhost");
    database.setDatabaseName("bank");
    database.setUserName("root");
    database.setPassword("root");
    if (database.open()) {
        qDebug() << "Database success connection!";
    } else {
        qDebug() << "Database connetion failed.";
    }
    client.setName("root");
    makeNewCard("1234 5678 9098 7654", "09/27");
    getCardsFromDB("root");
    client.printCardsData();
}


bool Controller::enterToBank(const QString& login, const QString& password) {
    if (login == "" or password == "") {
        qDebug() << "No data in field";
        return false;
    }
    QString request_text = "SELECT * FROM bank_login WHERE login = " + login + " AND password = " + password;
    QSqlQuery login_query(database);
    if (!login_query.exec(request_text)) {
        qDebug() << "Query failed! Error: " << login_query.lastError().text();
        return false;
    }
    if (!login_query.next()) {
        qDebug() << "No such user";
        return false;
    }
    qDebug() << "Success login";
    this->client.setName(login_query.value(3).toString());
    this->getCardsFromDB(login_query.value(1).toString());
    return true;
}

void Controller::makeNewCard(const QString& card_number, const QString& valid) {
    Card new_card(card_number, client.getName(), valid);
    addNewCard(new_card);
}

bool Controller::addNewCard(Card new_card) {
    QJsonDocument cards = getCardsFromDB(client.getName());
    QSqlQuery add_card_query(database);
    add_card_query.prepare("UPDATE cards "
                           "SET card_json = :cards "
                           "WHERE owner_name = :owner_name");
    add_card_query.bindValue(1, client.getName());
    QJsonObject card;
    card["card_number"] = new_card.getNumber();
    card["valid_thru"] = new_card.getValid();
    card["balance"] = new_card.getBalance();
    if (cards.isArray()) { // если json - массив, то просто добавляем в массив
        QJsonArray cards_array = cards.array();
        cards_array << card;
        cards.setArray(cards_array);
        add_card_query.bindValue(0, QString(cards.toJson()));
    } else if (!cards.isEmpty()) { // если не массив, а один элемент, то создаем массив и добавляем второй
        QJsonArray cards_array;
        cards_array << cards.object();
        cards_array << card;
        cards.setArray(cards_array);
        add_card_query.bindValue(0, QString(cards.toJson()));
    } else { // если нет карт, то добавляем одну
        add_card_query.prepare("INSERT INTO cards (owner_name, card_json) "
                         "VALUES (:owner_name, :cards)");
        add_card_query.bindValue(0, client.getName());
        cards.setObject(card);
        add_card_query.bindValue(1, QString(cards.toJson()));
    }
    if (!add_card_query.exec()) {
        qDebug() << "Query failed! Error: " << add_card_query.lastError().text();
        return false;
    }
    return true;
}


QJsonDocument Controller::getCardsFromDB(const QString& owner_name) {
    QJsonDocument json;
    QSqlQuery get_cards_query(database);
    get_cards_query.prepare("SELECT card_json FROM cards WHERE owner_name = :owner_name");
    get_cards_query.bindValue(0, owner_name);
    if (!get_cards_query.exec()) {
        qDebug() << "Query failed! Error: " << get_cards_query.lastError().text();
        return json;
    }
    get_cards_query.next();
    std::vector<Card> cards;
    QString reply = get_cards_query.value(0).toString().remove('\\');
    json = QJsonDocument::fromJson(reply.toUtf8());
    qDebug() << "Json is " << json;
    if (!json.isArray()) {
        QJsonObject card = json.object();
        qDebug() << "Card is " << card;
        cards.push_back(Card(card["card_number"].toString(), owner_name, card["valid_thru"].toString(), card["balance"].toString().toDouble()));
    } else {
        QJsonArray cards_array = json.array();
        qDebug() << "Array is " << cards_array;

        foreach (const QJsonValue& value, cards_array) {
            qDebug() << "Card is " << value;
            cards.push_back(Card(value["card_number"].toString(), owner_name, value["valid_thru"].toString(), value["balance"].toString().toDouble()));
        }
    }
    client.setCards(cards);
    return json;
}


bool Controller::registration(const QString& login, const QString& password, const QString& owner_name) {
    if (login == "" or password == "" or owner_name == "") {
        return false;
    }
    QSqlQuery registration_query(database);
    registration_query.prepare("INSERT INTO bank_login (login, password, owner_name) "
                               "VALUES (:login, :password, :owner_name)");
    registration_query.bindValue(0, login);
    registration_query.bindValue(1, password);
    registration_query.bindValue(2, owner_name);
    if (!registration_query.exec()) {
        qDebug() << "Query failed! Error: " << registration_query.lastError().text();
        return false;
    }
    registration_query.prepare("INSERT INTO cards (owner_name) "
                               "VALUES (:owner_name)");
    registration_query.bindValue(0, owner_name);
    if (!registration_query.exec()) {
        qDebug() << "Query failed! Error: " << registration_query.lastError().text();
        return false;
    }
    qDebug() << "Success registration of user " + owner_name;
    return true;
}




