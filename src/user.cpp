#include "user.h"

User::User(QObject* parent) : QObject{parent} {
}

const QString& User::getName() const {
    return user_name;
}

QVector<Card> User::getCards() const {
    return cards;
}

QVector<QString> User::getFavPayments() const {
    return favorite_payments;
}

QVector<int> User::getRecentPayments() const {
    return recent_payments;
}

void User::setName(const QString& name) {
    this->user_name = name;
}

void User::setCards(QVector<Card> cards_to_set) {
    cards.clear();
    foreach (Card new_card, cards_to_set) {
        this->cards.push_back(new_card);
    }
}

void User::setFavPayments(QVector<QString> payments) {
    favorite_payments.clear();
    foreach (const QString& payment, payments) {
        this->favorite_payments.push_back(payment);
    }
}

void User::setRecentPayments(QVector<int> payments) {
    recent_payments.clear();
    foreach (int payment, payments) {
        this->recent_payments.push_back(payment);
    }
}

void User::printCardsData() const {
    foreach (const Card& card, cards) {
        qDebug() << "=============================";
        qDebug() << "Card number: " << card.getNumber();
        qDebug() << "Valid thru: " << card.getValid();
        qDebug() << "Balance: " << card.getBalance();
        qDebug() << "=============================";
    }
}
