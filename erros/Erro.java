package erros;

public class Erro {
    private int linha;
    private int coluna;
    private String mensagem;

    public Erro(int linha, int coluna, String mensagem) {
        this.linha = linha;
        this.coluna = coluna;
        this.mensagem = mensagem;
    }

    public int getLinha() { return linha; }
    public int getColuna() { return coluna; }
    public String getMensagem() { return mensagem; }

    @Override
    public String toString() {
        return "linha:" + linha + ", coluna:" + coluna + ", " + mensagem;
    }
}
