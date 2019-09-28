package compiler;
import java.io.FileReader;

public class Main {

    public static void main(String[] args) throws Exception {
            parser sintactico= new parser (new Lexer(new FileReader("../pruebas/prueba1.txt")));
            sintactico.parse();
        }

}
