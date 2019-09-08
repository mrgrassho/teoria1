%%

%class Lexer
%standalone
%unicode
%line
%column

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* IF */
If = "if("{Condicion}")then "{Lista_de_Sentencias}" else "{Lista_de_Sentencias}
If = "if("{Condicion}")then "{Sentencia}

/* WHILE */
While= "while("{Condicion}")do begin "{Lista_de_Sentencias}"end"
While= "while("{Condicion}")do "{Sentencia}

/* Comienzan las definiciones de */

String = \"[a-zA-Z0-9]{0,30}\"
Integer = [0|[1-9][0-9]*]
Double = {Integer}\.[0-9]*
Boolean = "true"|"false"
Constante = {String}|{Integer}|{Double}|{Boolean}
Operador= "=="|"!="|">"|"<"|"<="|">="
OperadorLogico= "&&"|"||"
Condicion= ({Identificador}|{Constante})(({Operador}|{OperadorLogico})({Identificador}|{Constante}))

Identificador = [:jletter:] [:jletterdigit:]*

/* Operaciones de asignación (SUMA y PRODUCTO) */
AsignacionSimbolo = "="
Expresion = {Expresion}{WhiteSpace}*"+"{WhiteSpace}*{Termino}
Expresion = {Termino}
Termino = {Termino}{WhiteSpace}*"*"{WhiteSpace}*{Factor}
Termino = {Factor}
Factor = {Constante}
Factor = {Identificador}
Asignacion = {Identificador}{WhiteSpace}*{AsignacionSimbolo}{WhiteSpace}*{Expresion}";"

/* Funciones */
Display = "DISPLAY" {String}
Display = "DISPLAY" {Identificador}
Funcion = {Display}";"


/* Definir bien Sentencia */
Lista_de_Sentencias = {Sentencia}|({Sentencia}{LineTerminator}*)+
Sentencia = {Asignacion}|{Funcion}

/* Comentarios */
CommentarioA = "--/"(.|{LineTerminator})*"/--"
CommentarioB = "--/".*{LineTerminator}*{CommentarioA}.*{LineTerminator}*"/--"

%%
<YYINITIAL> {
  {If}                       	   { System.out.printf("\n>>> IF encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {While}                   	   { System.out.printf("\n>>> WHILE encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}

}

<YYINITIAL> {
  /* Constantes*/

  {Sentencia}                    { System.out.printf("\n>>> Sentencia encontrada: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {String}                       { System.out.printf("\n>>> String encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {Integer}                      { System.out.printf("\n>>> Integer encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {Double}                       { System.out.printf("\n>>> Double encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {Boolean}                      { System.out.printf("\n>>> Bool encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {Identificador}                { System.out.printf("\n>>> Identificador encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {AsignacionSimbolo}            { System.out.printf("\n>>> Simbolo Asignacion encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {Operador}                     { System.out.printf("\n>>> Operador encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}
  {CommentarioB}                 { System.out.printf("\n>>> Commentario encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);}

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}
