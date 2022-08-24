#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>

//#include "db_pool.hpp"

#include <QMessageBox>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>

#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

#include "user.h"

class Controller : public QObject {
    Q_OBJECT
public:
    explicit Controller(QObject *parent = nullptr);

public Q_SLOTS:

    // Вспомогательный метод для получение имени авторизированного пользователя
    // В основном нужен для получения имени пользователя в QML интерфейсе
    QString getUserName() const;
    // В метод передается логин и пароль, метод делает выборку из БД
    // Возвращает true, если профиль был найден
    // Возвращает false, если ошибка при выборке, данные были пустыми либо профиль не найден
    bool enterToBank(const QString& login, const QString& password);


    // Метод для создания новой карты и добавления ее в БД
    // Возвращает false, если addNewCard вернул false либо срок действия карты истёк
    bool makeNewCard(const QString& card_number, const QString& valid);

    // Вызывается автоматически из makeNewCard
    // Возвращает false, если ошибка при добавлении карты в БД
    bool addNewCard(Card new_card);

    // В метод передается только имя владельца карты
    // Метод выбирает из БД данные по картам пользователя в формате JSON
    // Обрабатывает их и, соответсвенно, заполняет массив карт для переменной client
    // Возвращает json данных карты (может быть пустой, в случае ошибки выборки либо отсутствия карт)
    QJsonDocument getCardsFromDB(const QString& owner_name);

    // В метод передается логин, пароль и имя пользователя
    // Метод добавляет данные пользователя в БД, соответсвенно, регистрируя его
    // Возвращает true, в случае успеха
    // Возвращает false, если ошибка при добавлении данных либо данные были пустыми
    bool registration(const QString& login, const QString& password, const QString& owner_name);

signals:

private:
    User client;
    QSqlDatabase database;
};

#endif  // CONTROLLER_H
