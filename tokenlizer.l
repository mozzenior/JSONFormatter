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

[ \t\n] ;

. {
	return yytext[ 0 ];
}

%%
