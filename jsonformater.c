#include <stdlib.h>
#include <stdio.h>



int
yywrap( void )
{
	return 1;
}


void
yyerror( const char *msg )
{
	fprintf( stderr, "YYERROR: %s\n", msg );
}


int main( int argc, char **argv )
{
	yyparse();
	return 0;
}
