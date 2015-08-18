

%{

#include <stdio.h>

typedef struct lexer
{
	char *text;
	int  len;
} lexer;


typedef struct program program;

#include "parser.h"

#define YY_DECL int yylex (lexer * l)

#define SAVE do{ l->text = yytext; l->len = yyleng; }while(0)

#define PRINTF(...)  do{}while(0)

%}

DIGIT          [0-9]
CHAR           [a-zA-Z0-9 \n\t_.;]
SCAN           "scan"
PRINT          "print"
PRINTLN        "println"
INT_TYPE       "int"
STRING_TYPE    "string"
FLOAT_TYPE     "float"
VARIABLE       [a-zA-Z_]+
INT            {DIGIT}+
FLOAT          {DIGIT}*\.{DIGIT}+
STRING         \"{CHAR}+\"

%%

{INT} 			      { SAVE; PRINTF("integer :%s\n", yytext); return INT; }
{FLOAT}			      { SAVE; PRINTF("float: %s\n",yytext); return FLOAT; }
{STRING}		      { SAVE; PRINTF("string: %s\n", yytext); return STRING; }
{INT_TYPE} 			  { SAVE; PRINTF("int_type :%s\n", yytext); return INT_TYPE; }
{FLOAT_TYPE}	      { SAVE; PRINTF("float_type: %s\n",yytext); return FLOAT_TYPE; }
{STRING_TYPE}	      { SAVE; PRINTF("string_type: %s\n", yytext); return STRING_TYPE; }
{SCAN}			      { SAVE; PRINTF("scan: %s\n", yytext); return SCAN; }
{PRINT}			      { SAVE; PRINTF("print: %s\n", yytext); return PRINT; }
{PRINTLN}			  { SAVE; PRINTF("println: %s\n", yytext); return PRINTLN; }
{VARIABLE}	          { SAVE; PRINTF("variable: %s\n", yytext); return VARIABLE; }
[(]				      { SAVE; PRINTF("opening: %s\n", yytext); return '('; }
[)]				      { SAVE; PRINTF("closing: %s\n", yytext); return ')'; }
[=]				      { SAVE; PRINTF("assignment: %s\n", yytext);return '=';  }
[;]				      { SAVE; PRINTF("semicolon: %s\n", yytext); return ';'; }
.				      { }

%%

