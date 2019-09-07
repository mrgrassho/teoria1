# teoria1

### TODO:

Se debe definir:

- [ ] Sentencias
- [ ] Lista_de_Sentencias

- [ ] While/while in
- [ ] If
- [ ] Asignaciones
- [ ]  Tipos de Datos:
  - [ ] Enteros (16 bits)
  - [ ] Double (32 bits)
  - [X] String (30 caracteres de longitud máxima, limitado por comillas simples)
- [ ] Comentarios (“--/” y “/--“)
- [ ] Salida. (DISPLAY “ewr”)
- [ ] Variables.
- [ ] Condicion
  - [ ] Operadores de condición (<, >, =<, =>, ==, and, or)
- [ ] DECLARACIONES
Todas las variables deberán ser declaradas dentro de un bloque especial para ese fin, delimitado por las palabras reservadas DECLARE.SECTION y ENDDECLARE.SECTION, siguiendo el siguiente formato:
```
DECLARE.SECTION
  Línea_de_Declaración_de_Tipos
ENDDECLARE.SECTION
```
- [ ] PROGRAMA
Todas las sentencias del programa deberán ser declaradas dentro de un bloque especial para ese fin, delimitado por las palabras reservadas PROGRAM.SECTION y ENDPROGRAM.SECTION, siguiendo el siguiente formato:
```
PROGRAM.SECTION
  Lista_de_Sentencias
ENDPROGRAM.SECTION
```
- [ ] Ciclo Especial WHILE (Grupo 3)
Este ciclo especial se repetirá mientras Variable=Expresión donde la expresión se encontrará listada en Lista de Expresiones.
Lista de expresiones es una lista de expresiones separadas por comas.
Ejemplo:
```
WHILE (Variable IN [Lista de Expresiones]) DO
…
ENDWHILE
```

### Regex en jflex

http://people.cs.aau.dk/~marius/sw/flex/Flex-Regular-Expressions.html

### Guia para correr el Lexer:

1. Ejecutar desde la terminal `mvn jflex:generate` sobre el directorio `my-app/` o desde la vista GUI de jflex generar el archivo Lexer.java.

2. Si usaste **maven**, copia el archivo a main/java:

`cp target/generated-sources/jflex/Lexer.java src/main/java/`

3. Pararse en la carpeta `main/java` y compilalo:
```
javac Lexer.java
```

4. Para correr las pruebas realizar lo siguiente:

- Pararse en la carpeta `main/java` y ejecutar el siguiente comando:
```
java Lexer ../pruebas/prueba1.txt
```
