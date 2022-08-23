#include "card.h"

Card::Card()

{

}


Card::Card(const QString& card_number, const QString& owner_name, const QString& valid_thru) {
    this->card_number = card_number;
    this->card_holder = owner_name;
    this->valid_thru = QDate(QDate::fromString(valid_thru, "MM/yy"));
    this->balance = 1234.0; // maybe random?
}

Card::Card(const QString& card_number, const QString& owner_name, const QString& valid_thru, double balance) {
    this->card_number = card_number;
    this->card_holder = owner_name;
    this->valid_thru = QDate(QDate::fromString(valid_thru, "MM/yy"));
    this->balance = balance;
}


QString Card::getNumber() const {
    return this->card_number;
}


QString Card::getValid() const {
    return this->valid_thru.toString("MM/yy");
}


double Card::getBalance() const {
    return balance;
}
