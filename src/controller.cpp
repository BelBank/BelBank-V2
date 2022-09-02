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

	this->exchangeRatesRequest();
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

bool Controller::testConnection() {
	QTcpSocket* test_connection = new QTcpSocket();
	test_connection->connectToHost("www.google.com", 80);
	bool is_connected = test_connection->waitForConnected();
	if (!is_connected) {
		qDebug() << "No network connection";
		emit Controller::setError("Ошибка подключения к Интернету!");
		return false;
	} else {
		qDebug() << "Computer is connected to Internet";
		return true;
	}
}

bool Controller::enterToBank(const QString& login, const QString& password) {
	qDebug() << "Entering...";
	if (!this->testConnection()) {
		return false;
	}
	if (login == "" or password == "") {
		qDebug() << "No data in field";
		return false;
	}
	QSqlQuery login_query(database);
	login_query.prepare("SELECT * FROM bank_login WHERE login = :login AND password = :password");
	login_query.bindValue(0, login);
	login_query.bindValue(1, hashPassword(password));
	if (!login_query.exec()) {
		qDebug() << "Query for login failed! Error: " << login_query.lastError().text();
		return false;
	}
	if (!login_query.next()) {
		qDebug() << "No such user";
		return false;
	}
	qDebug() << "Success login";
	this->client.setName(login_query.value(3).toString());
	this->getCardsFromDB(login_query.value(1).toString());
	if (!prepareQML()) {
		qDebug() << "Preparing QML failed";
		return false;
	}
	return true;
}

QVariantList Controller::cardsToQML() {
	std::vector<Card> cards = client.getCards();
	emit Controller::test();
	QVariantList cards_to_qml;
	int number_of_cards = 0;
	foreach (Card card, cards) {
		//        emit Controller::cardToQML(
		//            card.getNumber(), card.getHolderName(), card.getType(), card.getValid(), card.getBalance());
		QVariantList card_variant;
		card_variant.push_back(card.getNumber());
		card_variant.push_back(card.getHolderName());
		card_variant.push_back(card.getType());
		card_variant.push_back(card.getValid());
		card_variant.push_back(card.getBalance());
		cards_to_qml.push_back(card_variant);
		number_of_cards++;
	}
	cards_to_qml.insert(0, number_of_cards);
	return cards_to_qml;
}

bool Controller::prepareQML() {
	qDebug() << "QML preparing...";

	return true;
}

bool Controller::makeCard(const QString& card_number, const QString& valid) {
	QString valid_copy = valid;
	valid_copy = "01/" + valid_copy.insert(3, "20");
	qDebug() << "Valid thru " << valid_copy;
	if (QDate(QDate::fromString(valid_copy, "dd/MM/yyyy")) < QDate::currentDate()) {
		qDebug() << "Card is not valid";
		return false;
	}
	bool is_gold;
	if (card_number[5] == '1') {
		is_gold = true;
	} else {
		is_gold = false;
	}
	Card new_card(card_number, client.getName(), is_gold, valid);
	if (!addNewCard(new_card)) {
		return false;
	}
	return true;
}

bool Controller::makeNewCard(bool is_gold, short payment_system) {
	QString card_number;
	card_number.push_back(QString::number(payment_system));
	card_number += "143 ";
	card_number += is_gold ? '1' : '2';
	QRandomGenerator generator;
	card_number += QString::number(QRandomGenerator::global()->bounded(100, 999)) + ' ' +
									QString::number(QRandomGenerator::global()->bounded(1000, 9999)) + ' ' +
									QString::number(QRandomGenerator::global()->bounded(1000, 9999));
	qDebug() << "Number of new card: " << card_number;
	QDate valid = QDate::currentDate().addYears(5);
	QString valid_str = valid.toString("MM/yy");
	qDebug() << "Valid of new card: " << valid_str;
	QSqlQuery find_duplicates_query(database);
	find_duplicates_query.prepare("SELECT number FROM card WHERE number = :number");
	find_duplicates_query.bindValue(0, card_number);
	if (!find_duplicates_query.exec()) {
		qDebug() << "Query for adding new card failed! Error: " << find_duplicates_query.lastError().text();
		return false;
	}
	if (find_duplicates_query.next()) {
		return makeNewCard(is_gold, payment_system);
	}
	if (!addNewCard(Card(card_number, client.getName(), is_gold, valid_str))) {
		qDebug() << "Failed adding";
		return false;
	}
	return true;
}

