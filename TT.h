 #ifndef TABSYM_H
#define TABSYM_H

typedef struct type{
    int id;
    char nombre[32];
    int tam;    
} TYPE;

typedef struct typetab{
	TYPE types[20];
	int num;
}TYPETAB;

void insertarType(TYPETAB *st, TYPE t);
void imprimirType(TYPETAB *st);
#endif
