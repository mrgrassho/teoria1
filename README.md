# Teoria de la Computación I - TPs

En el siguiente repositorio se desarrollan los TPs de la materia Teoria de la Computación I.

## Contenido

- Pendiente
- Regex en jflex
- Guia para correr el Lexer:

### Pendiente:

Se debe definir en JAVA CUP:

- [X] Tabla de simbolos con el tipo de Dato para los Identificadores declarados.
- [X] **CORREGIR numeracion de REGLAS**
- [X] **Hacer que JAVA CUP chequee los ids declaradas y te alerte si el valor asignado NO coincide con su tipo.**
- [X] Sentencias
- [X] Lista_de_Sentencias

- [X] While/while in
- [X] If
- [X] Asignaciones
- [X]  Tipos de Datos:
  - [X] Enteros (16 bits)
  - [X] Double (32 bits)
  - [X] String (30 caracteres de longitud máxima, limitado por comillas simples)
- [X] Comentarios (“--/” y “/--“)
- [X] Salida. (DISPLAY “ewr”)
- [X] Variables.
- [X] Condicion
  - [X] Operadores de condición (<, >, =<, =>, ==, and, or)
- [X] **DECLARACIONES de variables**
Todas las variables deberán ser declaradas dentro de un bloque especial para ese fin, delimitado por las palabras reservadas DECLARE.SECTION y ENDDECLARE.SECTION, siguiendo el siguiente formato:
```
DECLARE.SECTION
  Línea_de_Declaración_de_Tipos
ENDDECLARE.SECTION
```
- [X] PROGRAMA
Todas las sentencias del programa deberán ser declaradas dentro de un bloque especial para ese fin, delimitado por las palabras reservadas PROGRAM.SECTION y ENDPROGRAM.SECTION, siguiendo el siguiente formato:
```
PROGRAM.SECTION
  Lista_de_Sentencias
ENDPROGRAM.SECTION
```

- [X] IF Unario (Grupo 2)
Esta instrucción permitirá resolver una condición unaria en una sola línea, devolviendo una expresión, cuyo valor deberá ser asignado a la variable del lado izquierdo. Se realizará la validación de tipo correspondiente.
```
Ejemplo:
Variable:=?(condición, expresión1, expresión2)
a1= ?( alpha > 300, a1+1, a1+2)
/* si se cumple la condición devuelve a1+1 en caso contrario devuelve a1+2 */
```

### Regex en jflex

http://people.cs.aau.dk/~marius/sw/flex/Flex-Regular-Expressions.html

### Nueva Guia para correr el proyecto:

1. Ejecutar desde la terminal `mvn jflex:generate` sobre el directorio `my-app/` o desde la vista GUI de jflex generar el archivo Lexer.java.

2. Si usaste **maven**, copia el archivo a main/java:

`cp target/generated-sources/jflex/Lexer.java src/main/cup/`

*1 y 2 en la misma linea* -> `mvn jflex:generate && cp target/generated-sources/jflex/Lexer.java src/main/java/`

3. Pararse en la carpeta `main/cup` y compilalo:
```
javac Lexer.java
```

4. Ahora vamos a ejecutar el archivo `Sintactico.cup`:
```
java -jar java-cup-11b.jar Sintactico.cup
```

5. Ahora hay que compilar el Main:
```
javac -cp java-cup-11b.jar sym.java parser.java Lexer.java Main.java
```

6. Ejecutar el Main:
```
java -cp java-cup-11b-runtime.jar Main <nombre_archivo_pruebas>
```

ó

6. Abrir el proyecto en Eclipse y ejectuar el Main. Agregar parametro de archivo de pruebas.
