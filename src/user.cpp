#include "user.h"

User::User(QObject* parent) : QObject{parent} {
}

std::vector<Card> User::getCards() const {
    return cards;
}

std::vector<QString> User::getFavPayments() const {
    return favorite_payments;
}

void User::setName(const QString& name) {
    this->user_name = name;
}

void User::setCards(std::vector<Card> cards_to_set) {
    cards.clear();
    foreach (Card new_card, cards_to_set) {
        this->cards.push_back(new_card);
    }
}

void User::setFavPayments(std::vector<QString> payments) {
    foreach (const QString& payment, payments) {
        this->favorite_payments.push_back(payment);
    }
}

const QString& User::getName() const {
    return user_name;
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
