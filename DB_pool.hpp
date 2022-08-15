#ifndef DB_POOL_HPP
#define DB_POOL_HPP

#include <soci/soci.h>
#include "soci/postgresql/soci-postgresql.h"

#include <iostream>
#include <string>

class db_pool {
    soci::connection_pool* pool_;
    std::size_t pool_size_;
public:
    db_pool() :pool_(nullptr), pool_size_(0) {}
    ~db_pool() { close(); }

    soci::connection_pool* get_pool() { return pool_; }

    bool connect(const std::string& conn_str, std::size_t n = 5) {
        if (pool_ != nullptr) { close(); }
        int is_connected = 0;

        if (!(pool_ = new soci::connection_pool((pool_size_ = n)))) return false;

        try {
            soci::indicator ind;
            for (std::size_t _i = 0; _i < pool_size_; _i++) {
                soci::session& sql = pool_->at(_i);
                sql.open(conn_str);
                sql << "SELECT 1;", soci::into(is_connected, ind);
                if (!is_connected) break;
                else if (_i + 1 < pool_size_) is_connected = 0;
            }
        }
        catch (std::exception const& e) { std::cerr << e.what() << std::endl; }

        if (!is_connected) close();

        return (pool_ != nullptr);
    }

    void close() {
        if (pool_ != nullptr) {
            try {
                for (std::size_t _i = 0; _i < pool_size_; _i++) {
                    soci::session& sql = pool_->at(_i);
                    sql.close();
                }
                delete pool_; pool_ = nullptr;
            }
            catch (std::exception const& e) { std::cerr << e.what() << std::endl; }
            pool_size_ = 0;
        }
    }
};

//namespace soci {

//template<> struct type_conversion<Client> {
//    typedef values base_type;

//    static void from_base(values const& v, indicator ind, Client& p) {
//        if (ind == i_null) return;
//        try {
//            p.id = v.get<int>("id", 0);
//            p.login = v.get<std::string>("login", {});
//            p.password = v.get<std::string>("password", {});
//        }
//        catch (std::exception const& e) { std::cerr << e.what() << std::endl; }
//    }

//    static void to_base(const Client& p, values& v, indicator& ind) {
//        try {
//            v.set("id", p.id);

//            v.set("login", p.login);
//            v.set("password", p.password);

//            ind = i_ok;
//            return;
//        }
//        catch (std::exception const& e) { std::cerr << e.what() << std::endl; }
//        ind = i_null;
//    }

//};
//}



#endif // DB_POOL_HPP
