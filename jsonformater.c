#include <stdlib.h>
#include <stdio.h>



int g_argIdx = 0;
int g_argc = 0;
char **g_argv = NULL;


extern FILE *yyin;
extern int yyparse ( void );

int yywrap( void );


int main( int argc, char **argv )
{
	int yyresult;

	g_argIdx = 0;
	g_argc = argc - 1;
	g_argv = argv + 1;

	if ( g_argc ) {
		yyresult = 0;
		if ( 0 == yywrap() ) {
			do {
				yyresult = yyparse();
			} while ( 0 == yyresult && g_argIdx < g_argc );
		}
	} else {
		yyresult = yyparse();
	}

	return yyresult;
}


int
yywrap( void )
{
	if ( yyin ) {
		fclose( yyin );
		yyin = NULL;
	}

	while ( g_argIdx < g_argc ) {
		yyin = fopen( g_argv[ g_argIdx ], "rt" );
		if ( yyin ) {
			g_argIdx++;
			return 0;
		} else {
			fprintf( stderr, "Can not open file %s.\n", g_argv[ g_argIdx ] );
			g_argIdx++;
		}
	}

	return 1;
}
