unit ReducaoGaussUnit;


interface
  uses MatrizUnit;

  function LinhaMultiplicador(matriz: TMatriz; Coluna, Linha, Linhas: integer): integer;
  procedure ReducaoDeGauss(var Matriz: TMatriz; var TermosIndependentes: TVetor; Linhas, Colunas:integer);
  function ResolucaoGauss(Matriz: TMatriz; TermosIndependentes: TVetor; Linhas:integer): TVetor;
  function ResolucaoCompletaGauss(Matriz: TMatriz; TermosIndependentes: TVetor; Linhas, Colunas:integer): TVetor;
  

implementation
  
Uses SysUtils;
 
function LinhaMultiplicador(matriz: TMatriz; Coluna, Linha, Linhas: integer): integer;
var
  i: integer;
  Valor: real;
  PosValor: integer;
begin
  PosValor := Linha;
  Valor := matriz[Linha, Coluna];
  for i := Linha + 1 to Linhas do
    if ABS(valor) < ABS(matriz[i, Coluna]) then
    begin
      Valor := matriz[i, Coluna];
      PosValor := i; 
    end;
  LinhaMultiplicador := PosValor; 
end;

procedure ReducaoDeGauss(var Matriz: TMatriz; var TermosIndependentes: TVetor; Linhas, Colunas:integer);
var i, j, k: integer;
Multiplicador: real;
begin
  for j := 1 to Colunas - 1 do
  begin
    k := LinhaMultiplicador(Matriz, j, j, Linhas);
    Matriz := TrocarLinha(Matriz, j, k, j, Colunas); 
    swap(TermosIndependentes[j], TermosIndependentes[k]);
    for i := j + 1 to Linhas do
    begin
      Multiplicador := Matriz[i, j] / Matriz[j, j];
      Matriz[i, j] := 0;
      Matriz := OperarLinha(Matriz, i, j, Multiplicador, j + 1, Colunas);
      TermosIndependentes[i] := TermosIndependentes[i] - Multiplicador*TermosIndependentes[j];
    end;
  end;  
end;

function ResolucaoGauss(Matriz: TMatriz; TermosIndependentes: TVetor; Linhas:integer): TVetor;
var 
  retorno:TVetor;
  i, j: integer;
  soma :real;
begin
  retorno[Linhas] := TermosIndependentes[Linhas] / Matriz[Linhas, Linhas];
  for i := Linhas - 1 downto 1 do
  begin
    soma := 0;
    for j := i + 1 to Linhas do
      soma := soma + Matriz[i,j]*retorno[j];
    retorno[i] := (TermosIndependentes[i] - soma) / Matriz[i, i];
  end;
  ResolucaoGauss := retorno;
end;


function ResolucaoCompletaGauss(Matriz: TMatriz; TermosIndependentes: TVetor; Linhas, Colunas:integer): TVetor;
begin
  ReducaoDeGauss(Matriz, TermosIndependentes, Linhas, Colunas);
  ResolucaoCompletaGauss := ResolucaoGauss(Matriz, TermosIndependentes, Linhas);
end;

end.
