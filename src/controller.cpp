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
	database.setPort(11933);
	database.setDatabaseName("bank_2_0");
	database.setUserName("root");
	database.setPassword("drakonkapusta");

	this->testDBConnection();
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

QVariant Controller::getCardsCount() const {
	//    return 1;
	return QVariant(client.getCards().size());
}

QVariant Controller::getFavPaymentsCount() const {
	return QVariant(client.getFavPayments().size());
}

bool Controller::testConnection() {
	QTcpSocket* test_connection = new QTcpSocket();
	test_connection->connectToHost("www.google.com", 80);
	bool is_connected = test_connection->waitForConnected();
	if (!is_connected) {
		qDebug() << "No network connection";
		//        emit Controller::setError("Ошибка подключения к Интернету!");
		return false;
	} else {
		qDebug() << "Computer is connected to Internet";
		return true;
	}
}

bool Controller::testDBConnection() {
	if (database.open()) {
		qDebug() << "Database success connection!";
		is_db_connected = true;
		return true;
	} else {
		qDebug() << "Database connetion failed.";
		is_db_connected = false;
		return false;
	}
}

bool Controller::enterToBank(const QString& login, const QString& password) {
	client.clearSession();
	qDebug() << "Entering...";
	//    emit Controller::setError("Hello World!");
	if (!this->testConnection()) {
		return false;
	}
	if (!is_db_connected and !testDBConnection()) {
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
	this->getCardsFromDB(client.getName());
	this->getFavPaymentsFromDB(client.getName());
	this->getRecentPaymentsId(client.getName());
	return true;
}

QVariantList Controller::cardsToQML() {
	QVector<Card> cards = client.getCards();
	QVariantList cards_to_qml;
	int number_of_cards = 0;
	foreach (Card card, cards) {
		QVariantList card_variant;
		card_variant.push_back(card.getNumber());
		card_variant.push_back(card.getHolderName());
		card_variant.push_back((int)(card.getNumber()[0].toLatin1() - '0'));
		card_variant.push_back(card.getType());
		card_variant.push_back(card.getValid());
		card_variant.push_back(card.getBalance());
		cards_to_qml.push_back(card_variant);
		number_of_cards++;
	}
	cards_to_qml.insert(0, number_of_cards);
	return cards_to_qml;
}

bool Controller::prepareQML(QVariant source) {
	if (source.toString() != "MainWindow.qml" and source.toString() != "PaymentWindow.qml") {
		return true;
	}

	qDebug() << "QML preparing in " << source.toString() << "...";
	QVector<Card> cards = client.getCards();
	foreach (Card card, cards) {
		QString type;
		QString payment_system;
		if (card.getType()) {
			type = "gold";
		} else {
			type = "silver";
		}
		if (card.getNumber()[0] == '2') {
			payment_system = "MIR";
		} else if (card.getNumber()[0] == '4') {
			payment_system = "visa";
		} else {
			payment_system = "mastercard";
		}
		emit Controller::cardToQML(card.getNumber(),
																card.getHolderName(),
																type,
																card.getValid(),
																payment_system,
																QString::number(card.getBalance()));
	}
	if (source.toString() == "PaymentWindow.qml") {
		return true;
	}
	QStringList payments = favoritePaymentsToQML();
	foreach (QString payment, payments) {
		emit Controller::paymentToQML(payment);
	}
	QList<QStringList> recent_payments = recentPaymentsToQML();
	qDebug() << "Recent payments " << recent_payments;
	foreach (QStringList info, recent_payments) {
		qDebug() << "!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" << info[0] << info[1] << info[2]
							<< info[3];
		emit Controller::recPaymentsToQML(info[0], info[1], info[2], info[3]);
	}
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
	this->getCardsFromDB(client.getName());
	return true;
}

bool Controller::makeNewCard(bool is_gold, short payment_system) {
	QString card_number;
	card_number.push_back(QString::number(payment_system));
	card_number += "143 ";
	card_number += is_gold ? '1' : '2';
	card_number += QString::number(QRandomGenerator::global()->bounded(100, 999)) + ' ' +
									QString::number(QRandomGenerator::global()->bounded(1000, 9999)) + ' ' +
									QString::number(QRandomGenerator::global()->bounded(1000, 9999));
	qDebug() << "Number of new card: " << card_number;
	QDate valid;
	if (is_gold) {
		valid = QDate::currentDate().addYears(5);
	} else {
		valid = QDate::currentDate().addYears(4);
	}
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
	this->getCardsFromDB(client.getName());
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
	this->getFavPaymentsFromDB(client.getName());
	return true;
}

bool Controller::addNewFavPayment(const QString& payment) {
	qDebug() << "Fav payment is " << payment;
	QSqlQuery add_payment(database);
	QVector<int> fav_payments = this->getFavPaymentsId(client.getName());
	if (fav_payments.length() == 10) {
		fav_payments.pop_back();
	}
	add_payment.prepare("SELECT id FROM payment WHERE name = :payment");
	add_payment.bindValue(0, payment);
	if (!add_payment.exec()) {
		qDebug() << "Query for getting cards array failed! Error: " << add_payment.lastError().text();
		return false;
	}
	if (!add_payment.next()) {
		qDebug() << "No reply from payment";
		return false;
	}
	if (fav_payments.contains(add_payment.value("id").toInt())) {
		return true;
	}
	fav_payments.push_front(add_payment.value("id").toInt());
	add_payment.prepare(
			"UPDATE user_info "
			"SET favorite_payments = :payments "
			"WHERE owner_name = :owner_name");
	QStringList payments_array;
	foreach (const int& value, fav_payments) {
		if (value == 0) {
			continue;
		}
		payments_array << QString::number(value);
	}
	add_payment.bindValue(0, "{ " + payments_array.join(",") + " }");
	add_payment.bindValue(1, client.getName());
	if (!add_payment.exec()) {
		qDebug() << "Query for updating cards array failed! Error: " << add_payment.lastError().text();
		return false;
	}
	this->getFavPaymentsFromDB(client.getName());
	return true;
}

bool Controller::addRecentPayment(const QString& payment, const QString& payment_cost) {
	QSqlQuery add_new_recent_payment(database);
	add_new_recent_payment.prepare(
			"INSERT INTO recent_payment (name, date, time, cost) "
			"VALUES (:name, :date, :time, :cost)");
	add_new_recent_payment.bindValue(0, payment);
	add_new_recent_payment.bindValue(1, QDate::currentDate());
	add_new_recent_payment.bindValue(2, QTime::currentTime());
	add_new_recent_payment.bindValue(3, payment_cost);
	if (!add_new_recent_payment.exec()) {
		qDebug() << "Query failed for adding new recent_payments array failed! Error: "
							<< add_new_recent_payment.lastError().text();
		return false;
	}

	QSqlQuery update_recent_payments(database);
	if (!update_recent_payments.exec("SELECT MAX(id) FROM recent_payment")) {
		qDebug() << "Query failed for getting payment id failed! Error: "
							<< update_recent_payments.lastError().text();
		return false;
	}
	if (!update_recent_payments.next()) {
		return false;
	}
	QVector<int> payments_id = this->getRecentPaymentsId(client.getName());
	payments_id.push_front(update_recent_payments.value("max").toInt());
	update_recent_payments.prepare(
			"UPDATE user_info "
			"SET recent_payments = :payments "
			"WHERE owner_name = :owner_name");
	QStringList payments_array;
	foreach (const int& value, payments_id) {
		if (value == 0) {
			continue;
		}
		payments_array << QString::number(value);
	}
	update_recent_payments.bindValue(0, "{ " + payments_array.join(",") + " }");
	update_recent_payments.bindValue(1, client.getName());
	if (!update_recent_payments.exec()) {
		qDebug() << "Query for updating recent_payments array failed! Error: "
							<< update_recent_payments.lastError().text();
		return false;
	}
	client.setRecentPayments(payments_id);
	qDebug() << "success adding recent payment";
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

QVector<int> Controller::getRecentPaymentsId(const QString& owner_name) {
	QSqlQuery get_recent_payments(database);
	QVector<int> payments_id;
	get_recent_payments.prepare("SELECT recent_payments FROM user_info WHERE owner_name = :name");
	get_recent_payments.bindValue(0, client.getName());
	if (!get_recent_payments.exec()) {
		qDebug() << "Query for getting recent payments array failed! Error: "
							<< get_recent_payments.lastError().text();
		payments_id.push_back(-1);
		return payments_id;
	}

	if (get_recent_payments.next()) {
		qDebug() << get_recent_payments.value("recent_payments").toString();
		QStringList payments_list = get_recent_payments.value("recent_payments").toString().split(",");
		qDebug() << "QStringList payments is " << payments_list;
		foreach (QString val, payments_list) {
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
	}
	qDebug() << "Payments id's " << payments_id;
	if (payments_id.size() == 10) {
		payments_id.pop_back();
	}
	client.setRecentPayments(payments_id);
	return payments_id;
}

bool Controller::getCardsFromDB(const QString& owner_name) {
	QSqlQuery get_cards_query(database);
	QVector<int> cards_id = getCardsId(owner_name);
	if (cards_id.contains(-1)) {
		qDebug() << "Error!";
		return false;
	}
	QVector<Card> cards;
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
	QVector<QString> payments;
	get_payments_query.prepare("SELECT * FROM payment WHERE id = :id");
	foreach (const int& id, payments_id) {
		get_payments_query.bindValue(0, id);
		if (!get_payments_query.exec()) {
			qDebug() << "Query for getting cards array failed! Error: " << get_payments_query.lastError().text();
			return false;
		}
		if (!get_payments_query.next()) {
			qDebug() << "No reply from favorite payment";
			return false;
		}
		payments.push_back(get_payments_query.value("name").toString());
	}
	client.setFavPayments(payments);
	return true;
}

QStringList Controller::favoritePaymentsToQML() {
	QVector<QString> payments = client.getFavPayments();
	QStringList payments_list;
	foreach (QString payment, payments) {
		payments_list.push_back(payment);
	}
	return payments_list;
}

QList<QStringList> Controller::recentPaymentsToQML() {
	QList<QStringList> payments;
	QVector<int> payments_id = client.getRecentPayments();

	foreach (int id, payments_id) {
		QSqlQuery get_payment_info(database);
		get_payment_info.prepare("SELECT * FROM recent_payment WHERE id = :id");
		get_payment_info.bindValue(0, id);
		if (!get_payment_info.exec()) {
			qDebug() << "Query for getting recent payments info failed! Error: "
								<< get_payment_info.lastError().text();
			continue;
		}
		if (!get_payment_info.next()) {
			continue;
		} else {
			QStringList info;
			info << get_payment_info.value("name").toString()
						<< get_payment_info.value("date").toDate().toString("dd/MM/yyyy")
						<< get_payment_info.value("time").toTime().toString("HH:mm:ss")
						<< QString::number(get_payment_info.value("cost").toDouble());

			payments.push_back(info);
		}
	}
	return payments;
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
	this->getCardsFromDB(client.getName());
	// emit prepareCheck() ???
	// emit success()
	return true;
}

bool Controller::makeRemittance(const QString& card_number,
																const QString& target_card_number,
																const QString& cost) {
	if (card_number == target_card_number) {
		qDebug() << "Can't transit money with 2 equal cards";
		return false;
	}
	QSqlQuery check_card_in_bank(database);
	check_card_in_bank.prepare("SELECT balance FROM card WHERE number = :number");
	check_card_in_bank.bindValue(0, target_card_number);
	if (!check_card_in_bank.exec()) {
		qDebug() << "Query for checking card failed! Error: " << check_card_in_bank.lastError().text();
		return false;
	}

	QSqlQuery get_balance(database);
	get_balance.prepare("SELECT balance FROM card WHERE number = :number");
	get_balance.bindValue(0, card_number);
	if (!get_balance.exec()) {
		qDebug() << "Query for getting balance failed! Error: " << get_balance.lastError().text();
		return false;
	}
	get_balance.next();
	double balance = get_balance.value("balance").toDouble();

	if (balance < cost.toDouble()) {
		qDebug() << "Not enough money";
		return false;
	}
	balance -= cost.toDouble();

	if (check_card_in_bank.next()) {
		double balance_of_target = check_card_in_bank.value("balance").toDouble();
		balance_of_target += cost.toDouble();

		QSqlQuery balance_query(database);
		balance_query.prepare(
				"UPDATE card "
				"SET balance = :balance "
				"WHERE number = :number");
		balance_query.bindValue(0, QString::number(balance_of_target));
		balance_query.bindValue(1, target_card_number);
		if (!balance_query.exec()) {
			qDebug() << "Query for updating balance failed! Error: " << balance_query.lastError().text();
			return false;
		}
	}
	QSqlQuery balance_query(database);
	balance_query.prepare(
			"UPDATE card "
			"SET balance = :balance "
			"WHERE number = :number");
	balance_query.bindValue(0, QString::number(balance));
	balance_query.bindValue(1, card_number);
	if (!balance_query.exec()) {
		qDebug() << "Query for updating balance failed! Error: " << balance_query.lastError().text();
		return false;
	}
	qDebug() << "Success transaction!";
	this->getCardsFromDB(client.getName());
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
		rates_to_qml.push_back(QString::number(round(rate.toDouble() * 1.02 * 100) / 100));
		rates_to_qml.push_back(QString::number(round(rate.toDouble() * 0.98 * 100) / 100));
	}
	return rates_to_qml;
}
