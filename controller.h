#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>

//#include "db_pool.hpp"

#include <QMessageBox>
#include <QSqlDatabase>

#include "user.h"

class Controller : public QObject {
    Q_OBJECT
public:
    explicit Controller(QObject *parent = nullptr);

signals:

private:
    User client;
    QSqlDatabase database;
    //    db_pool database;
};

#endif  // CONTROLLER_H
