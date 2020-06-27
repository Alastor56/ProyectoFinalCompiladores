#include "TT.h"
#include <stdio.h>

void insertarType(TYPETAB *st, TYPE t){
    st->types[st->num] = t;
    st->num++;    
}

void imprimirType(TYPETAB *st){
    int i;
    for(i =0; i< st->num; i++){
        printf("%d\t%s\t%d\n", st->types[i].id, st->types[i].nombre, st->types[i].tam);
    }    
}

