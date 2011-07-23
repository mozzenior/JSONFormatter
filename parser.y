%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


unsigned int indent_count = 0;

%}

%union {
	char *text;
}

%token <text> NUMBER
%token <text> STRING
%token <text> BOOLEAN
%token <text> JSNULL

%type <text> root
%type <text> primitive_types
%type <text> object
%type <text> object_body
%type <text> object_body_entry
%type <text> array
%type <text> array_body
%type <text> array_body_entry
%type <text> number
%type <text> string
%type <text> boolean
%type <text> jsnull

%%

root:	object
		{
			$$ = $1;
			printf( "root: [%s]\n", $$ );
			free( $$ );
			$$ = NULL;
		}
	|	array
		{
			$$ = $1;
			printf( "root: [%s]\n", $$ );
			free( $$ );
			$$ = NULL;
		}
	;

primitive_types:	object
		{
			$$ = $1;
			printf( "primitive: [%s]\n", $$ );
		}
	|				array
		{
			$$ = $1;
			printf( "primitive: [%s]\n", $$ );
		}
	|				number
		{
			$$ = $1;
			printf( "primitive: [%s]\n", $$ );
		}
	|				string
		{
			$$ = $1;
			printf( "primitive: [%s]\n", $$ );
		}
	|				boolean
		{
			$$ = $1;
			printf( "primitive: [%s]\n", $$ );
		}
	|				jsnull
		{
			$$ = $1;
			printf( "primitive: [%s]\n", $$ );
		}
	;

object:	'{' object_body '}'
		{
			unsigned int length = strlen( $2 ) + 3;
			$$ = calloc( sizeof( char ), length );
			sprintf( $$, "{%s}", $2 );
			printf( "Object: [%s]\n", $$ );
		}
	|	'{' '}'
		{
			$$ = strdup( "{}" );
			printf( "Object: [%s]\n", $$ );
		}
	;

object_body:	object_body ',' object_body_entry
		{
			unsigned int length = strlen( $1 ) + strlen( $3 ) + 3;
			$$ = calloc( sizeof( char ), length );
			sprintf( $$, "%s, %s", $1, $3 );
			free( $1 );
			free( $3 );
			printf( "Object body: [%s]\n", $$ );
		}
	|			object_body_entry
		{
			$$ = $1;
			printf( "Object body: [%s]\n", $$ );
		}
	;

object_body_entry:	string ':' primitive_types
		{
			unsigned int length = strlen( $1 ) + strlen( $3 ) + 3;
			$$ = calloc( sizeof( char ), length );
			sprintf( $$, "%s: %s", $1, $3 );
			free( $1 );
			free( $3 );
			printf( "Object body entry: [%s]\n", $$ );
		}
	;

array:	'[' array_body ']'
		{
			unsigned int length = strlen( $2 ) + 3;
			$$ = calloc( sizeof( char ), length );
			sprintf( $$, "[%s]", $2 );
			free( $2 );
			printf( "Array: [%s]\n", $$ );
		}
	|	'[' ']'
		{
			$$ = strdup( "[]" );
			printf( "Array: [%s]\n", $$ );
		}
	;

array_body:	array_body ',' array_body_entry
		{
			unsigned int length = strlen( $1 ) + strlen( $3 ) + 3;
			$$ = calloc( sizeof( char ), length );
			sprintf( $$, "%s, %s", $1, $3 );
			free( $1 );
			free( $3 );
			printf( "Array body: [%s]\n", $$ );
		}
	|		array_body_entry
		{
			$$ = $1;
			printf( "Array body: [%s]\n", $$ );
		}
	;

array_body_entry:	primitive_types
		{
			$$ = $1;
			printf( "Array body entry: [%s]\n", $$ );
		}
	;

number:	NUMBER
		{
			$$ = strdup( $1 );
			printf( "Number: [%s]\n", $$ );
		}
	;

string: STRING
		{
			$$ = strdup( $1 );
			printf( "String: [%s]\n", $$ );
		}
	;

boolean: BOOLEAN
		{
			$$ = strdup( $1 );
			printf( "Boolean: [%s]\n", $$ );
		}
	;

jsnull: JSNULL
		{
			$$ = strdup( $1 );
			printf( "JSNull: [%s]\n", $$ );
		}
	;

%%
