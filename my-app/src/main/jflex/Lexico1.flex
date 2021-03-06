
import java.util.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.Integer;
import java_cup.runtime.Symbol;

%%

%class Lexer
%cupsym sym
%cup
%unicode
%line
%column
%state DISPLAY
%init{
  try {
    file = new File("../ts.txt");
    bw = new BufferedWriter(new FileWriter(file, true));
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
WhiteSpace     = {LineTerminator} | [ \t\f]

Comentario   = "--/" [^*] ~"/--" | "--/" "/"+ "--"

/* Comienzan las definiciones de */

String = \"([a-zA-Záéíóú0-9 \t\f\.\!\¡ñÑ]{0,30})\"
Integer = [1-9][0-9]* | 0
Float = {Integer}\.[0-9]*
Boolean = "true"|"false"

Identificador = [:jletter:][:jletterdigit:]*

/* Funciones */
Display = {String}
Display = {Identificador}
Funcion = {Display}";"

%%

<YYINITIAL> {
  /* Palabras Reservadas*/
  "="                           { System.out.printf("\n>>> Simbolo Asignacion encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.ASIGNACION, yychar, yyline);}
  ":"                           { System.out.printf("\n>>> Simbolo Dos Puntos encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.DOS_PUNTOS, yychar, yyline);}
  ";"                           { System.out.printf("\n>>> Simbolo Punto y Coma encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.PUNTO_Y_COMA, yychar, yyline);}
  ","                           { System.out.printf("\n>>> Simbolo coma encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.COMA, yychar, yyline);}
  "=="                          { System.out.printf("\n>>> Simbolo Igual encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.IGUAL, yychar, yyline);}
  "!="                          { System.out.printf("\n>>> Simbolo Distinto encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.DISTINTO, yychar, yyline);}
  ">"                           { System.out.printf("\n>>> Simbolo Mayor encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.MAYOR, yychar, yyline);}
  "<"                           { System.out.printf("\n>>> Simbolo Menor encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.MENOR, yychar, yyline);}
  "<="                          { System.out.printf("\n>>> Simbolo MayorIgual encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.MAYOR_IGUAL, yychar, yyline);}
  ">="                          { System.out.printf("\n>>> Simbolo MenorIgual  encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.MENOR_IGUAL, yychar, yyline);}
  "("                           { System.out.printf("\n>>> Simbolo Parentesis Abre encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.PARENTESIS_ABRE, yychar, yyline);}
  ")"                           { System.out.printf("\n>>> Simbolo Parentesis Cierra encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.PARENTESIS_CIERRA, yychar, yyline);}
  "{"                           { System.out.printf("\n>>> Simbolo Llaves Abre encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.LLAVES_ABRE, yychar, yyline);}
  "}"                           { System.out.printf("\n>>> Simbolo Llaves Cierra encontrado en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.LLAVES_CIERRA, yychar, yyline);}
  "&&"                          { System.out.printf("\n>>> Simbolo AND: [%s] encontrado en linea %d, columna %d\n",yytext(), yyline, yycolumn); return new Symbol(sym.AND, yychar, yyline);}
  "||"                          { System.out.printf("\n>>> Simbolo OR: [%s] encontrado en linea %d, columna %d\n",yytext() , yyline, yycolumn); return new Symbol(sym.OR, yychar, yyline);}
  "+"                           { System.out.printf("\n>>> Simbolo Suma: [%s] encontrado en linea %d, columna %d\n",yytext() , yyline, yycolumn);return new Symbol(sym.SUMA, yychar, yyline);}
  "-"                           { System.out.printf("\n>>> Simbolo Resta: [%s] encontrado en linea %d, columna %d\n",yytext() , yyline, yycolumn);return new Symbol(sym.RESTA, yychar, yyline);}
  "/"                           { System.out.printf("\n>>> Simbolo Division: [%s] encontrado en linea %d, columna %d\n",yytext() , yyline, yycolumn);return new Symbol(sym.DIVISION, yychar, yyline);}
  "*"                           { System.out.printf("\n>>> Simbolo Multiplicacion: [%s] encontrado en linea %d, columna %d\n",yytext() , yyline, yycolumn);return new Symbol(sym.MULTIPLICAION, yychar, yyline);}
  "?"                           { System.out.printf("\n>>> Simbolo Signo pregunta de IF Unario: [%s] encontrado en linea %d, columna %d\n",yytext() , yyline, yycolumn);return new Symbol(sym.SIGNO_PREGUNTA, yychar, yyline);}
  "DISPLAY"                     { System.out.printf("\n>>> Funcion encontrada en linea %d, columna %d\n", yyline, yycolumn);yybegin(DISPLAY);return new Symbol(sym.DISPLAY_FUNCTION, yychar, yyline);}
  "STRING"                      { System.out.printf("\n>>> Funcion consta en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.TYPE_STRING, yychar, yyline);}
  "INT"                         { System.out.printf("\n>>> Funcion encontrada en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.TYPE_INTEGER, yychar, yyline);}
  "FLOAT"                       { System.out.printf("\n>>> Funcion encontrada en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.TYPE_FLOAT, yychar, yyline);}
  "BOOL"                        { System.out.printf("\n>>> Funcion encontrada en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.TYPE_BOOL, yychar, yyline);}

  "while"                       { System.out.printf("\n>>> while en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.WHILE, yychar, yyline);}
  "if"                          { System.out.printf("\n>>> if en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.IF, yychar, yyline);}
  "DECLARE.SECTION"             { System.out.printf("\n>>> DECLARE en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.DECLARE_SECTION, yychar, yyline);}
  "ENDDECLARE.SECTION"          { System.out.printf("\n>>> ENDDECLARE en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.ENDDECLARE_SECTION, yychar, yyline);}
  "PROGRAM.SECTION"             { System.out.printf("\n>>> PROGRAM en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.PROGRAM_SECTION, yychar, yyline);}
  "ENDPROGRAM.SECTION"          { System.out.printf("\n>>> ENDPROGRAM en linea %d, columna %d\n", yyline, yycolumn); return new Symbol(sym.ENDPROGRAM_SECTION, yychar, yyline);}

  {String}                      {
                                  System.out.printf("\n>>> String encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                  writeTable("_"+yytext()+",CTE_STR,,"+yytext()+","+yytext().length());
                                  return new Symbol(sym.CONST_STRING, yychar, yyline, new String(yytext()));
                                }
  {Integer}                     {
                                  if ((Integer.valueOf(yytext()) > -32768) && (Integer.valueOf(yytext()) < 32768)) {
                                    System.out.printf("\n>>> Integer encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                    writeTable("_"+yytext()+",CTE_INT,,"+yytext()+",");
                                    return new Symbol(sym.CONST_INTEGER, yychar, yyline, new String(yytext()));
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
                                          return new Symbol(sym.CONST_FLOAT, yychar, yyline, new String(yytext()));
                                  }
                                }
  {Boolean}                     {
                                  System.out.printf("\n>>> Bool encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                  writeTable("_"+yytext()+",CTE_BOOL,,"+yytext()+",");
                                  return new Symbol(sym.CONST_BOOL, yychar, yyline, new String(yytext()));
                                }
  {Identificador}               {
                                  System.out.printf("\n>>> Identificador encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);
                                  return new Symbol(sym.ID, yychar, yyline, new String(yytext()));
                                }

  {WhiteSpace}                  { /* Así ignora los espacios en blanco */ }
  {Comentario}                  { /* Así ignora los comentarios */ }
}

<DISPLAY> {
  {Funcion}         { System.out.printf("\n>>> DISPLAY encontrado: [%s] en linea %d, columna %d\n", yytext(), yyline, yycolumn);yybegin(YYINITIAL);}
}

[^] { throw new Error("Caracter no permitido: <" + yytext() + "> en la linea " + yyline); }
