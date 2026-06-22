import java.io.*;
import erros.ListaErros;

class Main {
    public static void main(String[] args) throws Exception {
        String nomeArquivo = "valido01.mj";
        if (args.length >= 1) {
            nomeArquivo = args[0];
        }

        ListaErros listaErros = new ListaErros();
        FileReader in = new FileReader(nomeArquivo);
        scanner.Scanner scanner = new scanner.Scanner(in, listaErros);
        parser.parser parser = new parser.parser(scanner);
        parser.setListaErros(listaErros);

        try {
            parser.parse();
        } catch (Exception e) {
            // erros já registrados na lista
        }

        if (listaErros.hasErros()) {
            listaErros.dump();
        } else {
            System.out.println("Programa aceito sem erros!");
        }
    }
}
