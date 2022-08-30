#include "controller.h"

#include <QDebug>

Controller::Controller(QObject* parent) : QObject{parent} {
    database = QSqlDatabase::addDatabase("QPSQL");

    // Connect to local database
    //    database.setHostName("localhost");
    //    database.setDatabaseName("bank");
    //    database.setUserName("root");
    //    database.setPassword("root");

    //    Connect to PostgreSQL host
    database.setHostName("163.123.183.87");
    database.setPort(11967);
    database.setDatabaseName("bank");
    database.setUserName("root");
    database.setPassword("drakonkapusta");

    if (database.open()) {
        qDebug() << "Database success connection!";
    } else {
        qDebug() << "Database connetion failed.";
    }
    //    exchangeRates();
}

QByteArray Controller::hashPassword(const QString& password) {
    QByteArray hash(password.toStdString().c_str());
    hash = QCryptographicHash::hash(hash, QCryptographicHash::Sha3_256);
    hash = QCryptographicHash::hash(hash, QCryptographicHash::Sha3_512);
    qDebug() << "Hashed password: " << hash;
    return hash;
}

QString Controller::getUserName() const {
    return client.getName();
}

bool Controller::enterToBank(const QString& login, const QString& password) {
    qDebug() << "Entering...";
    if (login == "" or password == "") {
        qDebug() << "No data in field";
        return false;
    }
    QSqlQuery login_query(database);
    login_query.prepare("SELECT * FROM bank_login WHERE login = :login AND password = :password");
    login_query.bindValue(0, login);
    login_query.bindValue(1, hashPassword(password));
    if (!login_query.exec()) {
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

bool Controller::makeNewCard(const QString& card_number, bool is_gold, const QString& valid) {
    QString valid_copy = valid;
    if (QDate(QDate::fromString("01/" + valid_copy.insert(3, "20"), "dd/MM/yyyy")) < QDate::currentDate()) {
        qDebug() << "Card is not valid";
        return false;
    }
    Card new_card(card_number, client.getName(), is_gold, valid);
    if (!addNewCard(new_card)) {
        return false;
    }
    return true;
}

bool Controller::addNewCard(Card new_card) {
    std::vector<Card> cards = client.getCards();
    QSqlQuery add_card_query(database);
    add_card_query.prepare(
            "INSERT INTO card (number, is_gold, valid, balance) "
            "VALUES (:number, :is_gold, :valid, :balance)");
    add_card_query.bindValue(0, new_card.getNumber());
    add_card_query.bindValue(1, new_card.getType());
    add_card_query.bindValue(2, new_card.getValid());
    add_card_query.bindValue(3, new_card.getBalance());
    if (!add_card_query.exec()) {
        qDebug() << "Query failed! Error: " << add_card_query.lastError().text();
        return false;
    }
    QVector<int> cards_id = getCardsId(client.getName());
    if (!add_card_query.exec("SELECT id FROM card ORDER BY id DESC LIMIT 0, 1")) {
        qDebug() << "Query failed! Error: " << add_card_query.lastError().text();
        return false;
    }
    cards_id.push_back(add_card_query.value("id").toInt());
    add_card_query.prepare(
            "UPDATE card_owner "
            "SET cards = :cards "
            "WHERE owner_name = :owner_name");
    QList<QVariant> cards_array;
    foreach (const int& value, cards_id) {
        cards_array.push_back(QVariant(value));
    }
    add_card_query.bindValue(0, cards_array);
    add_card_query.bindValue(1, client.getName());

    if (!add_card_query.exec()) {
        qDebug() << "Query failed! Error: " << add_card_query.lastError().text();
        return false;
    }
    return true;
}

QVector<int> Controller::getCardsId(const QString& owner_name) {
    QSqlQuery get_cards_id_query(database);
    QVector<int> cards_id;
    get_cards_id_query.prepare("SELECT cards FROM card_owner WHERE owner_name = :owner_name");
    get_cards_id_query.bindValue(0, owner_name);
    if (!get_cards_id_query.exec()) {
        qDebug() << "Query failed! Error: " << get_cards_id_query.lastError().text();
        cards_id.push_back(0);
        return cards_id;
    }
    get_cards_id_query.next();
    QList<QVariant> cards_qvariant = get_cards_id_query.value("cards").toList();
    foreach (const QVariant& val, cards_qvariant) {
        cards_id.push_back(val.toInt());
    }
    return cards_id;
}

bool Controller::getCardsFromDB(const QString& owner_name) {
    QSqlQuery get_cards_query(database);
    QVector<int> cards_id = getCardsId(owner_name);
    if (cards_id.contains(0)) {
        qDebug() << "Error!";
        return false;
    }
    std::vector<Card> cards;
    get_cards_query.prepare("SELECT * FROM card WHERE id = :id");
    foreach (const int& id, cards_id) {
        get_cards_query.bindValue(0, id);
        if (!get_cards_query.exec()) {
            qDebug() << "Query failed! Error: " << get_cards_query.lastError().text();
            return false;
        }
        cards.push_back(Card(get_cards_query.value("number").toString(),
                                                 client.getName(),
                                                 get_cards_query.value("is_gold").toBool(),
                                                 get_cards_query.value("valid").toString(),
                                                 get_cards_query.value("balance").toDouble()));
    }
    client.setCards(cards);
    return true;
}

bool Controller::registration(const QString& login, const QString& password, const QString& owner_name) {
    if (login == "" or password == "" or owner_name == "") {
        return false;
    }
    if (login.length() > 30 or password.length() > 16) {
        qDebug() << "Login or password is too long";
        return false;
    }
    QSqlQuery registration_query(database);
    registration_query.prepare(
            "INSERT INTO bank_login (login, password, owner_name) "
            "VALUES (:login, :password, :owner_name)");
    registration_query.bindValue(0, login);
    registration_query.bindValue(1, hashPassword(password));
    registration_query.bindValue(2, owner_name);
    if (!registration_query.exec()) {
        qDebug() << "Query failed! Error: " << registration_query.lastError().text();
        return false;
    }
    registration_query.prepare(
            "INSERT INTO card_owner (owner_name) "
            "VALUES (:owner_name)");
    registration_query.bindValue(0, owner_name);
    if (!registration_query.exec()) {
        qDebug() << "Query failed! Error: " << registration_query.lastError().text();
        return false;
    }
    qDebug() << "Success registration of user " + owner_name;
    return true;
}

void Controller::exchangeRates() {
    QNetworkAccessManager* manager = new QNetworkAccessManager;
    QNetworkRequest request;
    request.setUrl(
            QUrl("https://openexchangerates.org/api/latest.json?app_id=80d0efece45a4c67a23fafbdfe6047d6"));
    reply_exchange_rates = manager->get(request);
    connect(reply_exchange_rates, &QNetworkReply::finished, this, &Controller::getExchangeRates);
}

void Controller::getExchangeRates() {
    QByteArray result = reply_exchange_rates->readAll();
    QJsonDocument exchange_rates = QJsonDocument::fromJson(result);
    exchangeRatesToQML(exchange_rates);
}

QStringList Controller::exchangeRatesToQML(QJsonDocument exchange_rates) {
    QStringList rates_list;
    QJsonValue rates = exchange_rates.object().value("rates");
    rates_list.push_back(rates["RUS"].toString());
    //    rates_list.push
    return rates_list;
}
