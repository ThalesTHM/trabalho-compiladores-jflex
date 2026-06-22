# build.ps1 — Script de compilação para o projeto MicroJava
# Requer: JFlex.jar e java-cup-11b.jar no PATH ou neste diretório
# Ajuste JFLEX_JAR e CUP_JAR conforme seu ambiente

param(
    [string]$JFlexJar = "jflex.jar",
    [string]$CupJar   = "java-cup-11b.jar"
)

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

Write-Host "=== 1. Gerando Scanner com JFlex ===" -ForegroundColor Cyan
java -jar $JFlexJar --outdir "$root\scanner" "$root\Scanner.flex"
if ($LASTEXITCODE -ne 0) { Write-Error "JFlex falhou"; exit 1 }

Write-Host "=== 2. Gerando Parser com CUP ===" -ForegroundColor Cyan
Push-Location "$root\parser"
java -jar "$root\$CupJar" -package parser -parser parser -symbols sym parser.cup
if ($LASTEXITCODE -ne 0) { Pop-Location; Write-Error "CUP falhou"; exit 1 }
Pop-Location

Write-Host "=== 3. Compilando todos os .java ===" -ForegroundColor Cyan
$cp = ".$([IO.Path]::PathSeparator)$CupJar"
javac -cp $cp `
    "$root\erros\Erro.java" `
    "$root\erros\ListaErros.java" `
    "$root\scanner\Scanner.java" `
    "$root\parser\sym.java" `
    "$root\parser\parser.java" `
    "$root\Main.java"
if ($LASTEXITCODE -ne 0) { Write-Error "javac falhou"; exit 1 }

Write-Host "=== Build OK ===" -ForegroundColor Green
Write-Host ""
Write-Host "Uso: java -cp `".;$CupJar`" Main <arquivo.mj>"
