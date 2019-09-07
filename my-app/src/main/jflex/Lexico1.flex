%%

%class Lexer
%standalone
%unicode
%line
%column

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* Comienzan las definiciones de */

String = \"[a-zA-Z0-9]{30}\"
Integer = [0|[1-9][0-9]*]
Double = {integer}\.[0-9]*
Constant = {String}|{Boolean}|{Integer}|{Double}
Operator= ==|!=|>|<|<=|>=
OperadorLogico= and|or
Condition= ({Identifier}|{Constant})(({Operator}|{OperadorLogico})({Identifier}|{Constant}))

Identifier = [:jletter:] [:jletterdigit:]*


%%

<YYINITIAL> {
  /* Constantes*/

  {String}                       { System.out.printf("[+] String encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {String}                       { System.out.printf("[+] String encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}
