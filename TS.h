/****************CREATION DE LA TABLE DES SYMBOLES ******************/
/***Step 1: Definition des structures de données ***/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Structure des TS- 
/*Dans ce TP, nous distinguons 3 types de TS: 
- TS pour les IDFs & CSTs
- TS des mots clés 
- TS des séparateurs. */
typedef struct
{
   int state;
   char name[20];
   char code[20];
   char type[20];
   char val[20];
 } TypeTS;

typedef struct
{ 
   int state; 
   char name[20];
   char type[20];
} TypeSM;

TypeTS TS[200];
TypeSM tabS[50],tabM[50];
int cpt, cpts, cptm;
/*1- initialisation de l'état des cases de la TS ***/
/*0: la case est libre  
  1: la case est occupée
  */
void initialization()
{
  int i;
  for (i=0;i<200;i++) TS[i].state=0;

  for (i=0;i<50;i++)
    {
      tabS[i].state=0;
      tabM[i].state=0;
    }
  cpt=0; cpts=0; cptm=0;  
}

/* 2- Fonction d'insertion des entités lexicales ***/

void inserer (char entite[], char code[],char type[],char val[],int i, int y)
{
  switch (y)
 { 
   case 1: /*insertion dans la table des IDF et CONST*/
       TS[i].state=1;
       strcpy(TS[i].name,entite);
       strcpy(TS[i].code,code);
	     strcpy(TS[i].type,type);
	     strcpy(TS[i].val,val);
       cpt++;
	   break;

   case 2:/*insertion dans la table des mots clés*/
       tabM[i].state=1;
       strcpy(tabM[i].name,entite);
       strcpy(tabM[i].type,code);
       cptm++;
       break; 
    
   case 3:/*insertion dans la table des séparateurs*/
      tabS[i].state=1;
      strcpy(tabS[i].name,entite);
      strcpy(tabS[i].type,code);
      cpts++;
      break;
 }
}

/* Fonction Rechercher permet de verifier  si l'entité existe dèja dans la table des symboles */
void rechercher (char entite[], char code[],char type[],char val[],int y)	
{

int j,i;

switch(y) 
  {
   case 1: 
        for (i=0;((i<200)&&(TS[i].state==1))&&(strcmp(entite,TS[i].name)!=0);i++); 
        if(i<200 && strcmp(entite,TS[i].name)!=0)
        { inserer(entite,code,type,val,i,1); 
        }else printf(">>>> L'entite %s existe deja \n",entite);
        break;

   case 2: //table des mots clés
       
       for (i=0;((i<50)&&(tabM[i].state==1))&&(strcmp(entite,tabM[i].name)!=0);i++); 
       if(i<50 && strcmp(entite,TS[i].name)!=0)
          inserer(entite,code,type,val,i,2);
        else
          printf(">>>> L'entite %s existe deja \n",entite);
        break; 
    
   case 3: //Table des séparateurs
        for (i=0;((i<50)&&(tabS[i].state==1))&&(strcmp(entite,tabS[i].name)!=0);i++); 
        if(i<50 && strcmp(entite,TS[i].name)!=0)
         inserer(entite,code,type,val,i,3);
        else
   	       printf(">>>> L'entite %s existe deja \n",entite);
        break;
  }
}


/*Fonction d'affichage de la TS */

void afficher()
{int i;

printf("/***************Table des symboles IDF*************/\n");
printf("____________________________________________________________________\n");
printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
printf("____________________________________________________________________\n");
  
for(i=0;i<cpt;i++)
{	
    if(TS[i].state==1)
      { 
        printf("\t|%11s |%12s | %12s | %12s\n",TS[i].name,TS[i].code,TS[i].type,TS[i].val);
         
      }
}
printf("\n/***************Table des symboles mots cles*************/\n");
printf("_____________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("_____________________________________\n");
  
for(i=0;i<cptm;i++)
    if(tabM[i].state==1)
      { 
        printf("\t|%10s |%12s | \n",tabM[i].name, tabM[i].type);
               
      }

printf("\n/***************Table des symboles separateurs*************/\n");

printf("_____________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("_____________________________________\n");
  
for(i=0;i<cpts;i++)
    if(tabS[i].state==1)
      { 
        printf("\t|%10s |%12s | \n",tabS[i].name,tabS[i].type );
        
      }

}








///////////////////////////////////////////////////////////////////


void insererType(char entite[], char type[]) {
    int posEntite = -1;
    int i; // Déclaration de la variable en dehors de la boucle

    // Recherche de l'entité dans la table TS
    for (i = 0; i < 200; i++) {
        if (TS[i].state == 1 && strcmp(TS[i].name, entite) == 0) {
            posEntite = i;
            break;
        }
    }

    if (posEntite != -1) {
        strcpy(TS[posEntite].type, type);
    } else {
        printf("Erreur : L'entité %s n'existe pas dans la table des symboles.\n", entite);
    }
}



///////////////////////////////////////





void insererTailleTab(char entite[], char taille[]) {
    int posEntite = -1;
    int i; // Déclaration de la variable en dehors de la boucle

    // Recherche de l'entité dans la table TS
    for (i = 0; i < 200; i++) {
        if (TS[i].state == 1 && strcmp(TS[i].name, entite) == 0) {
            posEntite = i;
            break;
        }
    }

    if (posEntite != -1) {
        strcpy(TS[posEntite].val, taille);
    } else {
        printf("Erreur : L'entité %s n'existe pas dans la table des symboles.\n", entite);
    }
}



///////////////////////////////


// double declaration **


int doubleDeclaration(char entite[]) {
    int posEntite;

    // Recherche de la position de l'entité dans la table TS
    for (posEntite = 0; posEntite < 200 && TS[posEntite].state == 1; posEntite++) {
        if (strcmp(TS[posEntite].name, entite) == 0) {
            break;
        }
    }

    if (posEntite == 200 || TS[posEntite].state == 0) {
        // L'entité n'existe pas dans la table des symboles
        return 0;
    }

    // Vérification si le type est déjà associé à l'entité
    if (strcmp(TS[posEntite].type, "") == 0) {
        return 0;  // Pas encore déclarée
    } else {
        return 1;  // Double déclaration
    }
}






/////////////////////////////////////

// compparison function 

// comparison_exp: arithmetic_exp comparison_op arithmetic_exp 

int compare(int x, const char *op, int y) {
    if (strcmp(op, "==") == 0) {
        return x == y;
    } else if (strcmp(op, "!=") == 0) {
        return x != y;
    } else if (strcmp(op, ">=") == 0) {
        return x >= y;
    } else if (strcmp(op, ">") == 0) {
        return x > y;
    } else if (strcmp(op, "<=") == 0) {
        return x <= y;
    } else if (strcmp(op, "<") == 0) {
        return x < y;
    } else {
        printf("Error: Unknown operator '%s'\n", op);
    }
}


/////////////////////////////////////////////////////////


// Function to retrieve the value associated with an identifier (IDF)


char* getValByIdf(char* idf) {
    int i; // Declare the variable outside the loop
    for (i = 0; i < 200; i++) {
        if (TS[i].state == 1 && strcmp(TS[i].name, idf) == 0) {
            return TS[i].val; // Return the value if the identifier is found
        }
    }
    return NULL; // Return NULL if the identifier is not found
}



