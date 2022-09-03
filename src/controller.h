#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>

//#include "db_pool.hpp"

#include <QCryptographicHash>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMessageBox>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QRandomGenerator>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QThread>

#include "user.h"

class Controller : public QObject {
	Q_OBJECT
public:
	explicit Controller(QObject* parent = nullptr);

	/**
	 * # Функция дважды хеширует пароли, по алгоритму Sha3_256 и Sha3_512
	 * # Возвращает захешированный пароль в виде QByteArray-
	 */
	QByteArray hashPassword(const QString& password);

public Q_SLOTS:

	/**
	 *  # Вспомогательный метод для получение имени авторизированного пользователя
	 *  # В основном нужен для получения имени пользователя в QML интерфейсе
	 */
	QString getUserName() const;

    int getCardsCount() const;

    QStringList test();

    bool testConnection();
	/**
	 *  # В метод передается логин и пароль, метод делает выборку из БД
	 *  # Возвращает true, если профиль был найден
	 *  # Возвращает false, если ошибка при выборке, данные были пустыми либо профиль не найден
	 */
	bool enterToBank(const QString& login, const QString& password);

    /**
     * # Метод считывает данные карт пользователя и возвращает их как QVariantList в QVariantList
     * # А первый элемент возвращаемого листа - количество карт
     *
     * # Example
     *
     *  QVaritantList list_cards = cardsToQML();
     *
     *  list_cards[0] - количество карт в листе
     *
     *  QString card_number = list_cards[1][0];
     *  QString holder_name = list_cards[1][1];
     *  int payment_system = list_cards[1][2]; // 2 - MIR, 4 - VISA, 5 - MASTERCARD
     *  bool card_type = list_cards[1][3]; // true - gold, false - silver
     *  QString valid_thru = list_cards[1][4]; // format: MM/yy
     *  double card_balance = list_cards[1][5];
     */
    Q_INVOKABLE QVariantList cardsToQML();

    Q_INVOKABLE bool prepareQML(QVariant source);
	/**
	 *  # Метод для создания новой карты и добавления ее в БД
	 *  # Возвращает false, если addNewCard вернул false либо срок действия карты истёк
	 */
    bool makeCard(const QString& card_number, const QString& valid);

    bool makeNewCard(bool is_gold, short payment_system);

	/**
	 *  # Вызывается автоматически из makeNewCard
	 *  # Возвращает false, если ошибка при добавлении карты в БД
	 */
	bool addNewCard(Card new_card);

    bool addNewFavPayment(const QString& payment);
	/**
	 * # В метод передается только имя владельца карты
	 * # Метод делает выборку из таблицы card_owner
	 * # Возвращает массив интов - айдишники карт, которыми владеет данный пользователь
	 * # Если метод вернул массив, где единственный элемент равен -1, то произошла ошибка при выборке
	 */

	QVector<int> getCardsId(const QString& owner_name);

    QVector<int> getFavPaymentsId(const QString& owner_name);

	/**
	 *  # В метод передается только имя владельца карты
	 *  # Метод выбирает из БД данные по картам пользователя
	 *  # Обрабатывает их и, соответсвенно, заполняет массив карт для переменной client
	 *  # Возвращает true в случае успеха, false в случае ошибки выборки из card или card_owner
	 */

	bool getCardsFromDB(const QString& owner_name);

    bool getFavPaymentsFromDB(const QString& owner_name);

    Q_INVOKABLE QStringList favoritePaymentsToQML();

    /**
	 *  # В метод передается логин, пароль и имя пользователя
	 *  # Метод добавляет данные пользователя в БД, соответсвенно, регистрируя его
	 *  # Возвращает true, в случае успеха
	 *  # Возвращает false, если ошибка при добавлении данных либо данные были пустыми
	 */
	bool registration(const QString& login, const QString& password, const QString& owner_name);

    bool makePayment(const QString& card_nummber, const QString& payment_cost);
	/**
	 * # Experimental
	 */
    void exchangeRatesRequest();

	void getExchangeRates();

    void exchangeRates(QJsonDocument rates_doc);

    QStringList exchangeRatesForBank();

signals:

	/**
	 * # Сигнал, который вызывает при необходимости добавить карту в интерфейс
	 * # Передает в QML все данные по карте, чтобы отобразить их
	 */
    void cardToQML(const QString& number,
                                 const QString& owner_name,
                                 const QString& type,
                                 const QString& valid,
                                 const QString& system,
                                 const QString& balance);

    void setError(const QString& error);

private:
    User client;
	QSqlDatabase database;
	QNetworkReply* reply_exchange_rates;
    QStringList exchange_rates;
};

#endif	// CONTROLLER_H
