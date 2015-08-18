

%{

#include <stdio.h>
#include <string.h>

typedef struct lexer
{
	char *text;
	int  len;
} lexer;

#define blue "\e[1;32m"
#define reset "\e0m"

typedef struct program{} program;

int yylex (struct lexer * l);

//#define LOG printf("\e[0;33m%s, %d, %s\e[0m\n", __FILE__, __LINE__, l->text)
#define LOG do{}while(0)

#define COPY(x, y)  do{ x = malloc(strlen(y)); strcpy(x,y); }while(0) 

void yyerror(lexer *l, program *p, char const * err)
{
	printf("ERROR : %s\n", err);
}

extern FILE * yyout;

%}

%token INT
%token FLOAT
%token STRING
%token INT_TYPE
%token FLOAT_TYPE
%token STRING_TYPE
%token SCAN
%token PRINT
%token PRINTLN
%token VARIABLE

%lex-param   {lexer * l}
%parse-param {lexer * l}
%parse-param {program * p}
	

%union
{
	char * s;
}

%type<s> type
%type<s> value

%%

program      : %empty                                      {  } 
		     | stmts                                       {  }

stmts        : stmt                                        {  }
             | stmts stmt                                  {  }


stmt         : print_expr ';'                              {  }
             | scan_expr  ';'

print_expr   : PRINT   '(' value ')'                       { fprintf(yyout,"\tstd::cout << %s;\n", $3); } 
             | PRINTLN '(' value ')'                       { fprintf(yyout,"\tstd::cout << %s << std::endl;", $3); }

scan_expr    : value '=' SCAN '(' type ')'              { fprintf(yyout,"\t%s %s;\n\tstd::cin >> %s;\n", $5, $1, $1); free($1); free($5);}

value        : STRING                                      { LOG; COPY($$, l->text); }
             | INT                                         { LOG; COPY($$, l->text); }
             | FLOAT                                       { LOG; COPY($$, l->text); }
             | VARIABLE                                    { LOG; COPY($$, l->text); }

type         : STRING_TYPE                                 { LOG; COPY($$, l->text); }
             | INT_TYPE                                    { LOG; COPY($$, l->text); }     
			 | FLOAT_TYPE                                  { LOG; COPY($$, l->text); }

%%


int main()
{
	extern FILE * yyin;

	FILE * fp = fopen("mylang.lang", "r");
	if ( ! fp )
		return 0;
	yyin = fp;
	lexer l;
	program p;
	FILE * out = fopen("mycpp.cpp", "w");
	fprintf(out,"#include<iostream>\nint main()\n{\n");

	yyout = out;
	do{
		yyparse(&l, &p);
	}while(!feof(yyin));

	fprintf(out,"}");
}
