QT += quick core

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
        $$PWD/libs/soci/build/include \
        $$PWD/../PostgreSQL/14/include \
#        $$PWD/libs/soci/build/lib/Debug/



#LIBS += -L"$$PWD/libs/soci/build/lib/Debug" -lsoci_core_4_0 \
#        -L"$$PWD/libs/soci/build/lib/Debug" -lsoci_postgresql_4_0 \
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

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/libs/soci/build/lib/release/ -lsoci_core_4_0
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/libs/soci/build/lib/debug/ -lsoci_core_4_0

INCLUDEPATH += $$PWD/libs/soci/build/lib/Debug
DEPENDPATH += $$PWD/libs/soci/build/lib/Debug

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/libs/soci/build/lib/release/ -lsoci_postgresql_4_0
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/libs/soci/build/lib/debug/ -lsoci_postgresql_4_0

INCLUDEPATH += $$PWD/libs/soci/build/lib/Debug
DEPENDPATH += $$PWD/libs/soci/build/lib/Debug
