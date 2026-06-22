package erros;

import java.util.ArrayList;
import java.util.List;

public class ListaErros {
    private List<Erro> erros = new ArrayList<>();

    public void adicionar(int linha, int coluna, String mensagem) {
        erros.add(new Erro(linha, coluna, mensagem));
    }

    public boolean hasErros() {
        return !erros.isEmpty();
    }

    public void dump() {
        for (Erro e : erros) {
            System.out.println(e);
        }
    }

    public List<Erro> getErros() {
        return erros;
    }
}
