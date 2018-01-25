#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct qdr{
char operation[100];
char operande1[100];
char operande2[100];
char res[100];
}qdr;

qdr quad[1000];
extern int numQuad;

void ajouterQuad(int num_quad , int colon_quad , char val[])
{
	switch (colon_quad) {
		case 1:
			strcpy(quad[num_quad].operation ,val);
		break;
		case 2:
			strcpy(quad[num_quad].operande1 , val);
		break;
		case 3:
			strcpy(quad[num_quad].operande2 , val);
		break;
		case 4:
			strcpy(quad[num_quad].res , val);
	}
}

void insererQuadComplet(char operation[], char operande1[] , char operande2[] , char res[]){
	strcpy(quad[numQuad].operation,operation);
	strcpy(quad[numQuad].operande1 , operande1 ) ;
	strcpy(quad[numQuad].operande2 , operande2);
	strcpy(quad[numQuad].res , res);
	numQuad++;
}

void unSeulQuad(qdr elem){
	printf(" %8s | %8s | %8s | %8s \n" , elem.operation , elem.operande1 , elem.operande2 , elem.res);
}
void afficherQuad(){
printf("\n\n\tLES QUADES RUPLES \n\t==================\n");
printf(" %8s | %8s | %8s | %8s \n","operation","operande1","operande2","resultat");
int i = 0;
for( ; i < numQuad ; i++)
unSeulQuad(quad[i]);
printf("===========================\n");
}

