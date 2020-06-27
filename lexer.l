%{
	#include<stdio.h>
	#include<string.h>
	#include "y.tab.h"
%}

%option yylineno

entero [0-9]
car [a-zA-Z]{1}
cadena ["][ \ta-zA-Z0-9]+["]
real ([0-9])+"."([0-9]){1,16}
dreal ([0-9])+"."([0-9]){1,32}
id ([_]([A-Z]){1}[a-z0-9]+){1,32}
comenlin --[ \ta-zA-Z0-9]+\n
comenmul [<][*][ \t\na-zA-Z0-9]+[*][>]
espacio [ \t\n]+

%%

estructura {return ESTRUCTURA;}
inicio {return INICIO;}
fin {return FIN;}
ent {return ENT;}
real {return REAL;}
dreal {return DREAL;}
car {return CAR;}
sin {return SIN;}
id {return ID;}
si {return SI;}
entonces {return ENTONCES;}
sino {return SINO;}
mientras {return MIENTRAS;}
segun {return SEGUN;}
hacer {return HACER;}
escribir {return ESCRIIR;}
leer {return LEER;}
devolver {return DEVOLVER;}
terminar {return TERMINAR;}
def {return DEF;}
caso {return CASO;}
pred {return PRED;}
y {return Y;}
no {return NO;}
o {return O;}
verdadero {return VERDADERO;}
falso {return FALSO;}
caracter {return CARACTER;}
":" {return DOS;}
"(" {return PAL;}
")" {return PAR;}
"[" {return COL;}
"]" {return COR;}
";" {return PYC;}
"." {return PUN;}
"<" {return MEN;}
">" {return MAY;}
"<=" {return MEI;}
">=" {return MAI;}
"<>" {return DIA;}
"=" {return IGU;}
":=" {return ASI;}
"+" {return MAS;}
"-" {return RES;}
"*" {return MUL;}
"/" {return DIV;}
"%" {return MOD;}

{id} { 
     yylval.line = yylineno;            
     strcpy(yylval.sval, yytext);
     return ID;
     }

{car} {
      yylval.num.tipo = 0;                
      strcpy(yylval.num.sval, yytext);
      return CARACTER;
      }
      
{cadena} {
	     yylval.line = yylineno;
         yylval.num.tipo = 1;                
         strcpy(yylval.num.sval, yytext);
         return CADENA;
         }

{entero} {   
         yylval.line = yylineno;
         yylval.num.tipo = 2;                
         strcpy(yylval.num.sval, yytext);
         yylval.num.ival = atoi(yytext);
         return NUM;
         }

{real} {   
       yylval.line = yylineno;
       yylval.num.tipo = 3;                
       strcpy(yylval.num.sval, yytext);
       yylval.num.ival = atoi(yytext);
       return NUM;
       }
            
{dreal} {   
         yylval.line = yylineno;
         yylval.num.tipo = 4;                
         strcpy(yylval.num.sval, yytext);
         yylval.num.dval = atof(yytext);
         return NUM;
         }
            
. {printf("Error Léxico en la linea %d\n", yylineno);}
%%

