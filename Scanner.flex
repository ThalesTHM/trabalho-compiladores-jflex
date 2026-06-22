package scanner;

import java_cup.runtime.*;
import erros.ListaErros;
import parser.sym;

%%

%class Scanner
%public
%unicode
%line
%column
%cup

%{
  private ListaErros listaErros;

  public Scanner(java.io.Reader in, ListaErros listaErros) {
    this(in);
    this.listaErros = listaErros;
  }

  private Symbol criaSimbolo(int tipo) {
    return new Symbol(tipo, yyline + 1, yycolumn + 1);
  }

  private Symbol criaSimbolo(int tipo, Object valor) {
    return new Symbol(tipo, yyline + 1, yycolumn + 1, valor);
  }

  private void defineErro(String mensagem) {
    if (listaErros != null) {
      listaErros.adicionar(yyline + 1, yycolumn + 1, "Lexico - " + mensagem);
    }
  }
%}

%xstate COMMENT

digito    = [0-9]
letra     = [a-zA-Z]
hexDigito = [0-9a-fA-F]

%%

<YYINITIAL> {

  "program"     { return criaSimbolo(sym.PROGRAM, yytext()); }
  "break"       { return criaSimbolo(sym.BREAK, yytext()); }
  "class"       { return criaSimbolo(sym.CLASS, yytext()); }
  "else"        { return criaSimbolo(sym.ELSE, yytext()); }
  "final"       { return criaSimbolo(sym.FINAL, yytext()); }
  "if"          { return criaSimbolo(sym.IF, yytext()); }
  "new"         { return criaSimbolo(sym.NEW, yytext()); }
  "print"       { return criaSimbolo(sym.PRINT, yytext()); }
  "read"        { return criaSimbolo(sym.READ, yytext()); }
  "return"      { return criaSimbolo(sym.RETURN, yytext()); }
  "void"        { return criaSimbolo(sym.VOID, yytext()); }
  "while"       { return criaSimbolo(sym.WHILE, yytext()); }
  "int"         { return criaSimbolo(sym.INT, yytext()); }
  "char"        { return criaSimbolo(sym.CHAR, yytext()); }
  "float"       { return criaSimbolo(sym.FLOAT, yytext()); }
  "null"        { return criaSimbolo(sym.NULL, yytext()); }

  {letra}({letra}|{digito}|_)*    { return criaSimbolo(sym.IDENT, yytext()); }

  "0x"{hexDigito}+                { return criaSimbolo(sym.NUMBER, Integer.parseInt(yytext().substring(2), 16)); }

  {digito}+"."{digito}+           { return criaSimbolo(sym.FLOATNUM, Float.parseFloat(yytext())); }

  {digito}+                       { return criaSimbolo(sym.NUMBER, Integer.parseInt(yytext())); }

  "//"[^\r\n]*                    { /* ignorar comentario de linha */ }

  "/*"                            { yybegin(COMMENT); }

  "=="    { return criaSimbolo(sym.EQL, yytext()); }
  "!="    { return criaSimbolo(sym.NEQ, yytext()); }
  "<="    { return criaSimbolo(sym.LEQ, yytext()); }
  ">="    { return criaSimbolo(sym.GEQ, yytext()); }
  "&&"    { return criaSimbolo(sym.AND, yytext()); }
  "||"    { return criaSimbolo(sym.OR, yytext()); }
  "++"    { return criaSimbolo(sym.INC, yytext()); }
  "--"    { return criaSimbolo(sym.DEC, yytext()); }

  "+"     { return criaSimbolo(sym.PLUS, yytext()); }
  "-"     { return criaSimbolo(sym.MINUS, yytext()); }
  "*"     { return criaSimbolo(sym.TIMES, yytext()); }
  "/"     { return criaSimbolo(sym.SLASH, yytext()); }
  "%"     { return criaSimbolo(sym.REM, yytext()); }
  "="     { return criaSimbolo(sym.ASSIGN, yytext()); }
  "<"     { return criaSimbolo(sym.LSS, yytext()); }
  ">"     { return criaSimbolo(sym.GTR, yytext()); }
  "("     { return criaSimbolo(sym.LPAR, yytext()); }
  ")"     { return criaSimbolo(sym.RPAR, yytext()); }
  "["     { return criaSimbolo(sym.LBRACK, yytext()); }
  "]"     { return criaSimbolo(sym.RBRACK, yytext()); }
  "{"     { return criaSimbolo(sym.LBRACE, yytext()); }
  "}"     { return criaSimbolo(sym.RBRACE, yytext()); }
  ";"     { return criaSimbolo(sym.SEMI, yytext()); }
  ","     { return criaSimbolo(sym.COMMA, yytext()); }
  "."     { return criaSimbolo(sym.PERIOD, yytext()); }

  [ \t\r\n]+    { /* ignorar espacos */ }

  .       { defineErro("Caractere invalido: '" + yytext() + "'"); }
}

<COMMENT> {
  "*/"    { yybegin(YYINITIAL); }
  [^*]+   { /* ignorar */ }
  "*"     { /* ignorar */ }
  <<EOF>> { defineErro("Comentario nao terminado"); return criaSimbolo(sym.EOF); }
}
