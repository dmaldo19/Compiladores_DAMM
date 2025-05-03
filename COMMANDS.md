# Comandos Útiles para los Hands-On que he realizado

Este archivo contiene una lista de los comandos que utilizo a la hora de los Hands-On para aprenderlos mejor y para tener una guía.

## Comandos de WSL

### Abrir el WSL.

    ```
    wsl.exe -d Ubuntu
    ```
## Comandos de Compilación y Ejecución.
    ```
    bison -d parser.y
    flex scanner.l
    gcc -o verificador_ids parser.tab.c lex.yy.c -lfl
    ```
### Ejecución
* Sin archivos de entrada Necesarios
    ```
    ./validar
    ```
* Con archivos de entrada Necesarios
    ```
    ./verificador_ids < entrada1.txt
    ```
