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
     *  # Вспомогательный метод для получения имени авторизированного пользователя
	 *  # В основном нужен для получения имени пользователя в QML интерфейсе
	 */
	QString getUserName() const;

    /**
     *  # Вспомогательный метод для получения количества карт пользователя
     *  # В основном нужен для получения количества карт пользователя в QML интерфейсе
     */
    QVariant getCardsCount() const;

    QVariant getFavPaymentsCount() const;

    /**
     * Метод для проверки подключения к интернету
     */
    bool testConnection();

    bool testDBConnection();
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

    /**
     * Метод для пересылки информации по картам из с++ в QML
     * Вызывается непосредственно в QML
     */
    Q_INVOKABLE bool prepareQML(QVariant source);

    /**
     *  # Метод для создания карты и добавления ее в БД
     *  # Возвращает false, если addNewCard вернул false либо срок действия карты истёк
     */
    bool makeCard(const QString& card_number, const QString& valid);

    /**
     * # Метод для генерирования новой *виртуальной* карты
     * # Номер генерируется по схеме [2 - MIR, 4 - VISA, 5 - MasterCard]143 [1 - gold, 2 - silver]*** **** ****
     * # Валидность карты = текущая дата (MM/yy) + количество лет, в зависимости от тарифа
     * # В метод передаются только тариф и платежная система
     * # Метод выбирает из БД карту с таким же номером, как сгенерированный, если таковой имеется
     * # То метод рекурсивно вызывает сам себя
     */
    bool makeNewCard(bool is_gold, short payment_system);

	/**
	 *  # Вызывается автоматически из makeNewCard
	 *  # Возвращает false, если ошибка при добавлении карты в БД
	 */
	bool addNewCard(Card new_card);

    /**
     *
     */
    bool addNewFavPayment(const QString& payment);

    bool addRecentPayment(const QString& payment, const QString& payment_cost);

    /**
	 * # В метод передается только имя владельца карты
     * # Метод делает выборку из таблицы user_info
	 * # Возвращает массив интов - айдишники карт, которыми владеет данный пользователь
	 * # Если метод вернул массив, где единственный элемент равен -1, то произошла ошибка при выборке
	 */
    QVector<int> getCardsId(const QString& owner_name);

    /**
     * # В метод передается только имя пользователя
     * # Метод делает выборку из таблицы user_info
     * # Возвращает массив интов - айдишники платежей, которыми владеет данный пользователь
     * # Если метод вернул массив, где единственный элемент равен -1, то произошла ошибка при выборке
     */
    QVector<int> getFavPaymentsId(const QString& owner_name);

    QVector<int> getRecentPaymentsId(const QString& owner_name);

	/**
	 *  # В метод передается только имя владельца карты
	 *  # Метод выбирает из БД данные по картам пользователя
	 *  # Обрабатывает их и, соответсвенно, заполняет массив карт для переменной client
     *  # Возвращает true в случае успеха, false в случае ошибки выборки из card или user_info
	 */
    bool getCardsFromDB(const QString& owner_name);

    /**
     *  # В метод передается только имя владельца карты
     *  # Метод выбирает из БД названия избранных платежей
     *  # Обрабатывает их и, соответсвенно, заполняет массив favorite_payments для переменной client
     *  # Возвращает true в случае успеха, false в случае ошибки выборки из payment или user_info
     */
    bool getFavPaymentsFromDB(const QString& owner_name);

    /**
     * # Метод, отсылающий избранные платежи в QML
     */
    Q_INVOKABLE QStringList favoritePaymentsToQML();

    QList<QStringList> recentPaymentsToQML();

    /**
	 *  # В метод передается логин, пароль и имя пользователя
	 *  # Метод добавляет данные пользователя в БД, соответсвенно, регистрируя его
	 *  # Возвращает true, в случае успеха
	 *  # Возвращает false, если ошибка при добавлении данных либо данные были пустыми
	 */
	bool registration(const QString& login, const QString& password, const QString& owner_name);

    /**
     * @brief makePayment
     * @param card_nummber
     * @param payment_cost
     * @return
     */
    bool makePayment(const QString& card_nummber, const QString& payment_cost);

    bool makeRemittance(const QString& card_number, const QString& target_card_number, const QString& cost);

    /**
     * Метод, посылающий HTTP GET-запрос открытому API курсов валют
     */
    void exchangeRatesRequest();

    /**
     * Метод, вызывающийся, когда ответ от API полностью пришел и его можно считать
     * Вызывает метод exchangeRates(), куда посылает курсы валют в формате JSON
     */
    void getExchangeRates();

    /**
     * Метод, который заполняет поле exchange_rates, т.е. подготавливает курсы по НацБанку
     */
    void exchangeRates(QJsonDocument rates_doc);

    /**
     * Метод, использующийся для передачи курсов валют С КОМИССИЕЙ в QML
     */
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

    void paymentToQML(const QString& payment);

    void recPaymentsToQML(const QString& name, const QString& date, const QString& time, const QString& cost);

    void setError(const QString& error);

private:
    User client;
	QSqlDatabase database;
    bool is_db_connected = false;
	QNetworkReply* reply_exchange_rates;
    QStringList exchange_rates;
};

#endif	// CONTROLLER_H
