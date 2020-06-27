#include<stdio.h>
#include<string.h>
#include<tipos.h>

int max (int t1, int t2){
  if(t1 == t2) return t1;
  if(t1 == 0 && t2 == 1) return 1;
  if(t1 == 1 && t2 == 0) return 1;
  return -1;
}

int ampliar (char *fin, char *dir, int t1, int t2){
  if(t1 == t2) strcpy(fin,dir);
  else if(t1 == 0 && t2 == 1){
    newTemp(fin);
    printf("%s = (float)%s\n", fin, dir);)
  }
}

int reducir (char *fin, char *dir, int t1, int t2){
  if(t1 == t2) strcpy(fin,dir);
  else if(t1 == 0 && t2 == 1){
    newTemp(fin);
    printf("%s = (int)%s\n", fin, dir);)
  }
}

void newTemp(char* s){
  static int num = 0;
  sprintf(s, "t%d", num++);
}
