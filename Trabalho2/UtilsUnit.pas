unit UtilsUnit;

interface
  Type TMatriz = array[1..3, 1..100] of Real;
  Type TVetor = array[1..100] of Real;


  function FloatToString(Numero:Real): String;
  function FloatToSignedString(Numero:Real): String;
  function FloatToSignedString(Numero:Real; Separador:String): String;

  function pot(x: Real; y: Integer): Real;
  function fat(n: Integer): Integer;

  function MatrizEquals(matriz1, matriz2: TMatriz; linhas, colunas: integer): boolean;
  function MatrizNotEquals(matriz1, matriz2: TMatriz; linhas, colunas: integer): boolean;
  function VetorEquals(Vetor1, Vetor2: TVetor; Colunas: integer): boolean;
  function VetorNotEquals(Vetor1, Vetor2: TVetor; Colunas: integer): boolean;  

  procedure MostrarMatriz(matriz: TMatriz; linhas, colunas: integer);
  procedure MostrarTabela(matriz: TMatriz; colunas: integer);
  procedure MostrarVetor(Vetor: TVetor; Colunas: integer);
  function ImprimirVetor(Vetor: TVetor; Colunas: integer):String;

  procedure Mostrar2Matrizes(matriz1, matriz2: TMatriz; linhas, colunas: integer);
  procedure Mostrar2Vetores(vetor1, vetor2: TVetor; Colunas: integer);

  function NovaMatriz(texto: string): TMatriz;
  function NovoVetor(texto: string): TVetor;  

  function TrimVetor(vetor: TVetor; ini: Integer; fim: Integer): TVetor;
  function ExtrairLinha(matriz: TMatriz; Linha, Colunas:Integer): TVetor;


const
  epsilon: real = 0.0001;
var
  FloatFormated: string = '0.0001';

implementation

uses SysUtils;



function FloatToString(Numero:Real): String;
begin
  FloatToString := FormatFloat(FloatFormated, Numero);
end;
 
function FloatToSignedString(Numero:Real): String;
begin
  if Numero < 0 then
    FloatToSignedString := '-' + FloatToString(ABS(Numero))
  else
    FloatToSignedString := '+' + FloatToString(Numero);
end;

function FloatToSignedString(Numero:Real; Separador:String): String;
begin
  if Numero < 0 then
    FloatToSignedString := Separador + '-' + Separador + FloatToString(ABS(Numero))
  else
    FloatToSignedString := Separador + '+' + Separador + FloatToString(Numero);
end;


function pot(x: Real; y: Integer): Real;
begin
  if y = 0 then pot := 1 else pot := x*pot(x, y-1);
end;

function fat(n: Integer): Integer;
begin
  if n = 0 then fat := 1 else fat := n*fat(n-1);
end;


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
        writeln('Posicao (', i, ', ', j, '): ', FloatToString(matriz1[i,j]) , ' != ', FloatToString(matriz2[i,j]) );
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
      writeln('Posicao ', i, ': ', FloatToString(Vetor1[i]) , ' != ', FloatToString(Vetor2[i]) );
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
      temp := temp + FloatToString(matriz[i,j]) + ', ';
    writeln('[', temp, FloatToString(matriz[i,colunas]) , ']');
  end;
end;

procedure MostrarTabela(matriz: TMatriz; colunas: integer);
  function t(texto:string):string;
  var i: Integer; 
  begin
    t := texto;
    for i:= length(texto) to length(FloatFormated)+1 do
      t := t + ' ';
    t := ' '+ t +'|';
  end;
var i, j: integer;
temp, linha: string;
begin
  linha := '--------';

  for i := 1 to colunas do
    for j := 1 to length(t('')) do
      linha := linha + '-';

  writeln(linha);
  temp := '|   x  |';
  for j := 1 to colunas do
    temp := temp + t(FloatToSignedString(matriz[1,j]));
  writeln(temp);
  temp := '| f(x) |';
  for j := 1 to colunas do
    temp := temp + t(FloatToSignedString(matriz[2,j]));
  writeln(temp);
  writeln(linha);
end;

procedure MostrarVetor(Vetor: TVetor; Colunas: integer);
begin
  writeln(ImprimirVetor(vetor, colunas));
end;


function ImprimirVetor(Vetor: TVetor; Colunas: integer):String;
var i: integer;
temp: string;
begin
  temp := '';
  for i := 1 to colunas-1 do
    temp := temp + FloatToString(Vetor[i]) + ', ';
  ImprimirVetor := '[' + temp + FloatToString(Vetor[Colunas]) + ']';
end;


procedure Mostrar2Vetores(vetor1, vetor2: TVetor; Colunas: integer);
begin
  writeln;
  MostrarVetor(vetor1, colunas);
  writeln;
  MostrarVetor(vetor2, colunas);
  writeln;
end;

procedure Mostrar2Matrizes(matriz1, matriz2: TMatriz; linhas, colunas: integer);
begin
  writeln;
  MostrarMatriz(matriz1, linhas, colunas);
  writeln;
  MostrarMatriz(matriz2, linhas, colunas);
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

function TrimVetor(vetor: TVetor; ini: Integer; fim: Integer): TVetor;
var
  resultado: TVetor;
  i, j: Integer;
begin
  j := 1;
  for i:=ini to fim do
  begin
    resultado[j] := vetor[i];
    inc(j);
  end;
  TrimVetor := resultado;
end;

function ExtrairLinha(matriz: TMatriz; Linha, Colunas:Integer): TVetor;
var
  resultado: TVetor;
  i: Integer;
begin
  for i := 1 to Colunas do
    resultado[i] := matriz[Linha, i];
  ExtrairLinha := resultado;
end;



end.
