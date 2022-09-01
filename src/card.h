#ifndef CARD_H
#define CARD_H

#include <QDate>
#include <QObject>
#include <QRandomGenerator>
#include <string>

class Card {
public:
	explicit Card();
	explicit Card(const QString& card_number,
								const QString& owner_name,
								bool is_gold,
								const QString& valid_thru);
	explicit Card(const QString& card_number,
								const QString& owner_name,
								bool is_gold,
								const QString& valid_thru,
								double balance);

	QString getNumber() const;
	QString getHolderName() const;
	bool getType() const;
	QString getValid() const;
	double getBalance() const;

private:
    QString card_number;	// [payment_system]143 [1 - gold, 2 - silver]*** **** ****
	QString card_holder;
	bool is_gold;
    short payment_system;	 // 4 - VISA, 5 - MASTERCARD ( я считаю, что нужно еще)
	QDate valid_thru;
	double balance;
};

#endif	// CARD_H
