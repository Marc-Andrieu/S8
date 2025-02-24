#ifndef EXCEPTIONDAMIER_H
#define EXCEPTIONDAMIER_H

#include <iostream>
#include <sstream>
#include <exception>
using namespace std;

class ExceptionDamier : public exception {
    public:
        ExceptionDamier(int borne, int valeur, string fichier, string fn) throw();
        virtual const char* what() const throw();
    private:
        int borne;
        int valeur;
        string answer;
};

#endif // EXCEPTIONDAMIER_H
