import java.io.FileReader;
import java.io.FileWriter;

public class Main {

    public static void main(String[] args) throws Exception {
    			if (args.length != 1) throw new Exception("Usage: $java Main filaname");
            parser sintactico= new parser (new Lexer(new FileReader(args[0])));
            sintactico.parse();
        }

}
