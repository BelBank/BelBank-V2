#ifndef USER_H
#define USER_H

#include <card.h>

#include <QObject>

class User : public QObject {
    Q_OBJECT
public:
    explicit User(QObject* parent = nullptr);

    const QString& getName() const;
    std::vector<Card> getCards() const;
    std::vector<QString> getFavPayments() const;

    void setName(const QString& name_to_set);
    void setCards(std::vector<Card> cards_to_set);
    void setFavPayments(std::vector<QString> payments);

    void printCardsData() const;

signals:

private:
    QString user_name;
    std::vector<Card> cards;
    std::vector<QString> favorite_payments;
    std::vector<int> recent_payments;
};

#endif	// USER_H
