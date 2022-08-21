#include "controller.h"

#include <QDebug>

Controller::Controller(QObject *parent) : QObject{parent} {
    database = QSqlDatabase::addDatabase("QPSQL");
    database.setHostName("localhost");
    database.setDatabaseName("postgres");
    database.setUserName("root");
    database.setPassword("root");
    if (database.open()) {
        qDebug() << "Database success connection!";
    } else {
        qDebug() << "Database connetion failed.";
    }

    QSqlQuery query(database);
    //    if (!query.exec("INSERT INTO test (id, \"user\") VALUES (2, 'admin')")) {
    //        qDebug() << "Query failed! Error: " << query.lastError().text();
    //    }
    if (!query.exec("SELECT user FROM test")) {
        qDebug() << "Query failed! Error: " << query.lastError().text();
    }
    while (query.next()) {
        qDebug() << "User is " << query.value(0).toString();
        qDebug() << "User is " << query.value(1).toString();
    }
}
