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

  for i := 1 to Tamanho do
  begin
    for j := 1 to Tamanho do
    begin
      writeln('Digite o coeficiente A',i,j);
      readln(Coeficientes[i,j]);
    end;
    writeln('Digite o termo independente B',i);
    readln(TermosIndependentes[i]);
  end;
end;




begin
  LerMatriz;
  MostrarSistema(Coeficientes, TermosIndependentes, Tamanho, Tamanho);
end.
