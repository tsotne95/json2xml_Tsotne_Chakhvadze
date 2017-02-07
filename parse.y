%{
#include <stdio.h>
#include <string.h>

char *new_str(const char *str);

int yylex();
void yyerror(const char *);

struct Node {
		char *pre;
		char *post;
		struct Node *right;
		struct Node *down;
	};



struct Node* new_node();
struct Node* start=NULL;

%}
%define parse.error verbose

%union {
	char *str;
	struct Node *node;
}

%token <str> __STRING_LITERAL
%token <str> __NUMBER
%token <str> __BOOLEAN __NULL

%type <node> object members pair array elements value
%%

document: object		{	
					start=$1;
				}
	;

object: '{' members '}' 	{	
					$$ = $2;
				}
	;

members: /*nothing*/		{
					$$=NULL;
				}	  
	| pair 			{
					$$=$1;
				}
	| pair ',' members 	{
					$$=$1; $1->down=$3;
				}
	;

pair: __STRING_LITERAL ':' value {
					$1[strlen($1)-1]='\0';
					$$=new_node();
					$$->pre=(char *)malloc(sizeof(char)*strlen($1)+10);
					sprintf($$->pre,"<%s>",$1+1);
					$$->post=(char *)malloc(sizeof(char)*strlen($1)+10);
					sprintf($$->post,"</%s>",$1+1);
					$$->right=$3;
				}
	;

elements: value 	     	{
					$$=new_node();
					$$->pre=new_str((const char*)"<elem>");
					$$->post=new_str((const char*)"</elem>");
					$$->right=$1;
		     		}
	| value ',' elements 	{
					$$=new_node();
					$$->pre=new_str((const char*)"<elem>");
					$$->post=new_str((const char*)"</elem>");
					$$->right=$1;
					$$->down=$3;
		    		}
	;

array:	  '[' ']' 		{
					$$=NULL;
				}
	| '[' elements ']' 	{
					$$=$2;
				}
	;


value:	  object  		{
					$$=$1;
				}
	| array 		{
					$$=$1;
				}
	| __STRING_LITERAL 	{
					$$=new_node(); $$->pre=$1;
				}
	| __NUMBER		{
					$$=new_node(); $$->pre=$1;
				}
	| __BOOLEAN		{
					$$=new_node(); $$->pre=$1;
				}
	| __NULL		{
					$$=new_node(); $$->pre=$1;
				}
	;
%%

const struct Node def={NULL,NULL,NULL,NULL};

struct Node* new_node()
{
	struct Node *tmp=(struct Node*)malloc(sizeof(struct Node));
	*tmp=def;
	return tmp;
}

void pr_t(int n)
{
	while(n--)
		printf("\t");
}

void print_tree(struct Node *tree, int t)
{
	if(tree->pre)
		{
			pr_t(t); 
			printf("%s\n",tree->pre);
		}
	if(tree->right)
		print_tree(tree->right,t+1);
	if(tree->post)
		{
			pr_t(t);
			printf("%s\n",tree->post);
		}
	if(tree->down)
		print_tree(tree->down,t);
}

void yyerror(const char *s) {
  printf("\n%s\n",s);
}

int main(void) {
  yyparse();
  if(start)
	print_tree(start, 0);
  return 0;
}
