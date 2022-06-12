%{
    /*Se inclueyen prototipos y librerias*/
    #include <string.h>
    #include "interprete.tab.h" /*Donde se definen las estructuras, los protipos de tabla.h*/

    #include "tabla.h" /*Incluimos la tabla que codificamos*/ 
    extern void yyerror(char *s);

    Lista lista = { NULL, 0};
%}

%%

"imprimir"      {return print;} //Encuentra print regresar un roken llamado print
"salir"         {return exit_command;} //Encuenntra exit regresa token exit_command
[0-9]+          {yylval.num = atoi(yytext); return number;} //Los numeros se ponen en yyval.num, yylval variable global, 
[a-zA-Z]+       {
                    //Se busca en la tabla el simbolo del identificador
                    Simbolo *buscado = buscar(&lista, yytext); //Aunque tabla de simbolos fuera un arbol binario, arbol ABL
                    //Pasa el espacio de memoria, el simbolo, y el lexema

                    //Si no se encuentra, la tabla devuelve NULL
                    if (buscado == NULL ){
                        Simbolo simbolo; //Estructura Simbolo
                        strcpy(simbolo.nombre, yytext);
                        simbolo.valor = 0; //Valor de 0
                        insertar(&lista, &simbolo); //Insertamos en la tabla de SIMBOLOS
                        //List en un inicio apunta a NULL, va creciendo nuestra estructura, el 
                        //insertamos el simbolo, nodo se liga
                    }

                    //Si existe, al valor yylval llamado id le pasamo los que tenga el token de yytext
                    //Si se encuentra, se pasa
                    strcpy(yylval.id, yytext); //Lo pasa al sintactico
                    return identifier; //Regresamos el token indintefier
                }

[ \t\n]         ; //Ignora tabluaciones
[_&#%>:]        {return yytext[0];} //menos, mas, igual se regresa el token se regresa como tal, no se ingresan en la tabla
.               {ECHO; yyerror ("Caracter no definido");} //Cualquier otro caracter

%%

int yywrap(void) {
    return 1; //Se puede poner, exito de compilacion, valor de exito
}