bool Controller::addNewCard(Card new_card) {
	QSqlQuery add_card_query(database);
	QSqlQuery find_duplicates_query(database);
	find_duplicates_query.prepare("SELECT number FROM card WHERE number = :number");
	find_duplicates_query.bindValue(0, new_card.getNumber());
	if (!find_duplicates_query.exec()) {
		qDebug() << "Query for adding new card failed! Error: " << find_duplicates_query.lastError().text();
		return false;
	}
	if (find_duplicates_query.next()) {
		qDebug() << "This card is already exist for other user";
		return false;
	}

	add_card_query.prepare(
			"INSERT INTO card (number, is_gold, valid, balance) "
			"VALUES (:number, :is_gold, :valid, :balance)");
	add_card_query.bindValue(0, new_card.getNumber());
	add_card_query.bindValue(1, new_card.getType());
	add_card_query.bindValue(2, new_card.getValid());
	add_card_query.bindValue(3, new_card.getBalance());
	if (!add_card_query.exec()) {
		qDebug() << "Query for adding new card failed! Error: " << add_card_query.lastError().text();
		return false;
	}
	QVector<int> cards_id = getCardsId(client.getName());
	if (!add_card_query.exec("SELECT MAX(id) FROM card")) {
		qDebug() << "Query for max id failed! Error: " << add_card_query.lastError().text();
		return false;
	}
	if (!add_card_query.next()) {
		qDebug() << "Max id failed";
		return false;
	}
	qDebug() << "Max id is " << add_card_query.value("max").toString();
	cards_id.push_back(add_card_query.value("max").toInt());
	add_card_query.prepare(
			"UPDATE user_info "
			"SET cards = :cards "
			"WHERE owner_name = :owner_name");
	QStringList cards_array;
	foreach (const int& value, cards_id) {
		if (value == 0) {
			continue;
		}
		cards_array << QString::number(value);
	}
	add_card_query.bindValue(0, "{ " + cards_array.join(",") + " }");
	add_card_query.bindValue(1, client.getName());

	if (!add_card_query.exec()) {
		qDebug() << "Query for updating cards array failed! Error: " << add_card_query.lastError().text();
		return false;
	}
	return true;
}

QVector<int> Controller::getCardsId(const QString& owner_name) {
	QSqlQuery get_cards_id_query(database);
	QVector<int> cards_id;
	get_cards_id_query.prepare("SELECT cards FROM user_info WHERE owner_name = :owner_name");
	get_cards_id_query.bindValue(0, owner_name);
	if (!get_cards_id_query.exec()) {
		qDebug() << "Query for getting cards array failed! Error: " << get_cards_id_query.lastError().text();
		cards_id.push_back(-1);
		return cards_id;
	}
	get_cards_id_query.next();
	QStringList cards_list = get_cards_id_query.value("cards").toString().split(",");
	foreach (QString val, cards_list) {
		if (val.contains('{')) {
			val.remove('{');
		}
		if (val.contains('}')) {
			val.remove('}');
		}
		if (val == "0") {
			continue;
		}
		cards_id.push_back(val.toInt());
	}
	qDebug() << "Cards id's " << cards_id;
	return cards_id;
}

QVector<int> Controller::getFavPaymentsId(const QString& owner_name) {
	QSqlQuery get_payments_id_query(database);
	QVector<int> payments_id;
	get_payments_id_query.prepare("SELECT favorite_payments FROM user_info WHERE owner_name = :owner_name");
	get_payments_id_query.bindValue(0, owner_name);
	if (!get_payments_id_query.exec()) {
		qDebug() << "Query for getting cards array failed! Error: " << get_payments_id_query.lastError().text();
		payments_id.push_back(-1);
		return payments_id;
	}
	get_payments_id_query.next();
	QStringList cards_list = get_payments_id_query.value("favorite_payments").toString().split(",");
	foreach (QString val, cards_list) {
		if (val.contains('{')) {
			val.remove('{');
		}
		if (val.contains('}')) {
			val.remove('}');
		}
		if (val == "0") {
			continue;
		}
		payments_id.push_back(val.toInt());
	}
	qDebug() << "Favorite payments id's " << payments_id;
	return payments_id;
}

bool Controller::getCardsFromDB(const QString& owner_name) {
	QSqlQuery get_cards_query(database);
	QVector<int> cards_id = getCardsId(owner_name);
	if (cards_id.contains(-1)) {
		qDebug() << "Error!";
		return false;
	}
	std::vector<Card> cards;
	get_cards_query.prepare("SELECT * FROM card WHERE id = :id");
	foreach (const int& id, cards_id) {
		get_cards_query.bindValue(0, id);
		if (!get_cards_query.exec()) {
			qDebug() << "Query for getting cards array failed! Error: " << get_cards_query.lastError().text();
			return false;
		}
		if (!get_cards_query.next()) {
			qDebug() << "No reply from cards";
			return false;
		}
		qDebug() << "Number of card: " << get_cards_query.value("number").toString()
						 << "Owner_name: " << client.getName();
		cards.push_back(Card(get_cards_query.value("number").toString(),
												 client.getName(),
												 get_cards_query.value("is_gold").toBool(),
												 get_cards_query.value("valid").toString(),
												 get_cards_query.value("balance").toDouble()));
	}
	client.setCards(cards);
	return true;
}

