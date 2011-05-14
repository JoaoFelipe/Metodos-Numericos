unit TestLagrangeUnit;

interface
  uses UtilsUnit, TestUnit, LagrangeUnit;

  procedure DoAllLagrangeTests;
  procedure TestTermosDeLagrange;
  procedure TestPolinomioDeLagrange;
  
implementation

procedure DoAllLagrangeTests;
begin
  TestCase('Termos de Lagrange', @TestTermosDeLagrange);		  
  TestCase('Polinomio de Lagrange', @TestPolinomioDeLagrange);		  
end;

procedure TestTermosDeLagrange;
var
  matriz: TMatriz;
begin
  FloatFormated := '0';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  InitTest('L0 de [[-1, 0, 2],[4, 1, -1]] deve retornar x(x-2)/3'); 
  Assert(Lagrange(matriz, 0, 3) = 'x(x-2)/3');
  InitTest('L1 de [[-1, 0, 2],[4, 1, -1]] deve retornar -(x+1)(x-2)/2'); 
  Assert(Lagrange(matriz, 1, 3) = '-(x+1)(x-2)/2');
  InitTest('L2 de [[-1, 0, 2],[4, 1, -1]] deve retornar (x+1)x/6'); 
  Assert(Lagrange(matriz, 2, 3) = '(x+1)x/6');
end;

procedure TestPolinomioDeLagrange;
var
  matriz: TMatriz;
begin
  FloatFormated := '0';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  InitTest('P de [[-1, 0, 2],[4, 1, -1]] deve retornar 4x(x-2)/3 - 1(x+1)(x-2)/2 - 1(x+1)x/6'); 
  Assert(PolinomioLagrange(matriz, 3, false) = '4x(x-2)/3 - 1(x+1)(x-2)/2 - 1(x+1)x/6');
end;

//Calcular F(1) = -2/3

end.
