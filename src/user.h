#ifndef USER_H
#define USER_H

#include <card.h>

#include <QObject>

class User : public QObject {
    Q_OBJECT
public:
    explicit User(QObject* parent = nullptr);

    const QString& getName() const;
    QVector<Card> getCards() const;
    QVector<QString> getFavPayments() const;
    QVector<int> getRecentPayments() const;

    void setName(const QString& name_to_set);
    void setCards(QVector<Card> cards_to_set);
    void setFavPayments(QVector<QString> payments);
    void setRecentPayments(QVector<int> payments);
    void printCardsData() const;

signals:

private:
    QString user_name;
    QVector<Card> cards;
    QVector<QString> favorite_payments;
    QVector<int> recent_payments;
};

#endif	// USER_H
