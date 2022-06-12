//Tabla de simbolos
//Lista de implementacion de la lista simplemente ligada

//Incluir prototipos y cabeceras

#include "tabla.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h> //Librerias estadares de C

Nodo *crearNodo(Simbolo *simbolo){ //Apuntador de un sibolo
    Nodo *nodo = (Nodo*)malloc(sizeof(Nodo)); //Crea nodo a partir de ese siimbolo
    //Apuntador a un nodo de tamaño o que mide la estructura nodo
    //Nodo es un apuntador, apuntador a un nodo de tamaño de la estructura de nodo
    //Size tamaño de de la estructura Noda, casteamos
    strcpy( nodo->simbolo.nombre, simbolo->nombre); //Nodo en su compa nombre
    nodo ->simbolo.valor  = simbolo->valor;
    nodo -> siguiente = NULL; // Lista simplemente ligada
    return nodo; //Regresa nodo
} //CRearnos un nodo


void insertar( Lista *lista, Simbolo *simbolo){ //Lista, espacio de memoria de la misma tabla, y el simbolo que se quiere insertar en el nodo
    Nodo *nodo = crearNodo(simbolo); //Se crea nodo
    nodo ->siguiente = lista->cabeza;  //Ligar nodo del que estan pasando con la cabeza de la lista
    //Primero el nodo apunta a la cabeza y la cabeza al nodo  y asi quedan ligados
    //Aumente la longitud de la lista
    lista -> cabeza = nodo;
    lista -> longitud++;
} //Crear nodo y destruir nodo

//Insertando en la parte de atras, como si fuera unacola
//Pero es una lista simplemente ligada

Simbolo *buscar(Lista *lista, char *nombre){ //Rgresa tipo simbolo, requiera lista de memoria eidentificador
    Nodo *aux = lista->cabeza; //Apunta a la cabeza, se inicia ahi y despues derecha secuencialmente
    while (aux){
        if( strcmp( aux->simbolo.nombre, nombre) == 0 ){ //comparamos, en el nodo actual con el parametro
            return &aux->simbolo; //regresa simbolo
        }
        aux = aux->siguiente; //Si no avanza
    }
    return NULL;
}

void modificar(Lista *lista, char *simbolo, int valor){ //Reciba lista, espacio de memoria, el lexema (simbolo) que sea desea modificar y el valor que e requiere ingresar
    Simbolo *buscado = buscar(lista, simbolo); //Ocupamos funcion buscar, regresa un apuntador
    buscado->valor = valor;//Modificar el valor de ese pauntador espacio de memoria
}
