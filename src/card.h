#ifndef CARD_H
#define CARD_H

#include <QDate>
#include <QObject>
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
	QString card_number;
	QString card_holder;
	bool is_gold;
	QDate valid_thru;
	double balance;
};

#endif	// CARD_H
