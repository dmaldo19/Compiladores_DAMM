// Este es un programa de prueba
#include <stdio.h>

int main() {
    int contador = 0;
    double promedio = 15.5;
    
    /* Este es un comentario
       de múltiples líneas */
    
    for (int i = 0; i < 10; i++) {
        contador += i;
    }
    
    char* mensaje = "Hola mundo!";
    
    if (contador > 20) {
        return 1;
    } else {
        return 0;
    }
}