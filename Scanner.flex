import java.io.*;

%%

%class Scanner
%unicode
%line
%column
%int

%{
  private void token(String tipo, String valor) {
    System.out.println("[" + (yyline + 1) + "," + (yycolumn + 1) + "] " + tipo + ": " + valor);
  }
%}

%xstate COMMENT

digito    = [0-9]
letra     = [a-zA-Z]
hexDigito = [0-9a-fA-F]

%%

<YYINITIAL> {

  /* Palavras reservadas */
  "program"     { token("palavra reservada", yytext()); }
  "break"       { token("palavra reservada", yytext()); }
  "class"       { token("palavra reservada", yytext()); }
  "else"        { token("palavra reservada", yytext()); }
  "final"       { token("palavra reservada", yytext()); }
  "if"          { token("palavra reservada", yytext()); }
  "new"         { token("palavra reservada", yytext()); }
  "print"       { token("palavra reservada", yytext()); }
  "read"        { token("palavra reservada", yytext()); }
  "return"      { token("palavra reservada", yytext()); }
  "void"        { token("palavra reservada", yytext()); }
  "while"       { token("palavra reservada", yytext()); }
  "int"         { token("palavra reservada", yytext()); }
  "char"        { token("palavra reservada", yytext()); }
  "float"       { token("palavra reservada", yytext()); }
  "null"        { token("palavra reservada", yytext()); }

  /* Identificadores */
  {letra}({letra}|{digito}|_)*    { token("identificador", yytext()); }

  /* Números hexadecimais (0x minúsculo + pelo menos 1 hex dígito) */
  "0x"{hexDigito}+                { token("n\u00FAmero hexadecimal", yytext()); }

  /* Números reais (dígitos.dígitos, ambos os lados obrigatórios) */
  {digito}+"."{digito}+           { token("n\u00FAmero real", yytext()); }

  /* Números inteiros */
  {digito}+                       { token("n\u00FAmero inteiro", yytext()); }

  /* Comentario de uma linha */
  "//"[^\r\n]*                    { /* ignorar */ }

  /* Inicio de comentario de multiplas linhas */
  "/*"                            { yybegin(COMMENT); }

  /* Símbolos compostos (devem vir antes dos simples) */
  "=="    { token("s\u00EDmbolo", yytext()); }
  "!="    { token("s\u00EDmbolo", yytext()); }
  "<="    { token("s\u00EDmbolo", yytext()); }
  ">="    { token("s\u00EDmbolo", yytext()); }
  "&&"    { token("s\u00EDmbolo", yytext()); }
  "||"    { token("s\u00EDmbolo", yytext()); }
  "++"    { token("s\u00EDmbolo", yytext()); }
  "--"    { token("s\u00EDmbolo", yytext()); }

  /* Símbolos simples */
  "+"     { token("s\u00EDmbolo", yytext()); }
  "-"     { token("s\u00EDmbolo", yytext()); }
  "*"     { token("s\u00EDmbolo", yytext()); }
  "/"     { token("s\u00EDmbolo", yytext()); }
  "%"     { token("s\u00EDmbolo", yytext()); }
  "="     { token("s\u00EDmbolo", yytext()); }
  "<"     { token("s\u00EDmbolo", yytext()); }
  ">"     { token("s\u00EDmbolo", yytext()); }
  "("     { token("s\u00EDmbolo", yytext()); }
  ")"     { token("s\u00EDmbolo", yytext()); }
  "["     { token("s\u00EDmbolo", yytext()); }
  "]"     { token("s\u00EDmbolo", yytext()); }
  "{"     { token("s\u00EDmbolo", yytext()); }
  "}"     { token("s\u00EDmbolo", yytext()); }
  ";"     { token("s\u00EDmbolo", yytext()); }
  ","     { token("s\u00EDmbolo", yytext()); }
  "."     { token("s\u00EDmbolo", yytext()); }

  /* Espacos em branco */
  [ \t\r\n]+    { /* ignorar */ }

  /* Caractere nao reconhecido */
  .       { token("erro", yytext()); }
}

<COMMENT> {
  "*/"    { yybegin(YYINITIAL); }
  [^*]+   { /* ignorar conteudo do comentario */ }
  "*"     { /* ignorar asterisco que nao faz parte de fim de comentario */ }
  <<EOF>> { token("erro", "comentario nao terminado"); return YYEOF; }
}
