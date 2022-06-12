//Tabla: Estructura de datos: Lista simplemnete ligada, por un solo cmaino
//Simbolos

#include <stdlib.h>

//Tabla hay simbolos (record) --> Estructura emular, esquematizar, un simbolo, un identificador, el
//lexema y el valor

typedef struct Simbol //Registro
{
    /* data */
    char nombre[100];
    int valor;
}Simbolo;

//Lista simplemnete ligada requiere nodos para irse encadenando uno a otro
//Tabla de simbolos es varaiable para eso funciona 

typedef struct Nodo
{
    /* data */
    Simbolo simbolo;
    struct Nodo *siguiente; //Referencia a el mismo, autoreferenciables, laslistas doblemente ligadas autoreferenciadas
} Nodo;

//Lista
typedef struct Lista
{
    /* data */
    Nodo *cabeza; //Apuntador de la cabeza, ahi inicia el recorrrido hacia la derecha
    //Mantener apuntador
    int longitud; //Guarda la longitud que lleva
}Lista;

//Definicion de los métodos
//Prototipos --> .h de la tabla prototipo de la lista simplemente ligada
Nodo *crearNodo(Simbolo *simbolo);
void destruirNodo(Nodo *nodo); //Destruir o libera la memoria, un nodo cuando no queramos ocupa
void insertar(Lista *lista, Simbolo *simbolo);
Simbolo *buscar(Lista *lista, char *nombre); //Una vez que el analizador lexico
//ya ingreso un identificador a la tabla de simbolos, el analizador sisntactico requiere buscar
//cuando se pasa el lexema debe buscar el lexeman en la tabla para buscar su valor
void modificar(Lista *lista, char *Simbolo, int valor);
//Modificar, el sintactico requiere a veces modificar el valor que el
//analizador lexico ya puso en la tabla de simbolos.




