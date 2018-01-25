#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct noeud
{
    char nom[20];
    char type[20];
    char code[20];
    int length;
    struct noeud* svt;
};
typedef struct noeud* typsym;


typsym init()
{
    typsym nouveau  = (typsym)malloc(sizeof(struct noeud));
    strcpy(nouveau->nom , "");
    strcpy(nouveau->code , "");
    strcpy(nouveau->type , "");
    nouveau->svt = NULL;
    return nouveau;
}
void affichNoeud(typsym n)
{
    printf("\n %8s  %8s  %8s %d\n", n->nom , n->type , n->code , n->length);
}
void affichage(typsym liste)
{
printf("\n %8s  %8s  %8s %s\n","nom" , "type" , "code" , "length");
    for( ; liste != NULL; liste = liste->svt)
        affichNoeud(liste);
}
int tailleDeTable(typsym symbol , char nom[])
{
	for(; symbol != NULL;symbol = symbol->svt)
		if(strcmp(symbol->nom , nom) == 0){
			return symbol->length;
		}
		return 1;
}
typsym last(typsym tete){
for(;tete->svt != NULL;tete = tete->svt);
return tete;
}
typsym inserer(typsym *tete, char nom[], char type[],char code[], int length)
{
    typsym nouveau= init() , lst;
    strcpy(nouveau->nom, nom);
    strcpy(nouveau->code, code);
    strcpy(nouveau->type, type);
    nouveau->length = length;
    if(*tete != NULL){
    lst = last(*tete);
    lst->svt = nouveau;
    }else
        *tete = nouveau;
    nouveau->svt = NULL;
    return nouveau;
}



int notexist(typsym liste,char nom[]){
	for(; liste != NULL ; liste = liste->svt){
		if(strcmp(liste->nom , nom) == 0)
			return 0;
	}
	return 1;
}

void inserttype(typsym first , char type[]){
	for(; first != NULL ; first = first->svt){
		strcpy(first->type , type);
	}
}

