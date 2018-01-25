%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbolTab.h"

void afficherQuad();
int yylex();
int yyparse();
int yyerror(char*);
void insererQuadComplet(char operation[], char operande1[] , char operande2[] , char res[]);
void ajouterQuad(int num_quad , int colon_quad , char val[]);
int deb_if  = 0, fin_if  = 0 , numQuad = 0;
extern FILE *yyin;
extern int nbcl, nbln;
extern char line[1000];
typsym listeDeSymbol = NULL;
typsym firstBlockOfTypes = NULL;
typsym lastNoeudOfListe = NULL;
char tmp1[20] ,tmp2[20]  ;
int taille = 1;
%}
%union{
int ent ;
char* chn;
float reel;
}

%token <chn>idf mc_algo mc_var dpts pvg mc_debut mc_fin crov crfr prov  prfr separateur 
%token eff mc_si mc_faire mc_fait tab  egal chn <reel>reel <ent>ent <chn>pls <chn>mns <chn>mul <chn>mc_chn <chn>mc_rl
%token  <chn>mc_int mc_pour mc_jus sup inf supeg infeg diff 
%type <chn>idn 
%type <chn>opr 
%type<chn>X 
%type<chn>ops
%type<chn>ops1
%type<chn>ops2
%type<ent>Y

%%
/* Definir le nom de program comme ça ALGORITHME nomProgram;*/
s: mc_algo  idf corp  
 ;
/*Definir les terminaux remplace un numero */

/*declas , insts : non terminaux*/
corp: mc_var declav mc_debut instv mc_fin {printf("\nfin de program , program correcte syntaxiquement\n");YYACCEPT;}
    ;
/* les mots clés : REEL , ENTIER,CHAINE*/
type: mc_chn {inserttype(firstBlockOfTypes,$1); firstBlockOfTypes=NULL; } 
    | mc_rl {inserttype(firstBlockOfTypes,$1);firstBlockOfTypes=NULL; }
    | mc_int {inserttype(firstBlockOfTypes,$1);firstBlockOfTypes=NULL; }
    ;

declas: decla declas 
      | decla 
      ;
/*exemple de declaration => nomVar1 | nomVar2 : ENTIER */
decla: idfs dpts type pvg {printf("DECLARATION\n");}
	 ; 

idfs: variable separateur idfs
	| variable 
	;
Y :  crov ent crfr {
				taille = $2;			
				$$ = taille;
				}
| {$$ = 1;};
	
variable : idf Y
		   {
		printf("var : %s \n",$1);
		if(notexist(listeDeSymbol,$1) == 1){
				lastNoeudOfListe = inserer(&listeDeSymbol , $1 , "idf" , "" ,taille);
				taille = 1;
				printf("inserer %s dans la table de symbole \n" , $1 );
				if(firstBlockOfTypes == NULL){
					firstBlockOfTypes  = lastNoeudOfListe;
					}
				}else{
					printf("une variable avec cette nom existe déja\n");}
		
		}| 
		;

/* pls : plus , mns : moins */
ops1: pls
	| mns
	;

ops2: mul 
	;

idn: idf {$$ = $1;}
   | reel {float t = $1 ; sprintf(tmp1 , "%f" ,t);$$ = tmp1;printf(" %s\n", tmp1); }
   | ent {int b = $1;sprintf(tmp1 , "%d" ,b);$$ = tmp1;printf(" $1 = %d\n",$1); }
   ;
affc: idf Y eff {

   				 }
   	
	;


affp: affc ent mc_jus ent mc_faire 
	;

insts: inst 
	 | inst insts
	 ;
instv: insts| ;
declav: declas| ;	 

inst:  idf Y eff opr pvg {if(notexist(listeDeSymbol , $1) == 1)
   					{printf("%s n est pas declare\n" , $1);
   					
   					}
   					insererQuadComplet("<-" , $4 , "",$1);
   					
					if($2 > 1)
					if(tailleDeTable( listeDeSymbol ,$1 )< $2)
						yyerror("erreur : depacement de taille\n");}
	| pourblock 
	| siblock {printf("\ninst secc\n");}
	;

X:'/' ent {if($2==0){ yyerror("erreur arithmetique : division par zero\n");}}
 ;

opr:idn 
   | opr ops idn {sprintf(tmp1 , "%d" ,$3);sprintf(tmp2 , "%d" ,$1);insererQuadComplet($2 , $1 , $3 , $$);}
   | opr X
   | opr '/' idf {if(notexist(listeDeSymbol , $3) == 0)
   					{printf("%s n est pas declare\n" , $3);
   					}
   					insererQuadComplet("/" , $1 , $3 , $$);
   				 }
   ;

ops: ops1
   | ops2
   ;

compa: sup 
     | inf
     | supeg 
     | infeg 
     | diff
     | egal
     ;

pourblock: mc_pour affp insts mc_fait  { printf("\nfin boucle \n");} 
		 ;
/*instruction if*/
siblock: mc_faire insts mc_si prov cdt prfr{
		
		deb_if = numQuad; 
		}
	   ;

cdt: idn compa idn {}
   ;
   
%%
int yyerror(char *msg){
	int i = 0;
	printf("%s\n",line);
	for( ; i < 1000; i++)
	if(line[i]!= '\0')
		printf(" ");
		else
		break;
		printf("^^^\n");
	printf("%s  at line :%d column :%d\n",msg, nbln, nbcl);	
	return 1;
}

int main (int argc, char *argv[])
{
yyin = fopen("INPUT.txt", "r");
yyparse();
affichage(listeDeSymbol);
afficherQuad();
fclose(yyin);
return 0;
}

