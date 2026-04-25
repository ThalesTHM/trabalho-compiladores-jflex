import java_cup.runtime.Symbol;

%%

%class Scanner
%unicode
%cup
%line
%column
%public

%{
    public Scanner(java.io.InputStream in) {
        this(new java.io.InputStreamReader(in, java.nio.charset.Charset.forName("UTF-8")));
    }
%}

digito    = [0-9]
letra     = [a-zA-Z]
inteiro   = 0 | [1-9][0-9]*

fimdeLinha = \r|\n|\r\n
espaco     = {fimdeLinha} | [ \t\f]
opMais     = "+"

%%

{inteiro} {
    double aux = Double.parseDouble(yytext());
    return new Symbol(sym.INTEIRO, new Double(aux));
}

{opMais} { return new Symbol(sym.MAIS); }

"-" { return new Symbol(sym.MENOS); }
"/" { return new Symbol(sym.DIV);   }
"*" { return new Symbol(sym.MULT);  }
"%" { return new Symbol(sym.MOD);   }
";" { return new Symbol(sym.PTVIRG);}
"(" { return new Symbol(sym.ABRE);  }
")" { return new Symbol(sym.FECHA); }

{espaco} { /* despreza */ }

.|\n {
    return new Symbol(sym.EOF, yyline, yycolumn, yytext());
}
