%{
#include "parser.h"
%}

%%

-?((([0-9]+)|([0-9]*\.[0-9]+))([eE][-+]?[0-9]+)?)	{
	yylval.text = yytext;
	return NUMBER;
}

\"[^"]*\" {
	yylval.text = yytext;
	return STRING;
}

"true"|"false" {
	yylval.text = yytext;
	return BOOLEAN;
}

"null" {
	yylval.text = yytext;
	return JSNULL;
}

"{" {
	yylval.text = yytext;
	return OPEN_BRACE;
}

"}" {
	yylval.text = yytext;
	return CLOSE_BRACE;
}

"[" {
	yylval.text = yytext;
	return OPEN_BRACKET;
}

"]" {
	yylval.text = yytext;
	return CLOSE_BRACKET;
}

"," {
	yylval.text = yytext;
	return COMMA;
}

":" {
	yylval.text = yytext;
	return COLON;
}

[ \t\n] ;

. {
	return yytext[ 0 ];
}

%%
