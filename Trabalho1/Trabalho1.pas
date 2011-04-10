program Trabalho1;

uses TestUnit, MatrizUnit, TestReducaoGaussUnit, TestMetodosIterativosUnit;

var
  Tamanho : integer;
  Valor : real;
  Coeficientes, CoeficientesTemp : TMatriz;
  TermosIndependentes, TermosIndependentesTemp : TVetor;

procedure LerMatriz;
var i, j: integer;
begin
  writeln('Digite o numero de incognitas');
  readln(Tamanho);

  for i := 1 to tamanho do
  begin
    for j := 1 to tamanho do
    begin
      writeln('Digite o coeficiente A',i,j);
      readln(Coeficientes[i,j]);
    end;
  end;

end;

begin
  LerMatriz;
  MostrarMatriz(Coeficientes, tamanho, tamanho);
end.
