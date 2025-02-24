TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp \
    dames.cpp \
    damierexc.cpp \
    damierstat.cpp \
    damierdyn.cpp \
    exceptiondamier.cpp

HEADERS += \
    dames.h \
    damierexc.h \
    damierstat.h \
    damierdyn.h \
    exceptiondamier.h
