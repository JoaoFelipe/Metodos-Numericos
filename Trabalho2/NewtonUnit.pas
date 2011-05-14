unit NewtonUnit;

interface
  uses UtilsUnit;


  function ExtrairVetor(matriz:TMatriz; ordem:Integer):TVetor;

  function RTrim(vetor: TVetor; ordem: Integer):TVetor;
  function LTrim(vetor: TVetor; ordem: Integer):TVetor;
  
  function funcao(matriz: TMatriz; x: Real; Tamanho: Integer): Real;

  function PossivelNG(matriz: TMatriz; Tamanho: integer): Boolean;

  function DiferencaDividida(matriz: TMatriz; vetor: TVetor; Ordem, Tamanho: integer): Real;
  function DiferencaFinita(matriz: TMatriz; x, ordem, Tamanho: integer): Real;
  function DiferencaDivididaNG(matriz: TMatriz; ordem, Tamanho: integer): Real;

  function TermoNewton(matriz: TMatriz; ordem: Integer):String;

  function PolinomioNewton(matriz: TMatriz; ordem, Tamanho: Integer; Tipo:String; Passo:Boolean):String;

  procedure ImprimirTabela(matriz: TMatriz; ordem, Tamanho:Integer; Tipo:String);

implementation
  
Uses SysUtils, StrUtils;


function ExtrairVetor(matriz:TMatriz; ordem:Integer):TVetor;
begin
  ExtrairVetor := ExtrairLinha(matriz, 1, ordem+1);
end;

function RTrim(vetor: TVetor; ordem: Integer):TVetor;
begin
  RTrim := TrimVetor(vetor, 2, ordem+1);
end;

function LTrim(vetor: TVetor; ordem: Integer):TVetor;
begin
  LTrim := TrimVetor(vetor, 1, ordem);
end;

function funcao(matriz: TMatriz; x: Real; Tamanho: integer): Real;
var 
  i: Integer;
begin
  for i := 1 to Tamanho do 
  begin
    if matriz[1, i] = x then
      funcao := matriz[2, i];
  end;
end;


function PossivelNG(matriz: TMatriz; Tamanho: integer): Boolean;
var i : integer;
resultado : boolean;
begin
  resultado := True;
  for i := 1 to Tamanho-2 do
    resultado := resultado and (matriz[1,i]-matriz[1,i+1] = matriz[1,i+1]-matriz[1,i+2]);
  PossivelNG := resultado;
end;



function DiferencaDividida(matriz: TMatriz; vetor: TVetor; Ordem, Tamanho: integer): Real;
begin
  if Ordem = 0 then
    DiferencaDividida := funcao(matriz, vetor[1], Tamanho)
  else
    DiferencaDividida := (DiferencaDividida(matriz, RTrim(vetor, ordem), ordem - 1, Tamanho) - DiferencaDividida(matriz, LTrim(vetor, ordem), ordem - 1, Tamanho))/(vetor[ordem+1]-vetor[1]); 
end;

function DiferencaFinita(matriz: TMatriz; x, ordem, Tamanho: integer): Real;
begin
  if ordem = 0 then
    DiferencaFinita := matriz[2, x+1]
  else
    DiferencaFinita := DiferencaFinita(matriz, x + 1, ordem - 1, Tamanho) - DiferencaFinita(matriz, x, ordem - 1, Tamanho);
end;

function DiferencaDivididaNG(matriz: TMatriz; ordem, Tamanho: integer): Real;
var h:real;
begin
  h := ABS(matriz[1,1]-matriz[1,2]);
  DiferencaDivididaNG := DiferencaFinita(matriz, 0, ordem, Tamanho)/(pot(h, ordem)*fat(ordem));
end;

function TermoNewton(matriz: TMatriz; ordem: Integer):String;
var
  temp: Real; 
  i: Integer;
  resultado: String;
begin
  resultado := '';
  if ordem <> 0 then
  begin
    for i := 1 to ordem do
    begin
      temp := matriz[1, i];
      if temp = 0 then 
        resultado := resultado + 'x'
      else
        resultado := resultado + '(x'+FloatToSignedString(-temp)+')';
    end;
  end;
  TermoNewton := resultado;
