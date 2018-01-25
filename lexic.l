%{
#include <string.h>
#include <stdio.h>
#include "synt.tab.h"
#include "quadruple.h"
extern YYSTYPE yylval;
int nbcl = 1 , nbln = 1 , lastid = 0 ;

char line[1000] = "" , champ[20];
%}
IDF [a-zA-Z][a-zA-Z0-9]*
entier [1-9][0-9]*|0
%%
\".*\" {return chn;}
REEL { strcat(line , yytext);nbcl = nbcl+yyleng; yylval.chn=strdup(yytext);return mc_rl;}
CHAINE { strcat(line , yytext);nbcl = nbcl+yyleng; yylval.chn=strdup(yytext);return mc_chn;}
ENTIER { strcat(line , yytext);nbcl = nbcl+yyleng; yylval.chn=strdup(yytext);return mc_int;}
ALGORITHME { strcat(line , yytext);nbcl = nbcl+yyleng; return mc_algo;}
VAR {strcat(line , yytext); nbcl = nbcl+yyleng; return mc_var;}
DEBUT { strcat(line , yytext);nbcl = nbcl+yyleng;return mc_debut;}
FIN { strcat(line , yytext);nbcl = nbcl+yyleng;return mc_fin;}
SI { strcat(line , yytext);nbcl = nbcl+yyleng;return mc_si;}
FAIRE {strcat(line , yytext);nbcl = nbcl+yyleng;return mc_faire;}
FAIT {strcat(line , yytext);nbcl = nbcl+yyleng;return mc_fait;}
POUR {strcat(line , yytext);nbcl = nbcl+yyleng;return mc_pour;}
JUSQUE {strcat(line , yytext);nbcl = nbcl+yyleng;return mc_jus;}
"|" {strcat(line , yytext); nbcl = nbcl+yyleng;return separateur;}
\> {strcat(line , yytext);nbcl = nbcl+yyleng;return sup;}
\< {strcat(line , yytext);nbcl = nbcl+yyleng;return inf;}
\<= {strcat(line , yytext);nbcl = nbcl+yyleng;return supeg;}
\>= {strcat(line , yytext);nbcl = nbcl+yyleng;return infeg;}
\!= {strcat(line , yytext);nbcl = nbcl+yyleng;return diff;}
= {strcat(line , yytext);nbcl = nbcl+yyleng;return egal;}
; {strcat(line , yytext);nbcl = nbcl+yyleng;return pvg;}
{entier}\.{entier} {strcat(line , yytext);nbcl = nbcl+yyleng; yylval.reel= (float)atoll(yytext);
return reel;}
{entier} {strcat(line , yytext);
nbcl = nbcl+yyleng;
yylval.ent=atoi(yytext);
         return ent;
         }
\/\/(.)*\n {printf("commentaire! \n");}
\[ {strcat(line , yytext);nbcl = nbcl+yyleng;return crov;}
\] {strcat(line , yytext);nbcl = nbcl+yyleng;return crfr;}
\( {strcat(line , yytext);nbcl = nbcl+yyleng;return prov;}
\) {strcat(line , yytext);nbcl = nbcl+yyleng;return prfr;}
\<\- {strcat(line , yytext);nbcl = nbcl+yyleng;return eff;}
\+ {strcat(line , yytext);nbcl = nbcl+yyleng;
yylval.chn=strdup(yytext);
return pls;}
\- {strcat(line , yytext);nbcl = nbcl+yyleng;
yylval.chn=strdup(yytext);
return mns;}
\* {strcat(line , yytext);nbcl = nbcl+yyleng;yylval.chn=strdup(yytext);
return mul;}
\/ {strcat(line , yytext);nbcl = nbcl+yyleng;
	return '/';}
: {strcat(line , yytext);nbcl = nbcl+yyleng;return dpts;}
{IDF} {strcat(line , yytext);
		if(yyleng >12) { printf ("erreur : length (%s) = %d > 12 \n" , yytext , yyleng) ;
        				exit(1);
        }
        nbcl = nbcl+yyleng;
		yylval.chn=strdup(yytext);
		return idf; 
      }

\/\*(.|\n)*\*\/ {printf("commentaire! \n");}
[ \t] {nbcl++;}
\n {strcpy(line,"");
nbcl=0; nbln++;}

. {
	/*int i = 0;
printf("%s\n",line);
	for( ; i < 1000; i++)
	{
		if(line[i]!= '\0') printf(" ");
		else break;
	}
	printf("^^^\n");
	printf("\nLEX ERROR line %d column %d\n",nbln,nbcl); */
  }
  
%%

int yywrap(){
}


