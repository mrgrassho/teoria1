import java.util.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.Integer;
%%

%class Lexer
%standalone
%unicode
%line
%column
%state COMMENTS_A, COMMENTS_B, DISPLAY
%init{
  try {
    file = new File("../ts.txt");
    bw = new BufferedWriter(new FileWriter(file));
    bw.write("NOMBRE,TOKEN,TIPO,VALOR,LONG");
    bw.newLine();
    bw.flush();
    simbolos = new ArrayList<>();
  } catch (IOException e) {
    e.printStackTrace();
  }
%init}

%{
  BufferedWriter  bw;
  File file;
  ArrayList<String> simbolos;

  public void writeTable(String str) throws IOException{
    if (!simbolos.contains(str.split(",")[0])) {
      bw.write(str);
      bw.newLine();
      bw.flush();
      simbolos.add(str.split(",")[0]);
    }
  }

%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* Comienzan las definiciones de */

String = \"([a-zA-Z0-9\t\f\.\!\¡ñÑ]{0,30})\"
Integer = [1-9][0-9]* | 0
Float = {Integer}\.[0-9]*
Boolean = "true"|"false"
Constante = {String}|{Integer}|{Float}|{Boolean}
Operador= "=="|"!="|">"|"<"|"<="|">="
OperadorLogico= "&&"|"||"

Identificador = [:jletter:][:jletterdigit:]*

/* Funciones */
Display = {String}
Display = {Identificador}
Funcion = {Display}";"

%%

<YYINITIAL> {
  /* Palabras Reservadas*/
  "="                           { System.out.printf("\n>>> Simbolo Asignacion encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  ";"                           { System.out.printf("\n>>> Simbolo Punto y Coma encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  "=="                          { System.out.printf("\n>>> Simbolo Igual encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  "!="                          { System.out.printf("\n>>> Simbolo Distinto encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  ">"                           { System.out.printf("\n>>> Simbolo Mayor encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  "<"                           { System.out.printf("\n>>> Simbolo Meno encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  "<="                          { System.out.printf("\n>>> Simbolo MayorIgual encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  ">="                          { System.out.printf("\n>>> Simbolo MenorIgual  encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  "("                           { System.out.printf("\n>>> Simbolo Parentesis Abre encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  ")"                           { System.out.printf("\n>>> Simbolo Parentesis Cierra encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  "{"                           { System.out.printf("\n>>> Simbolo Llaves Abre encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  "}"                           { System.out.printf("\n>>> Simbolo Llaves Cierra encontrado en linea %d, columna %d\n", yyline, yycolumn);}
  "&&"                          { System.out.printf("\n>>> Simbolo AND: [%s] encontrado en linea %d, columna %d\n",yytext(), yyline, yycolumn);}
  "||"                          { System.out.printf("\n>>> Simbolo OR: [%s] encontrado en linea %d, columna %d\n",yytext() , yyline, yycolumn);}
  "DISPLAY"                     { System.out.printf("\n>>> Funcion encontrada en linea %d, columna %d\n", yyline, yycolumn);yybegin(DISPLAY);}
  "STRING"                      { System.out.printf("\n>>> Funcion encontrada en linea %d, columna %d\n", yyline, yycolumn);yybegin(DISPLAY);}
  "INT"                         { System.out.printf("\n>>> Funcion encontrada en linea %d, columna %d\n", yyline, yycolumn);yybegin(DISPLAY);}
  "FLOAT"                       { System.out.printf("\n>>> Funcion encontrada en linea %d, columna %d\n", yyline, yycolumn);yybegin(DISPLAY);}

  "while"                       { System.out.printf("\n>>> while en linea %d, columna %d\n", yyline, yycolumn); }
  "if"                          { System.out.printf("\n>>> if en linea %d, columna %d\n", yyline, yycolumn); }
  "DECLARE.SECTION"             { System.out.printf("\n>>> DECLARE en linea %d, columna %d\n", yyline, yycolumn); }
  "ENDDECLARE.SECTION"          { System.out.printf("\n>>> ENDDECLARE en linea %d, columna %d\n", yyline, yycolumn); }
  "PROGRAM.SECTION"             { System.out.printf("\n>>> PROGRAM en linea %d, columna %d\n", yyline, yycolumn); }
  "ENDPROGRAM.SECTION"          { System.out.printf("\n>>> ENDPROGRAM en linea %d, columna %d\n", yyline, yycolumn); }

  {String}                      {
                                  System.out.printf("\n>>> String encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                  writeTable("_"+yytext()+",CTE_STR,,"+yytext()+","+yytext().length());
                                }
  {Integer}                     {
                                  if ((Integer.valueOf(yytext()) > -32768) && (Integer.valueOf(yytext()) < 32768)) {
                                    System.out.printf("\n>>> Integer encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                    writeTable("_"+yytext()+",CTE_INT,,"+yytext()+",");
                                  }
                                }
  {Float}                       { /* real de 32 bits : 16 parte entera y 16 parte decimal*/
									int indexDecimal = yytext().indexOf(".");
								    String entero = yytext().substring(0, indexDecimal);
								    String decimal = yytext().substring(indexDecimal+1,yytext().length());
								    	
								  if ( (Integer.valueOf(entero) > -32768) && (Integer.valueOf(entero) < 32768) 
								       && (Integer.valueOf(decimal) > -32768) && (Integer.valueOf(decimal) < 32768) ) {
                                  	System.out.printf("\n>>> Float encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                  	writeTable("_"+yytext()+",CTE_FLOAT,,"+yytext()+",");
                                  }
                                }
  {Boolean}                     {
                                  System.out.printf("\n>>> Bool encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                  writeTable("_"+yytext()+",CTE_BOOL,,"+yytext()+",");

                                }
  {Identificador}               {
                                  System.out.printf("\n>>> Identificador encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                  writeTable("_"+yytext()+",ID,,"+yytext()+",");

                                }

  "--/"                         { yybegin(COMMENTS_A); System.out.printf("\n>>> Empieza comentario A en linea %d, columna %d\n", yyline, yycolumn); }
}

<COMMENTS_A> {LineTerminator} { }
<COMMENTS_A> "--/" { yybegin(COMMENTS_B); System.out.printf("\n>>> Empieza comentario B en linea %d, columna %d\n", yyline, yycolumn); }
<COMMENTS_A> "/--" { yybegin(YYINITIAL); System.out.printf("\n>>> Termina comentario A en linea %d, columna %d\n", yyline, yycolumn); }
<COMMENTS_B> "/--" { yybegin(COMMENTS_A); System.out.printf("\n>>> Termina comentario B en linea %d, columna %d\n", yyline, yycolumn); }

<DISPLAY> {
  {Funcion}         { System.out.printf("\n>>> DISPLAY encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);yybegin(YYINITIAL);}
}
