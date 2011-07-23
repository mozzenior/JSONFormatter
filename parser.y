%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


unsigned int indent = 0;


extern int yylex( void );
void print_indent( void );
void yyerror( const char * );
%}

%union {
	char *text;
}

%token <text> ROOT
%token <text> OPEN_BRACE
%token <text> CLOSE_BRACE
%token <text> OPEN_BRACKET
%token <text> CLOSE_BRACKET
%token <text> COMMA
%token <text> COLON
%token <text> NUMBER
%token <text> STRING
%token <text> BOOLEAN
%token <text> JSNULL

%{
enum yytokentype prev_token = ROOT;
%}

%%

root:	object
		{
			printf( "\n" );
		}
	|	array
		{
			printf( "\n" );
		}
	;

primitive_types:	object
	|				array
	|				number
	|				string
	|				boolean
	|				jsnull
	;

object:	open_brace object_body close_brace
	|	open_brace close_brace
	;

object_body:	object_body comma object_body_entry
	|			object_body_entry
	;

object_body_entry:	string colon primitive_types
	;

array:	open_bracket array_body close_bracket
	|	open_bracket close_bracket
	;

array_body:	array_body comma array_body_entry
	|		array_body_entry
	;

array_body_entry:	primitive_types
	;

open_brace: OPEN_BRACE
		{
			switch( prev_token ) {
			case OPEN_BRACE:
			case OPEN_BRACKET:
			case COMMA:
				print_indent();
				printf( "{\n" );
				break;
			case ROOT:
			case COLON:
				printf( "{\n" );
				break;
			default:
				break;
			}

			prev_token = OPEN_BRACE;
			indent++;
		}
	;

close_brace: CLOSE_BRACE
		{
			indent--;
			switch( prev_token ) {
			case OPEN_BRACE:
			case OPEN_BRACKET:
				print_indent();
				printf( "}" );
				break;
			case CLOSE_BRACE:
			case CLOSE_BRACKET:
			case NUMBER:
			case STRING:
			case BOOLEAN:
			case JSNULL:
				printf( "\n" );
				print_indent();
				printf( "}" );
				break;
			default:
				break;
			}

			prev_token = CLOSE_BRACE;
		}
	;

open_bracket: OPEN_BRACKET
		{
			switch( prev_token ) {
			case OPEN_BRACE:
			case OPEN_BRACKET:
			case COMMA:
				print_indent();
				printf( "[\n" );
				break;
			case ROOT:
			case COLON:
				printf( "[\n" );
				break;
			default:
				break;
			}

			prev_token = OPEN_BRACKET;
			indent++;
		}
	;

close_bracket: CLOSE_BRACKET
		{
			indent--;

			switch( prev_token ) {
			case OPEN_BRACE:
			case OPEN_BRACKET:
				print_indent();
				printf( "]" );
				break;
			case CLOSE_BRACE:
			case CLOSE_BRACKET:
			case NUMBER:
			case STRING:
			case BOOLEAN:
			case JSNULL:
				printf( "\n" );
				print_indent();
				printf( "]" );
				break;
			default:
				break;
			}

			prev_token = CLOSE_BRACKET;
		}
	;

comma: COMMA
		{
			switch( prev_token ) {
			case CLOSE_BRACE:
			case CLOSE_BRACKET:
			case NUMBER:
			case STRING:
			case BOOLEAN:
			case JSNULL:
				printf( ",\n" );
				break;
			default:
				break;
			}

			prev_token = COMMA;
		}
	;

colon: COLON
		{
			switch( prev_token ) {
			case STRING:
				printf( ": " );
				break;
			default:
				break;
			}

			prev_token = COLON;
		}
	;

number:	NUMBER
		{
			switch( prev_token ) {
			case OPEN_BRACE:
			case OPEN_BRACKET:
			case COMMA:
				print_indent();
				printf( "%s", $1 );
				break;
			case COLON:
				printf( "%s", $1 );
				break;
			default:
				break;
			}

			prev_token = NUMBER;
		}
	;

string: STRING
		{
			switch( prev_token ) {
			case OPEN_BRACE:
			case OPEN_BRACKET:
			case COMMA:
				print_indent();
				printf( "%s", $1 );
				break;
			case COLON:
				printf( "%s", $1 );
				break;
			default:
				break;
			}

			prev_token = STRING;
		}
	;

boolean: BOOLEAN
		{
			switch( prev_token ) {
			case OPEN_BRACE:
			case OPEN_BRACKET:
			case COMMA:
				print_indent();
				printf( "%s", $1 );
				break;
			case COLON:
				printf( "%s", $1 );
				break;
			default:
				break;
			}

			prev_token = BOOLEAN;
		}
	;

jsnull: JSNULL
		{
			switch( prev_token ) {
			case OPEN_BRACE:
			case OPEN_BRACKET:
			case COMMA:
				print_indent();
				printf( "%s", $1 );
				break;
			case COLON:
				printf( "%s", $1 );
				break;
			default:
				break;
			}

			prev_token = JSNULL;
		}
	;

%%

void print_indent( void )
{
	unsigned int i;
	for ( i = 0 ; i < indent ; i++ )
		printf( "    " );
}


void
yyerror( const char *msg )
{
	fprintf( stderr, "YYERROR: %s\n", msg );
}