end;

function PolinomioNewton(matriz: TMatriz; ordem, Tamanho: Integer; Tipo:String; Passo: Boolean):String;
var
  i: Integer;
  resultado: String;
  vetorX: TVetor;
  temp : real;
begin
  if ordem = -1 then ordem := Tamanho - 1;
  resultado := '';
  if Passo then
  begin
    if Tipo = 'Newton' then 
      ImprimirTabela(matriz, ordem, Tamanho, 'Diferencas Divididas')
    else
      ImprimirTabela(matriz, ordem, Tamanho, 'Diferencas Finitas')
  end;

  for i := 0 to ordem do
  begin
    vetorX := ExtrairVetor(matriz, i);
    if Tipo = 'Newton' then 
      temp := DiferencaDividida(matriz, vetorX, i, Tamanho)
    else
      temp := DiferencaDivididaNG(matriz, i, Tamanho);
    if Passo then
      writeln('f',ImprimirVetor(vetorX, i+1),' = ', FloatToString(temp));
    if i <> 0 then
      resultado := resultado + FloatToSignedString(temp, ' ')+TermoNewton(matriz, i)
    else      
      resultado := resultado + FloatToString(temp)+TermoNewton(matriz, i);
  end;
  PolinomioNewton:= resultado;
  if passo then writeln;
end;




procedure ImprimirTabela(matriz: TMatriz; ordem, Tamanho:Integer; Tipo:String);
  function ColunaMaxima(i:Integer):Integer; 
  begin
    if i <= ordem then 
      ColunaMaxima := i 
    else 
      ColunaMaxima := 2*ordem - i;
  end;
 
  function t(texto:string):string;
  var i: Integer; 
  begin
    t := texto;
    for i:= length(texto) to length(FloatFormated)+1 do
      t := t + ' ';
    t := ' '+ t +'|';
  end;

  function X0(i, j: Integer):Integer; 
  begin
    X0 := (i - j) div 2;
  end;

  function Xn(i, j: Integer):Integer; 
  begin
    Xn := (i + j) div 2;
  end;
  
  function RangeX(i, j: Integer): TVetor; 
  begin
    RangeX := TrimVetor(ExtrairVetor(matriz, i), X0(i,j) + 1, Xn(i,j) + 1);
  end; 

  function Diferenca(i, j: Integer): String;
  begin
    if j mod 2 = i mod 2 then
      if Tipo = 'Diferencas Divididas' then
        Diferenca:= t(FloatToSignedString(DiferencaDividida(matriz, RangeX(i, j), j, Tamanho)))
      else
        Diferenca:= t(FloatToSignedString(DiferencaFinita(matriz, X0(i,j), j, Tamanho)))
    else 
      Diferenca :=  t('')
  end;

  function X(i:Integer): String;
  begin
    if (i mod 2 = 0) then
      X := t(FloatToSignedString(matriz[1, i div 2 + 1]))
    else
      X := t('');
  end; 

var 
temp, linha, vazio:string;
i, j, k: Integer;
vetorX: TVetor;
begin

  vazio := t('');
  
  writeln('Tabela de ', Tipo);

  linha := '';
  for i := 0 to ordem+1 do
    for j:= 1 to length(vazio) do
      linha := linha + '-';
  linha := linha + '-';
  
  temp := '|' + t('x');
  for i := 0 to ordem do
    if Tipo = 'Diferencas Divididas' then
      temp := temp + t('O ' + inttostr(i))
    else
      temp := temp + t('D' + inttostr(i) + 'f') ;

  writeln(linha);  //-----------------------
  writeln(temp);   //| x | O 0 | 0 1 | 0 2 |
  writeln(linha);  //-----------------------

  for i := 0 to ordem*2 do
  begin
    temp := '|';
    temp := temp + X(i);

    for j := 0 to ColunaMaxima(i) do
      temp := temp + Diferenca(i, j);

    for j := j+1 to ordem do
      temp := temp + vazio;

    writeln(temp); //| xn | f[xn] |      | f[xn..xn+2]
  end;
  
  writeln(linha);  //-----------------------

  writeln;
end;

end.
