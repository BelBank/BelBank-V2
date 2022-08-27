#ifndef USER_H
#define USER_H

#include <card.h>

#include <QObject>

class User : public QObject {
    Q_OBJECT
    public:
    explicit User(QObject* parent = nullptr);

    std::vector<Card> getCards();

    void setName(const QString& name_to_set);
    void setCards(std::vector<Card> cards_to_set);
    const QString& getName() const;

    void printCardsData() const;

    signals:

    private:
    QString user_name;
    std::vector<Card> cards;
};

#endif	// USER_H
