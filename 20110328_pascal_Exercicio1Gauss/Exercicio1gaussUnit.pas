unit Exercicio1gaussUnit;

interface
  

  Type TMatriz = array[1..100, 1..100] of Real;
  Type TVetor = array[1..100] of Real;

  procedure swap(var x:real; var y:real);

  function NovaMatriz(texto: string): TMatriz;
  function TrocarLinha(matriz: TMatriz; linha1, linha2, inicial, colunas:integer): TMatriz;
  function OperarLinha(matriz: TMatriz; LinhaFinal, LinhaInicial: integer; multiplicador: Real; Inicial, Colunas:integer): TMatriz;
  function LinhaMultiplicador(matriz: TMatriz; Coluna, Linha, Linhas: integer): integer;
  function NovoVetor(texto: string): TVetor;
  procedure ReducaoDeGauss(var Matriz: TMatriz; var Coeficientes: TVetor; Linhas, Colunas:integer);
  function ResolucaoGauss(Matriz: TMatriz; Coeficientes: TVetor; Linhas:integer): TVetor;

implementation
  
Uses SysUtils;
 
procedure swap(var x:real; var y:real);
var
  temp:real;
begin
  temp := x;
  x := y;
  y := temp;
end;

function NovaMatriz(texto: string): TMatriz;
var 
  i,j, x: integer;
  temp: string;
  retorno: TMatriz;
begin
  i := 1; j := 1; temp := '0';
  for x := 1 to length(texto) do
  begin
    case texto[x] of
        '[': begin end;
        ' ': begin end;
        '-': begin
               temp := '-';
             end; 
        ']': begin
               retorno[i,j] := StrToFloat(temp);
               j := 1; 
               temp := '0';
               inc(i);
             end;
        ',': begin
               retorno[i,j] := StrToFloat(temp);
               temp := '0';
               inc(j);
             end; 
        else begin
          temp := temp + texto[x];
        end
    end;
  end; 
  NovaMatriz := retorno;
end;

function TrocarLinha(matriz: TMatriz; linha1, linha2, inicial, colunas:integer): TMatriz;
var
  j: integer;
  retorno : TMatriz;
begin
  retorno := matriz;
  for j := inicial to colunas do
    swap(retorno[linha1, j], retorno[linha2, j]);
  TrocarLinha := retorno;
end; 

function OperarLinha(matriz: TMatriz; LinhaFinal, LinhaInicial: integer; multiplicador: Real; Inicial, Colunas:integer): TMatriz;
var
  j: integer;
  retorno : TMatriz;
begin
  retorno := matriz;
  for j := inicial to Colunas do
    retorno[LinhaFinal, j] := retorno[LinhaFinal, j] - multiplicador*retorno[LinhaInicial, j];
  OperarLinha := retorno;
end; 

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

function NovoVetor(texto: string): TVetor;
var 
  i, x: integer;
  temp: string;
  retorno: TVetor;
begin
  i := 1; temp := '0';
  for x := 1 to length(texto) do
  begin
    case texto[x] of
        '[': begin end;
        ' ': begin end;
        '-': begin
               temp := '-';
             end; 
        ']': begin
               retorno[i] := StrToFloat(temp);
               temp := '0';
             end;
        ',': begin
               retorno[i] := StrToFloat(temp);
               temp := '0';
               inc(i);
             end; 
        else begin
          temp := temp + texto[x];
        end
    end;
  end; 
  NovoVetor := retorno;
end;

procedure ReducaoDeGauss(var Matriz: TMatriz; var Coeficientes: TVetor; Linhas, Colunas:integer);
var i, j, k: integer;
Multiplicador: real;
begin
  for j := 1 to Colunas - 1 do
  begin
    k := LinhaMultiplicador(Matriz, j, j, Linhas);
    Matriz := TrocarLinha(Matriz, j, k, j, Colunas); 
    swap(Coeficientes[j], Coeficientes[k]);
    for i := j + 1 to Linhas do
    begin
      Multiplicador := Matriz[i, j] / Matriz[j, j];
      Matriz[i, j] := 0;
      Matriz := OperarLinha(Matriz, i, j, Multiplicador, j + 1, Colunas);
      Coeficientes[i] := Coeficientes[i] - Multiplicador*Coeficientes[j]
    end;
  end;  
end;

function ResolucaoGauss(Matriz: TMatriz; Coeficientes: TVetor; Linhas:integer): TVetor;
var 
  retorno:TVetor;
  i, j: integer;
  soma :real;
begin
  retorno[Linhas] := Coeficientes[Linhas] / Matriz[Linhas, Linhas];
  for i := Linhas - 1 downto 1 do
  begin
    soma := 0;
    for j := i + 1 to Linhas do
      soma := soma + Matriz[i,j]*retorno[j];
    retorno[i] := (Coeficientes[i] - soma) / Matriz[i, i];
  end;
  ResolucaoGauss := retorno;
end;

end.