bool Controller::getFavPaymentsFromDB(const QString& owner_name) {
	QSqlQuery get_payments_query(database);
	QVector<int> payments_id = getFavPaymentsId(owner_name);
	if (payments_id.contains(-1)) {
		qDebug() << "Error!";
		return false;
	}
	std::vector<QString> payments;
	get_payments_query.prepare("SELECT * FROM payment WHERE id = :id");
	foreach (const int& id, payments_id) {
		get_payments_query.bindValue(0, id);
		if (!get_payments_query.exec()) {
			qDebug() << "Query for getting cards array failed! Error: " << get_payments_query.lastError().text();
			return false;
		}
		if (!get_payments_query.next()) {
			qDebug() << "No reply from cards";
			return false;
		}
		payments.push_back(get_payments_query.value("name").toString());
	}
	client.setFavPayments(payments);
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
		qDebug() << "Query for registration failed! Error: " << registration_query.lastError().text();
		return false;
	}
	registration_query.prepare(
			"INSERT INTO user_info (owner_name) "
			"VALUES (:owner_name)");
	registration_query.bindValue(0, owner_name);
	if (!registration_query.exec()) {
		qDebug() << "Query for regustration in user_info failed! Error: "
						 << registration_query.lastError().text();
		return false;
	}
	qDebug() << "Success registration of user " + owner_name;
	return true;
}

bool Controller::makePayment(const QString& card_number, const QString& payment_cost) {
	if (card_number == "" or card_number.length() < 16 or card_number.length() > 19 or payment_cost == "") {
		qDebug() << "Data is uncorrect";
		// emit dataError();
		return false;
	}
	QSqlQuery balance_query(database);
	balance_query.prepare("SELECT balance FROM card WHERE number = :number");
	balance_query.bindValue(0, card_number);
	if (!balance_query.exec()) {
		qDebug() << "Query for regustration in user_info failed! Error: " << balance_query.lastError().text();
		// emit somethingWrong()
		return false;
	}
	if (!balance_query.next()) {
		qDebug() << "Data is empty";
		// emit somethingWrong()
		return false;
	}
	double balance = balance_query.value("balance").toDouble();
	if (balance < payment_cost.toDouble()) {
		qDebug() << "Not much money to make payment";
		// emit balanceFault()
		return false;
	}
	balance -= payment_cost.toDouble();
	balance_query.prepare(
			"UPDATE card "
			"SET balance = :balance "
			"WHERE number = :number");
	balance_query.bindValue(0, balance);
	balance_query.bindValue(1, card_number);
	if (!balance_query.exec()) {
		qDebug() << "Query for regustration in user_info failed! Error: " << balance_query.lastError().text();
		// emit somethingWrong()
		return false;
	}
	qDebug() << "Success payment";
	// emit prepareCheck() ???
	// emit success()
	return true;
}

void Controller::exchangeRatesRequest() {
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
	exchangeRates(exchange_rates);
}

void Controller::exchangeRates(QJsonDocument rates_doc) {
	QJsonObject rates = rates_doc["rates"].toObject();
	exchange_rates.push_back(QString::number(rates["BYN"].toDouble() / rates["RUB"].toDouble() * 100));
	exchange_rates.push_back(QString::number(rates["BYN"].toDouble()));
	exchange_rates.push_back(QString::number(rates["BYN"].toDouble() / rates["EUR"].toDouble()));
	exchange_rates.push_back(QString::number(rates["BYN"].toDouble() / rates["CNY"].toDouble() * 10));
	exchange_rates.push_back(QString::number(rates["BYN"].toDouble() / rates["PLN"].toDouble() * 10));
}

QStringList Controller::exchangeRatesForBank() {
	QStringList rates_to_qml;
	foreach (QString rate, exchange_rates) {
		qDebug() << "Rate " << rate;
		rates_to_qml.push_back(QString::number(round(rate.toDouble() * 1.02 * 100) / 100));
		rates_to_qml.push_back(QString::number(round(rate.toDouble() * 0.98 * 100) / 100));
	}
	return rates_to_qml;
}
