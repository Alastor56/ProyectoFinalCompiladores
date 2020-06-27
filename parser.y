%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "TS.h"
#include "TT.h"
#include "tipos.h"

extern FILE* yyin;
extern int yylex();
extern FILE* yyout;
extern char* yytext;
void yyerror(char *s);
SYMTAB simbolos;
TYPETAB tipos;
int posicionTT;
int dirGBL;
int strutGBL = 0;
char idGBL[100];
int dirGene;
int typeGBL;
int dir = 0;

void init();
%}

%union{
    struct{
        int tipo;
        char dir[32];
    } num;
    
    struct{
        int tipo;
        char dir[32];
    }expresion;
    char id[32];
    int tipo;
    
    /*Definir estructuras*/
}

/*verificar precedencia...*/
%token ESTRUCTURA
%token ENT CAR SIN REAL DREAL
%token <id> ID
%token <numero> NUM
%token DEF
%token SI
%token MIENTRAS
%token SEGUN
%token ESCRIBIR
%token LEER
%token DEVOLVER
%token PYC
%token COMA
%token TERMINAR
%token CASO
%token DOS
%token ENTONCES
%token PRED
%left O
%left Y
%right NO
%token VERDADERO
%token FALSO
%token<numero> CADENA
%token<numero> CARACTER
%token PUNTO
%left MEN
%left MAY
%left MEI
%left MAI
%left DIA
%right IGUAL
%left ASIGNACION
%left MAS RES
%left MIL DIV
%left MOD
%nonassoc PAL PAR
%nonassoc COL COR
%nonassoc SINO

%type<tipo> tipo
%type<expresion> expresion

%start program

%%

program: {
            init();
        }
        declaraciones  
        { 
            imprimir(&simbolos);
            imprimirType(&tipos);
        }
        sentencias;

declaraciones: tipo {
                    typeGBL = $1 ;
                }
                listavar PYC  declaraciones |  ;

tipo: INT {
            $$ = 0;
        }
        | FLOAT {
            $$= 1;
        };

listavar: listavar COMA ID 
        {
            SYM s;
            strcpy(s.id, $3);
            s.tipo = typeGBL;
            s.dir = dir;
            dir+= 4;
            insertar(&simbolos, s);
        } 
        | ID
        {
            SYM s;
            strcpy(s.id, $1);
            s.tipo = typeGBL;
            s.dir = dir;
            dir+= 4;
            insertar(&simbolos, s);
        } 
        ;

sentencias: sentencias sentencia | sentencia;

sentencia: ID 
            {
                if(!getID(&simbolos, $1))
                    yyerror("El id no fue declarado");                
            }
            ASIG expresion PYC
            {
                char dir1[32];
                reducir(dir1, $4.dir, $4.tipo, getTipo(&simbolos, $1));
                printf("%s = %s\n", $1, dir1);
            };

expresion: expresion MAS expresion
                {                   
                    char dir1[32], dir2[32]; 
                    newTemp($$.dir);
                    $$.tipo = max($1.tipo, $3.tipo);
                    ampliar(dir1, $1.dir, $1.tipo, $$.tipo);
                    ampliar(dir2, $3.dir, $3.tipo, $$.tipo);
                    printf("%s = %s + %s\n", $$.dir, dir1, dir2);
                }            
            | expresion MUL expresion 
                {                   
                    char dir1[32], dir2[32]; 
                    newTemp($$.dir);
                    $$.tipo = max($1.tipo, $3.tipo);
                    ampliar(dir1, $1.dir, $1.tipo, $$.tipo);
                    ampliar(dir2, $3.dir, $3.tipo, $$.tipo);
                    printf("%s = %s * %s\n", $$.dir, dir1, dir2);
                }   
            | LPAR expresion RPAR
                {
                    $$= $2;
                }
            | ID  
            {
                if(!getID(&simbolos, $1))
                    yyerror("El id no fue declarado"); 
                else{
                    $$.tipo = getTipo(&simbolos, $1);
                    strcpy($$.dir, $1);
                }
            }  
            | NUM
            {
                $$.tipo = $1.tipo;
                strcpy($$.dir, $1.dir);
            };


/*Agregar las producciones restastes (ejemplo en escritorio)
  para generacion de codigo intermedio. video en youtube de la clase
  con ejemplo "calculadora"*/


%%
void yyerror(char *s){
    printf("%s, linea: %d, token: %s\n",s, yylineno, yytext);
}


void init(){
    TYPE tint, tfloat;
    tipos.num = 0;
    simbolos.num =0;
    
    tint.id  = 0;
    strcpy(tint.nombre, "int");
    tint.tam = 4;

    tfloat.id  = 1;
    strcpy(tfloat.nombre, "float");
    tfloat.tam = 4;

    insertarType(&tipos, tint);
    insertarType(&tipos, tfloat);
}

