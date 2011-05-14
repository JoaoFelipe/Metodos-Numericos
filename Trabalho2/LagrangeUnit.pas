unit LagrangeUnit;

interface
  uses UtilsUnit;

  function Lagrange(matriz: TMatriz; Numero, Tamanho: integer): String;
  function PolinomioLagrange(matriz: TMatriz; Tamanho: integer; Passo: Boolean): String;

implementation
  
Uses SysUtils, StrUtils;



function Lagrange(matriz: TMatriz; Numero, Tamanho: integer): String;
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
  if divisor < 0 then
    resultado := '-'+resultado;
  Lagrange := resultado + '/' + FloatToString(ABS(divisor));
end;

function PolinomioLagrange(matriz: TMatriz; Tamanho: integer; Passo: Boolean): String;
var 
  i: Integer;
  mult: Real;
  temp, resultado: String;
begin
  resultado := '';
  for i := 1 to Tamanho do
  begin
    mult := matriz[2, i];
    temp := Lagrange(matriz, i-1, Tamanho);
    if Passo then
      writeln('L',i-1,'(x) = ', temp);
    if temp[1] = '-' then
    begin
      mult := mult*-1;
      temp := RightStr(temp, length(temp)-1);
    end;
    resultado := resultado + FloatToSignedString(mult, ' ') + temp;

  end;
  if Passo then writeln;

  PolinomioLagrange := RightStr(resultado, length(resultado)-3);
end;

end.
