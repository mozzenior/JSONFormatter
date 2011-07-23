#include <stdlib.h>
#include <stdio.h>

extern int yyparse (void);


int
yywrap( void )
{
	return 1;
}


int main( int argc, char **argv )
{
	yyparse();
	return 0;
}
