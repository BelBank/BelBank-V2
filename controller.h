#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include "user.h"
#include "db_pool.hpp"

class Controller : public QObject
{
    Q_OBJECT
public:
    explicit Controller(QObject *parent = nullptr);

signals:

private:
    User client;
    db_pool database;

};

#endif // CONTROLLER_H
