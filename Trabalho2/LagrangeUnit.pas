unit LagrangeUnit;

interface
  uses UtilsUnit;

  type TermoLagrange = record
    texto: string;
    divisor: real;
  end;

  function Lagrange(matriz: TMatriz; Numero, Tamanho: integer): TermoLagrange;
  function PolinomioLagrange(matriz: TMatriz; Tamanho: integer; Passo: Boolean): String;
  function ValorLagrange(matriz: TMatriz; Numero, Tamanho: integer; Valor: Real): Real;
  function ValorPolinomioLagrange(matriz: TMatriz; Tamanho: integer; Valor: Real): Real;



implementation
  
Uses SysUtils, StrUtils;



function Lagrange(matriz: TMatriz; Numero, Tamanho: integer): TermoLagrange;
var
  temp, divisor: Real; 
  i: Integer;
  resultado: String;
begin
  resultado := '';
  divisor := 1;
  for i := 1 to Tamanho do
  begin
    if i <> Numero + 1 then
    begin
      temp := matriz[1, i];
      if temp = 0 then 
        resultado := resultado + 'x'
      else
        resultado := resultado + '(x'+FloatToSignedString(-temp)+')';
      divisor := divisor * (matriz[1, Numero + 1]-temp) 
    end;
  end;
  Lagrange.texto := resultado;
  Lagrange.divisor := divisor;
end;

function PolinomioLagrange(matriz: TMatriz; Tamanho: integer; Passo: Boolean): String;
var 
  i: Integer;
  mult: Real;
  resultado: String;
  termo : TermoLagrange;
begin
  resultado := '';
  for i := 1 to Tamanho do
  begin
    mult := matriz[2, i];
    termo := Lagrange(matriz, i-1, Tamanho);
    if Passo then
      writeln('L',i-1,'(x) = ', termo.texto, '/', FloatToString(termo.divisor));
    resultado := resultado + FloatToSignedString(mult / termo.divisor, ' ') + termo.texto;

  end;
  if Passo then writeln;
  PolinomioLagrange := RightStr(resultado, length(resultado)-3);
end;

function ValorLagrange(matriz: TMatriz; Numero, Tamanho: integer; Valor:real): Real;
var
  temp, divisor: Real; 
  i: Integer;
  resultado: real;
begin
  resultado := 1;
  divisor := 1;
  for i := 1 to Tamanho do
  begin
    if i <> Numero + 1 then
    begin
      temp := matriz[1, i];
      resultado := resultado * (valor - temp);
      divisor := divisor * (matriz[1, Numero + 1]-temp) 
    end;
  end;
  ValorLagrange := resultado/divisor;
end;

function ValorPolinomioLagrange(matriz: TMatriz; Tamanho: integer; Valor: Real): Real;
var 
  i: Integer;
  mult: Real;
  temp, resultado: real;
begin
  resultado := 0;
  for i := 1 to Tamanho do
  begin
    mult := matriz[2, i];
    temp := ValorLagrange(matriz, i-1, Tamanho, valor);
    resultado := resultado + mult*temp;
  end;
  ValorPolinomioLagrange := resultado;
end;

end.
