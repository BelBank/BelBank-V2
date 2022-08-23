#ifndef CARD_H
#define CARD_H

#include <QObject>
#include <QDate>
#include <string>

class Card
{

public:
    explicit Card();
    explicit Card(const QString& card_number, const QString& owner_name, const QString& valid_thru);
    explicit Card(const QString& card_number, const QString& owner_name, const QString& valid_thru, double balance);

    QString getNumber() const;
    QString getValid() const;
    double getBalance() const;




private:
    QString card_number;
    QString card_holder;
    QDate valid_thru;
    double balance;
};

#endif // CARD_H
