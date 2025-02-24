#include "exceptiondamier.h"
#include <string.h>

ExceptionDamier::ExceptionDamier(int b, int val, string fichier, string fn) throw() {
    borne = b;
    answer += "Borne :" + to_string(b) + "\n";
    answer += "Valeur rejetée : " + to_string(val) + "\n";
    answer += "Fichier : " + fichier + "\n";
    answer += "Fonction" + fn + "\n";

}

const char* ExceptionDamier::what() const throw()
{
    return answer.c_str();
}

