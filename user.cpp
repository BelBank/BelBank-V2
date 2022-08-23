#include "user.h"

User::User(QObject *parent)
    : QObject{parent} {

}

void User::setName(const QString& name) {
    this->user_name = name;
}

void User::setCards(std::vector<Card> cards_to_set) {
    foreach (Card new_card, cards_to_set) {
        this->cards.push_back(new_card);
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

