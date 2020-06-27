#include "TS.h"

void insertar(SYMTAB *st, SYM s){
    if(!getId(s.id)){
        st->syms[st->num] = s;
        st->num++;
        return true;
    }
    return false;
}

void imprimir(SYMTAB *st){
    int i;
    for(i =0; i< st->num; i++){
        printf("%s\t%d\t%d\n", st->syms[i].id, st->syms[i].tipo, st->syms[i].dir);
    }    
}

int getTipo(SYMTAB *st, char *id){
    int i;
    for(i =0; i< st->num; i++){
        if(strcmp(st->syms[i].id, id) == 0)
            return st->syms[i].tipo;
    }
    return -1;
}

int getDir(SYMTAB *st, char *id){
    int i;
    for(i =0; i< st->num; i++){
        if(strcmp(st->syms[i].id, id) == 0)
            return st->syms[i].dir;
    }
    return -1;
}

bool getID(SYMTAB *st, char *id){
    int i;
    for(i =0; i< st->num; i++){
        if(strcmp(st->syms[i].id, id) == 0)
            return true;
    }
    return false;
}

/*Lo mismo que TS.h
 * verificar nombre de variables coincidan*/
