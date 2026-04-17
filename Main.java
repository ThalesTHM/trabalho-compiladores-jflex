import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        if (args.length < 1) {
            System.out.println("Uso: java Main <arquivo>");
            System.exit(1);
        }

        FileReader reader = new FileReader(args[0]);
        Scanner scanner = new Scanner(reader);
        scanner.yylex();
        reader.close();
    }
}
