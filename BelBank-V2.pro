QT += quick core sql widgets

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        card.cpp \
        controller.cpp \
        main.cpp \
        user.cpp

RESOURCES += qml.qrc

INCLUDEPATH += $$PWD/libs/soci/include \
        #$$PWD/libs/soci/build/include \
        $$PWD/../PostgreSQL/14/include \
	/usr/include/postgresql \
	/usr/local/include/soci/ \

#        $$PWD/libs/soci/build/lib/Debug/


LIBS += -L/usr/local/lib/

LIBS += /usr/local/lib/libsoci_postgresql.so \
        /usr/local/lib/libsoci_core.so \
#	/usr/local/lib/libsoci_postgresql.so.4.0 \
#        /usr/local/lib/libsoci_core.so.4.0





#LIBS += $$PWD/libs/soci/build/lib/libsoci_core.a \
#        $$PWD/libs/soci/build/lib/libsoci_postgresql.a
#-lsoci_postgresql_4_0
#        -L"$$PWD/libs/soci/build/lib/Debug/"



# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

#Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    card.h \
    controller.h \
    db_pool.hpp \
    user.h
