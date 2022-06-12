%{
    #include <stdio.h> //Incluir 
    #include <stdlib.h>
    #include "tabla.h" //Cabecera de nuestra tabla de simbolos

    //Se referencia a variables externas a este fichero
    extern void yyerror (char *s); //Se externa es de lex
    extern int yylex(); //Parser lee el token y lo regresa para aca 
    extern Lista lista; //Lista de simbolos, que se genera en lex como Lista , ocupar una lista externa
    //Lista ya creada con los tokens, lexemas, todos estan en cero
    //Analizador sintactico buscalos y actualoza los valores

    //Se definen los prototipos de funciones
    int obtenerValor( char *symbol);
    void actualizarSimbolo( char *symbol, int valor);
%}

    %union { //Mediante union yylval, espacio de memoria definemo el tipo, num y id tipo cadena o string
        int num;
        char id[100];
    }

    %start line 
    %token print 
    %token exit_command
    %token <num> number
    %token <id> identifier 
    %type <num> exp term
    %type <id> assignment

%%
line: assignment            ':'     {;} /*Se inicia con token inicial, token start line, tenemos ssignment*/
        | exit_command      ':'     {exit(EXIT_SUCCESS);} /*o un exit command*/
        | print exp         ':'     {printf("El valor es: %d\n", $2);} /*print expresion, print token, imprimir la expresion print, $ print,  $2 a la expresión*/
        | line assignment   ':'     {;} /*No hacemos nada*/
        | line print exp    ':'     {printf("El valor es: %d\n", $3);} /*Imprimir expresion*/
        | line exit_command ':'     {exit(EXIT_SUCCESS);} /*line exit salimos*/
        ;

assignment : identifier     '>' exp {actualizarSimbolo($1, $3);} /*Encontremos un identificador reciba expresion se actualiza el simbolo, nos pasa edl lexeman dl identificado y el valor numerico*/
; /*Un identificador igual a una expresion, aveztruz = 5+4; Cuando encontramos esta estructura actualizar simbolo, identificador $1, expresion$3*/

exp: term                           {$$ = $1;}  /*Expresion a un termino, un numero o un identificador*/
        //Expresion resuelve en termino $$ = $1 termino en expresion
        | exp '&'   term            {$$ = $1 + $3;} //
        | exp '_'   term            {$$ = $1 - $3;}
        | exp '#'   term            {$$ = $1 * $3;}
        | exp '%'   term            {$$ = $1 / $3;}
        ;

term: number                        {$$ = $1;} /* Termino: numero o identificador*/
        //Termino resuelv en numero $$ = $1 Termino resolver directamente en numero
        | identifier                {$$ = obtenerValor($1);} //Obtener el valor en la tabla de sinmbolesdel identificador
        ;
%%

int obtenerValor( char *symbol){ 
    Simbolo *buscado = buscar(&lista, symbol); 
    return buscado -> valor; 
}

//Ocupamos la funcion modificar en la interfaces de la tabla de simbolos
void actualizarSimbolo( char *symbol, int valor){
    modificar(&lista, symbol, valor); 
}

/*Main manda a llamar al generador del analizador yyparse*/

int main(void) {
    return yyparse();
}

/*yyerror, amndar print f, de errores, de un buffer de lex, sintasix error*/

void yyerror(char *s){
    fprintf(stderr, "%s\n", s);
}

