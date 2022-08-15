#ifndef CARD_H
#define CARD_H

#include <QObject>
#include <QDate>
#include <string>

class Card
{

public:
    explicit Card();


private:
    QString card_number;
    QString card_holder;
    QDate valid_thru;
};

#endif // CARD_H
