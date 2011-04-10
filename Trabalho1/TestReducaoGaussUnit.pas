unit TestReducaoGaussUnit;

interface
  uses MatrizUnit, TestUnit, ReducaoGaussUnit;

  procedure DoAllReducaoGaussTests;
  procedure TestReducaoDeGauss;
  procedure TestResolucaoGauss;
  procedure TestResolucaoCompletaGauss;
  procedure TestMultiplicador;

implementation

procedure DoAllReducaoGaussTests;
begin
  TestCase('Multiplicador', @TestMultiplicador);	
  TestCase('Reducao de Gauss', @TestReducaoDeGauss);	
  TestCase('Resolucao Gauss', @TestResolucaoGauss);	
  TestCase('Resolucao Completa Por Gauss', @TestResolucaoCompletaGauss);	
end;

procedure TestMultiplicador;
var
  Matriz: TMatriz;
begin
  InitTest('Buscar Linha do Maior Multiplicador na Matriz [[1, 2, 3][7, 5, 4][6, -8, 9]] deve retornar 2 na coluna 1');
  Matriz := NovaMatriz('[[1, 2, 3][7, 5, 4][6, -8, 9]]');
  Assert(LinhaMultiplicador(Matriz, 1, 1, 3) = 2);

  InitTest('Buscar Linha do Maior Multiplicador na Matriz [[1, 9, 3][0, 5, 4][0, -8, 9]] deve retornar 3 na coluna 2');
  Matriz := NovaMatriz('[[1, 9, 3][0, 5, 4][0, -8, 9]]');
  Assert(LinhaMultiplicador(Matriz, 2, 2, 3) = 3);

  InitTest('Buscar Linha do Maior Multiplicador na Matriz [[1, 9, 3][0, -8, 4][0, 0, 9]] deve retornar 3 na coluna 3');
  Matriz := NovaMatriz('[[1, 9, 3][0, -8, 4][0, 0, 9]]');
  Assert(LinhaMultiplicador(Matriz, 3, 3, 3) = 3);
end;


procedure TestReducaoDeGauss;
var
  Matriz, MatrizResultado: TMatriz;
  Coeficientes, CoeficientesResultado: TVetor;
begin
  InitTest('Redução de Gauss Da Matriz [3, -5, 3][-8, 8, 1][4, -8, 4] com coeficientes [-8, -4, 9] deve alterar a matriz para [[-8, 8, 1][0, -4, 4.5][0, 0, 1.125]] e coeficientes [-4, 7, -13]');
  Matriz := NovaMatriz('[[3, -5, 3][-8, 8, 1][4, -8, 4]]');
  MatrizResultado := NovaMatriz('[[-8, 8, 1][0, -4, 4.5][0, 0, 1.125]]');
  Coeficientes := NovoVetor('[-8, -4, 9]');
  CoeficientesResultado := NovoVetor('[-4, 7, -13]');
  ReducaoDeGauss(Matriz, Coeficientes, 3, 3);
  Assert(VetorEquals(Coeficientes, CoeficientesResultado, 3));
  Assert(MatrizEquals(Matriz, MatrizResultado, 3, 3));

  InitTest('Redução de Gauss Da Matriz [[5, 2, 1][3, 1, 4][1, 1, 3]] com coeficientes [0, -7, 5] deve alterar a matriz para [[5, 2, 1][0, 0.6, 2.8][0, 0, 4.3333333]] e coeficientes [0, 5, -5.333333]');
  Matriz := NovaMatriz('[[5, 2, 1][3, 1, 4][1, 1, 3]]');
  MatrizResultado := NovaMatriz('[[5, 2, 1][0, 0.6, 2.8][0, 0, 4.3333333]]');
  Coeficientes := NovoVetor('[0, -7, 5]');
  CoeficientesResultado := NovoVetor('[0, 5, -5.333333]');
  ReducaoDeGauss(Matriz, Coeficientes, 3, 3);
  Assert(VetorEquals(Coeficientes, CoeficientesResultado, 3));
  Assert(MatrizEquals(Matriz, MatrizResultado, 3, 3));

end;


procedure TestResolucaoGauss;
var
  Matriz: TMatriz;
  Coeficientes, Resultado, ResultadoEsperado: TVetor;
begin
  InitTest('Resolução de [[-8, 8, 1][0, -4, 4.5][0, 0, 1.125]] com coeficientes [-4, 7, -13] deve retornar [-15.69, -14.75, -11.56]');
  Matriz := NovaMatriz('[[-8, 8, 1][0, -4, 4.5][0, 0, 1.125]]');
  Coeficientes:= NovoVetor('[-4, 7, -13]');
  Resultado := NovoVetor('[-15.694444, -14.75, -11.55555]');  
  Assert(VetorEquals(ResolucaoGauss(Matriz, Coeficientes, 3), Resultado, 3));

  InitTest('Resolução de [[3, 2, 4][0, 0.333333, 2.8][0, 0, 4.3333333]] com coeficientes [0, 5, -5.333333] deve retornar [-3, 5, 0]');
  Matriz := NovaMatriz('[[3, 2, 4][0, 0.333333, 0.666666][0, 0, -8]]');
  Coeficientes := NovoVetor('[1, 1.666666, 0]');
  Resultado := NovoVetor('[-3, 5, 0]');  
  Assert(VetorEquals(ResolucaoGauss(Matriz, Coeficientes, 3), Resultado, 3));
end;


procedure TestResolucaoCompletaGauss;
var
  Matriz: TMatriz;
  Coeficientes, Resultado, ResultadoEsperado: TVetor;
begin
  InitTest('Resolução de [[-8, 8, 1][0, -4, 4.5][0, 0, 1.125]] com coeficientes [-4, 7, -13] deve retornar [-15.69, -14.75, -11.56]');
  Matriz := NovaMatriz('[[3, -5, 3][-8, 8, 1][4, -8, 4]]');
  Coeficientes := NovoVetor('[-8, -4, 9]');
  Resultado := NovoVetor('[-15.694444, -14.75, -11.55555]');  
  Assert(VetorEquals(ResolucaoCompletaGauss(Matriz, Coeficientes, 3, 3), Resultado, 3));

  InitTest('Resolução de [[3, 2, 4][0, 0.333333, 2.8][0, 0, 4.3333333]] com coeficientes [0, 5, -5.333333] deve retornar [-3, 5, 0]');
  Matriz := NovaMatriz('[[5, 2, 1][3, 1, 4][1, 1, 3]]');
  Coeficientes := NovoVetor('[0, -7, 5]');
  ReducaoDeGauss(Matriz, Coeficientes, 3, 3);
  Resultado := NovoVetor('[-5.38462, 14.07692, -1.23077]'); 
  Assert(VetorEquals(ResolucaoCompletaGauss(Matriz, Coeficientes, 3, 3), Resultado, 3)); 
end;

end.
