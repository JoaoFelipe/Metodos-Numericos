program Trabalho1;

uses TestUnit, TestMatrizUnit, TestReducaoGaussUnit, TestMetodosIterativosUnit;

begin
  StartTests;

  DoAllMatrizTests;
  DoAllReducaoGaussTests;
  DoAllMetodosIterativosTests;

  EndTests;
end.
