unit TestLagrangeUnit;

interface
  uses UtilsUnit, TestUnit, LagrangeUnit;

  procedure DoAllLagrangeTests;
  procedure TestTermosDeLagrange;
  procedure TestPolinomioDeLagrange;
  procedure TestLagrangeDeValor;
  procedure TestFuncaoLagrangeDeValor;

implementation

procedure DoAllLagrangeTests;
begin
  TestCase('Termos de Lagrange', @TestTermosDeLagrange);		  
  TestCase('Polinomio de Lagrange', @TestPolinomioDeLagrange);		  
  TestCase('Lagrange de valor', @TestLagrangeDeValor);		  
  TestCase('Função Lagrange de valor', @TestFuncaoLagrangeDeValor);		  
end;

procedure TestTermosDeLagrange;
var
  matriz: TMatriz;
begin
  FloatFormated := '0';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  InitTest('L0 de [[-1, 0, 2],[4, 1, -1]] deve retornar x(x-2)/3'); 
  Assert(Lagrange(matriz, 0, 3).texto = 'x(x-2)');
  Assert(FloatEquals(Lagrange(matriz, 0, 3).divisor, 3));
  InitTest('L1 de [[-1, 0, 2],[4, 1, -1]] deve retornar -(x+1)(x-2)/2'); 
  Assert(Lagrange(matriz, 1, 3).texto = '(x+1)(x-2)');
  Assert(FloatEquals(Lagrange(matriz, 1, 3).divisor, -2));
  InitTest('L2 de [[-1, 0, 2],[4, 1, -1]] deve retornar (x+1)x/6'); 
  Assert(Lagrange(matriz, 2, 3).texto = '(x+1)x');
  Assert(FloatEquals(Lagrange(matriz, 2, 3).divisor, 6));
end;

procedure TestPolinomioDeLagrange;
var
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  InitTest('P de [[-1, 0, 2],[4, 1, -1]] deve retornar 1.333x(x-2.000) - 0.500(x+1.000)(x-2.000) - 0.166(x+1)x'); 
 
  Assert(PolinomioLagrange(matriz, 3, false) = '1.333x(x-2.000) - 0.500(x+1.000)(x-2.000) - 0.167(x+1.000)x');
end;

procedure TestLagrangeDeValor;
var
  matriz: TMatriz;
begin
  FloatFormated := '0';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  InitTest('L0 para x = 1 de [[-1, 0, 2],[4, 1, -1]] deve retornar -1/3'); 
  Assert(FloatEquals(ValorLagrange(matriz, 0, 3, 1), -1/3));
  InitTest('L1 para x = 1 de [[-1, 0, 2],[4, 1, -1]] deve retornar 1)'); 
  Assert(FloatEquals(ValorLagrange(matriz, 1, 3, 1), 1));
  InitTest('L2 para x = 1 de [[-1, 0, 2],[4, 1, -1]] deve retornar 1/3'); 
  Assert(FloatEquals(ValorLagrange(matriz, 2, 3, 1), 1/3));
end;

procedure TestFuncaoLagrangeDeValor;
var
  matriz: TMatriz;
begin
  FloatFormated := '0';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  InitTest('F(1) da interpolação [[-1, 0, 2],[4, 1, -1]] deve retornar -2/3'); 
  Assert(FloatEquals(ValorPolinomioLagrange(matriz, 3, 1), -2/3));
end;

end.
