#include "controller.h"

Controller::Controller(QObject *parent) : QObject{parent} {
    database = QSqlDatabase::addDatabase("QPSQL");
    database.setHostName("localhost");
    database.setDatabaseName("postgres");
    database.setUserName("root");
    database.setPassword("root");
    if (database.open()) {
        QMessageBox::information(nullptr, "Info", "Database connected!");
    } else {
        QMessageBox::warning(nullptr, "Error", "Error with database");
    }
    //    database.connect("postgresql://host='localhost' port='5432' dbname='test' user='postgres'
    //    password='drakonkapusta'"); soci::session sql(*database.get_pool());
}
