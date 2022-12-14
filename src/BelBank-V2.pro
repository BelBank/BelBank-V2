QT += quick core sql widgets network

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        card.cpp \
        controller.cpp \
        main.cpp \
        user.cpp

RESOURCES += resources.qrc

INCLUDEPATH += $$PWD/libs/soci/include \
        #$$PWD/libs/soci/build/include \





#linux {
#    LIBS += -L/usr/local/lib/ \
#         /usr/local/lib/libsoci_postgresql.so \
#         /usr/local/lib/libsoci_core.so
#}
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
    user.h
