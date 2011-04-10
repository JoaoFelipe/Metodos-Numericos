unit MatrizUnit;

interface
  Type TMatriz = array[1..20, 1..20] of Real;
  Type TVetor = array[1..20] of Real;

  function MatrizEquals(matriz1, matriz2: TMatriz; linhas, colunas: integer): boolean;
  function MatrizNotEquals(matriz1, matriz2: TMatriz; linhas, colunas: integer): boolean;
  function VetorEquals(Vetor1, Vetor2: TVetor; Colunas: integer): boolean;
  function VetorNotEquals(Vetor1, Vetor2: TVetor; Colunas: integer): boolean;  

  procedure MostrarMatriz(matriz: TMatriz; linhas, colunas: integer);
  procedure MostrarVetor(Vetor: TVetor; Colunas: integer);

  procedure Mostrar2Matrizes(matriz1, matriz2: TMatriz; linhas, colunas: integer);
  procedure Mostrar2Vetores(vetor1, vetor2: TVetor; Colunas: integer);

  function NovaMatriz(texto: string): TMatriz;
  function NovoVetor(texto: string): TVetor;  

  procedure swap(var x:real; var y:real);

  function TrocarLinha(matriz: TMatriz; linha1, linha2, inicial, colunas:integer): TMatriz;
  function OperarLinha(matriz: TMatriz; LinhaFinal, LinhaInicial: integer; multiplicador: Real; Inicial, Colunas:integer): TMatriz;

const
  epsilon: real = 0.0001;
  FloatFormated: string = '0.0000';

implementation

uses SysUtils;

function MatrizEquals(matriz1, matriz2: TMatriz; linhas, colunas: integer): boolean;
var i, j: integer;
begin
  MatrizEquals := true;
  for i := 1 to linhas do
    for j := 1 to colunas do
    begin
      
      if ABS(matriz1[i, j] - matriz2[i, j]) > epsilon then
      begin
        MatrizEquals := false;
        Mostrar2Matrizes(matriz1, matriz2, linhas, colunas);
        writeln('Posicao (', i, ', ', j, '): ', FormatFloat(FloatFormated,matriz1[i,j]) , ' != ', FormatFloat('0.00',matriz2[i,j]) );
        exit();
      end;
    end;
end;

function MatrizNotEquals(matriz1, matriz2: TMatriz; linhas, colunas: integer): boolean;
var i, j: integer;
begin
  MatrizNotEquals := false;
  for i := 1 to linhas do
    for j := 1 to colunas do 
      if ABS(matriz1[i, j] - matriz2[i, j]) > epsilon then 
        MatrizNotEquals := true;
end;

function VetorEquals(Vetor1, Vetor2: TVetor; Colunas: integer): boolean;
var i: integer;
begin
  VetorEquals := true;
  for i := 1 to Colunas do
    if ABS(Vetor1[i] - Vetor2[i]) > epsilon then
    begin
      VetorEquals := false;
      Mostrar2Vetores(Vetor1, Vetor2, Colunas);
      writeln('Posicao ', i, ': ', FormatFloat(FloatFormated,Vetor1[i]) , ' != ', FormatFloat('0.00',Vetor2[i]) );
      exit();
    end;
end;

function VetorNotEquals(Vetor1, Vetor2: TVetor; Colunas: integer): boolean;
var i: integer;
begin
  VetorNotEquals := false;
  for i := 1 to Colunas do
    if ABS(Vetor1[i] - Vetor2[i]) > epsilon then
      VetorNotEquals := true;
end;

procedure MostrarMatriz(matriz: TMatriz; linhas, colunas: integer);
var i, j: integer;
temp: string;
begin
  for i := 1 to linhas do
  begin
    temp := '';
    for j := 1 to colunas-1 do
      temp := temp + FormatFloat(FloatFormated,matriz[i,j]) + ', ';
    writeln('[', temp, FormatFloat(FloatFormated,matriz[i,colunas]) , ']');
  end;
end;

procedure MostrarVetor(Vetor: TVetor; Colunas: integer);
var i: integer;
temp: string;
begin
  temp := '';
  for i := 1 to colunas-1 do
    temp := temp + FormatFloat(FloatFormated, Vetor[i]) + ', ';
  writeln('[', temp, FormatFloat(FloatFormated, Vetor[Colunas]) , ']');
end;

procedure Mostrar2Matrizes(matriz1, matriz2: TMatriz; linhas, colunas: integer);
begin
  writeln;
  MostrarMatriz(matriz1, linhas, colunas);
  writeln;
  MostrarMatriz(matriz2, linhas, colunas);
  writeln;
end;

procedure Mostrar2Vetores(vetor1, vetor2: TVetor; Colunas: integer);
begin
  writeln;
  MostrarVetor(vetor1, colunas);
  writeln;
  MostrarVetor(vetor2, colunas);
  writeln;
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

procedure swap(var x:real; var y:real);
var
  temp:real;
begin
  temp := x;
  x := y;
  y := temp;
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




end.
