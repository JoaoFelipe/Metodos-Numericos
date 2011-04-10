program TestExercicio1gauss;

uses TestUnit, TestMatrizUnit, TestReducaoGaussUnit, TestMetodosIterativosUnit;

begin
  StartTests;

  DoAllMatrizTests;
  DoAllReducaoGaussTests;
  DoAllMetodosIterativosTests;

  EndTests;
end.
