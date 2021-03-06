unit TestMetodosIterativosUnit;

interface
  uses MatrizUnit, TestUnit, MetodosIterativosUnit;

  procedure DoAllMetodosIterativosTests;
  procedure TestConvergenciaPorLinhas;
  procedure TestConvergenciaPorColunas;
  procedure TestConvergenciaPorSassenfeld;
  procedure TestConvergencia;
  procedure TestMontarSistema;
  procedure TestGaussSeidel;
  procedure TestJacobi;

implementation

procedure DoAllMetodosIterativosTests;
begin
  TestCase('Convergencia pelo critério de Linhas', @TestConvergenciaPorLinhas);	
  TestCase('Convergencia pelo critério de Colunas', @TestConvergenciaPorColunas);	
  TestCase('Convergencia pelo critério de Sassenfeld', @TestConvergenciaPorSassenfeld);	
  TestCase('Convergencia por Linha e Coluna', @TestConvergencia);
  TestCase('Montar sistesma x(k+1)=F*x(k) + d', @TestMontarSistema);	
  TestCase('Gauss-Seidel', @TestGaussSeidel);	
  TestCase('Jacobi', @TestJacobi);	
end;

procedure TestConvergenciaPorLinhas;
var
  matriz : TMatriz;
begin
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] converge pelo critério de linhas');
  matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  ASSERT(ConvergeCriterioLinhas(matriz, 3, 3, 0.0001));

  InitTest('A matriz [[1, 1, 1][2, 5, 1][2, 4, 9]] NÃO converge pelo critério de linhas');
  matriz := NovaMatriz('[[1, 1, 1][2, 5, 1][2, 4, 9]]');
  ASSERT(ConvergeCriterioLinhas(matriz, 3, 3, 0.0001) = false);

  InitTest('A matriz [[3, 1, 1][2, 3, 2][2, 4, 9]] NÃO converge pelo critério de linhas');
  matriz := NovaMatriz('[[3, 1, 1][2, 3, 2][2, 4, 9]]');
  ASSERT(ConvergeCriterioLinhas(matriz, 3, 3, 0.0001) = false);
end;

procedure TestConvergenciaPorColunas;
var
  matriz : TMatriz;
begin
  InitTest('A matriz [[5, 1, 1][2, 5, 1][2, 3, 9]] converge pelo critério de colunas');
  matriz := NovaMatriz('[[5, 1, 1][2, 5, 1][2, 3, 9]]');
  ASSERT(ConvergeCriterioColunas(matriz, 3, 3, 0.0001));
  
  InitTest('A matriz [[5, 1, 1][3, 5, 1][2, 3, 9]] NÃO converge pelo critério de colunas');
  matriz := NovaMatriz('[[5, 1, 1][3, 5, 1][2, 3, 9]]');
  ASSERT(ConvergeCriterioColunas(matriz, 3, 3, 0.0001) = false);
  
  InitTest('A matriz [[5, 4, 1][2, 5, 1][2, 3, 9]] NÃO converge pelo critério de colunas');
  matriz := NovaMatriz('[[5, 4, 1][2, 5, 1][2, 3, 9]]');
  ASSERT(ConvergeCriterioColunas(matriz, 3, 3, 0.0001) = false);
end;

procedure TestConvergenciaPorSassenfeld;
var
  matriz : TMatriz;
begin
  InitTest('A matriz [[0.5, 0.1, 0.1][0.2, 0.5, 0.1][0.2, 0.3, 0.2]] converge pelo critério de Sassenfeld');
  matriz := NovaMatriz('[[0.5, 0.1, 0.1][0.2, 0.5, 0.1][0.2, 0.3, 0.2]]');
  ASSERT(ConvergeCriterioSassenfeld(matriz, 3, 3, 0.0001));
  
  InitTest('A matriz [[0.5, 2, 0.1][0.2, 0.5, 0.1][0.2, 0.3, 0.2]] NÃO converge pelo critério de Sassenfeld');
  matriz := NovaMatriz('[[0.5, 2, 0.1][0.2, 0.5, 0.1][0.2, 0.3, 0.2]]');
  ASSERT(ConvergeCriterioSassenfeld(matriz, 3, 3, 0.0001) = false);
  
  InitTest('A matriz [[0.5, 0.1, 0.1][0.2, 0.5, 0.1][0.2, 0.3, 2]] NÃO converge pelo critério de Sassenfeld');
  matriz := NovaMatriz('[[0.5, 0.1, 0.1][0.2, 0.5, 0.1][0.2, 0.3, 2]]');
  ASSERT(ConvergeCriterioSassenfeld(matriz, 3, 3, 0.0001) = false);

  InitTest('A matriz [[0.5, 0.1, 0.1][0.2, 0.5, 0.1][0.2, 0.3, 0.9]] NÃO converge pelo critério de Sassenfeld');
  matriz := NovaMatriz('[[0.5, 0.1, 0.1][0.2, 0.5, 0.1][0.2, 0.3, 0.9]]');
  ASSERT(ConvergeCriterioSassenfeld(matriz, 3, 3, 0.0001) = false);
  
  InitTest('A matriz [[0.5, 0.1, 0.1][0.2, 0.5, 0.1][0.2, 0.3, -0.9]] NÃO converge pelo critério de Sassenfeld');
  matriz := NovaMatriz('[[0.5, 0.1, 0.1][0.2, 0.5, 0.1][0.2, 0.3, -0.9]]');
  ASSERT(ConvergeCriterioSassenfeld(matriz, 3, 3, 0.0001) = false);
  
  InitTest('A matriz [[0, -0.25, -0.75][-0.4, 0, -0.2][-0.22222, -0.33333, 0]] NÃO converge pelo critério de Sassenfeld');
  matriz := NovaMatriz('[[0, -0.25, -0.75][-0.4, 0, -0.2][-0.22222, -0.33333, 0]]');
  ASSERT(ConvergeCriterioSassenfeld(matriz, 3, 3, 0.0001) = false);
end;

procedure TestConvergencia;
var
  matriz : TMatriz;
begin
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] converge pelo critério de linhas');
  matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  ASSERT(Converge(matriz, 3, 3, 0.0001));
  
  InitTest('A matriz [[5, 1, 4][2, 5, 1][2, 3, 9]] converge pelo critério de colunas');
  matriz := NovaMatriz('[[5, 1, 4][2, 5, 1][2, 3, 9]]');
  ASSERT(Converge(matriz, 3, 3, 0.0001));

  InitTest('A matriz [[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.4]] NÃO converge (Sassenfeld é feito em F)');
  matriz := NovaMatriz('[[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.4]]');
  ASSERT(Converge(matriz, 3, 3, 0.0001) = false);

  InitTest('A matriz [[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.9]] NÃO converge');
  matriz := NovaMatriz('[[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.9]]');
  ASSERT(Converge(matriz, 3, 3, 0.0001) = false);
end;

procedure TestMontarSistema;
var
  Matriz, FResultado, F : TMatriz;
  Vetor, dResultado, d : TVetor;
begin
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] devem gerar F=[[0, -0.33333, -0.33333][-0.4, 0, -0.2][-0.22222, -0.44444, 0]] e d=[1, 1, 1]');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  FResultado := NovaMatriz('[[0, -0.33333, -0.33333][-0.4, 0, -0.2][-0.22222, -0.44444, 0]]');
  Vetor := NovoVetor('[3, 5, 9]');
  dResultado := NovoVetor('[1, 1, 1]');
  MontarSistema(F, d, Matriz, Vetor, 3, 3);
  ASSERT(MatrizEquals(F, FResultado, 3, 3));
  ASSERT(VetorEquals(d, dResultado, 3));

  InitTest('A matriz [[5, 1, 4][2, 5, 1][2, 3, 9]] com vetor [3, 5, 9] devem gerar F=[[0, -0.2, -0.8][-0.4, 0, -0.2][-0.22222, -0.33333, 0]] e d=[0.6, 1, 1]');
  Matriz := NovaMatriz('[[5, 1, 4][2, 5, 1][2, 3, 9]]');
  FResultado := NovaMatriz('[[0, -0.2, -0.8][-0.4, 0, -0.2][-0.22222, -0.33333, 0]]');
  Vetor := NovoVetor('[3, 5, 9]');
  dResultado := NovoVetor('[0.6, 1, 1]');
  MontarSistema(F, d, Matriz, Vetor, 3, 3);
  ASSERT(MatrizEquals(F, FResultado, 3, 3));
  ASSERT(VetorEquals(d, dResultado, 3));

  InitTest('A matriz [[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.4]] com vetor [1, 1, 1] devem gerar F=[[0, -0.25, -0.75][-0.4, 0, -0.2][-0.5, -0.75, 0]] e d=[2.5, 2, 2.5]');
  Matriz := NovaMatriz('[[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.4]]');
  FResultado := NovaMatriz('[[0, -0.25, -0.75][-0.4, 0, -0.2][-0.5, -0.75, 0]]');
  Vetor := NovoVetor('[1, 1, 1]');
  dResultado := NovoVetor('[2.5, 2, 2.5]');
  MontarSistema(F, d, Matriz, Vetor, 3, 3);
  ASSERT(MatrizEquals(F, FResultado, 3, 3));
  ASSERT(VetorEquals(d, dResultado, 3));

  InitTest('A matriz [[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.9]] com vetor [1, 1, 1] devem gerar F=[[0, -0.25, -0.75][-0.4, 0, -0.2][-0.22222, -0.33333, 0]] e d=[2.5, 2, 1.11111]');
  Matriz := NovaMatriz('[[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.9]]');
  FResultado := NovaMatriz('[[0, -0.25, -0.75][-0.4, 0, -0.2][-0.22222, -0.33333, 0]]');
  Vetor := NovoVetor('[1, 1, 1]');
  dResultado := NovoVetor('[2.5, 2, 1.11111]');
  MontarSistema(F, d, Matriz, Vetor, 3, 3);
  ASSERT(MatrizEquals(F, FResultado, 3, 3));
  ASSERT(VetorEquals(d, dResultado, 3));
end;

procedure TestGaussSeidel;
var
  Matriz : TMatriz;
  Vetor, AproximacaoInicial, x, xResultado : TVetor;
  RetornoGaussSeidel : integer;
begin
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0, 0, 0] com maximo de 0 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0, 0, 0]');
  RetornoGaussSeidel := GaussSeidel(x, AproximacaoInicial, Matriz, Vetor, 0, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoGaussSeidel = 0);

  InitTest('A matriz [[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.9]] com vetor [1, 1, 1] deve retornar -1 por NÃO convergir');
  //F=[[0, -0.25, -0.75][-0.4, 0, -0.2][-0.22222, -0.33333, 0]]
  matriz := NovaMatriz('[[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[1, 1, 1]');
  xResultado := NovoVetor('[0, 0, 0]');
  RetornoGaussSeidel := GaussSeidel(x, AproximacaoInicial, Matriz, Vetor, 0, 3, 3, 0.001);
  ASSERT(RetornoGaussSeidel = -1);

  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[1, 0.6000, 0.5111] com maximo de 1 iteração e retornar 0 por convergir, mas não chegar ao valor proximo');
  //F=[[0, -0.33333, -0.33333][-0.4, 0, -0.2][-0.22222, -0.44444, 0]] e d=[1, 1, 1]
  //x=[0.5904, 0.6476, 0.5809]
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[1, 0.6000, 0.5111]');
  RetornoGaussSeidel := GaussSeidel(x, AproximacaoInicial, Matriz, Vetor, 1, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoGaussSeidel = 0);
  
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.6296, 0.6459, 0.5731] com maximo de 2 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.6296, 0.6459, 0.5731]');
  RetornoGaussSeidel := GaussSeidel(x, AproximacaoInicial, Matriz, Vetor, 2, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoGaussSeidel = 0);
  
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.5937, 0.6479, 0.5801] com maximo de 3 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.5937, 0.6479, 0.5801]');
  RetornoGaussSeidel := GaussSeidel(x, AproximacaoInicial, Matriz, Vetor, 3, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoGaussSeidel = 0);
  
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.5907, 0.6477, 0.5809] com maximo de 4 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.5907, 0.6477, 0.5809]');
  RetornoGaussSeidel := GaussSeidel(x, AproximacaoInicial, Matriz, Vetor, 4, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoGaussSeidel = 0);
  
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.5905, 0.6476, 0.5809] com maximo de 5 iterações e retornar 5 por convergir, e chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.5905, 0.6476, 0.5809]');
  RetornoGaussSeidel := GaussSeidel(x, AproximacaoInicial, Matriz, Vetor, 5, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoGaussSeidel = 5);
  
  //Matriz da Aulta
  InitTest('A matriz [[2, -1][1, 2]] com vetor [1, 3] e aproximação [0, 0, 0] deve gerar x=[1.008, 0.996] com maximo de 10 iterações e retornar 4 por convergir, e chegar ao valor proximo');
  Matriz := NovaMatriz('[[2, -1][1, 2]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[1, 3]');
  xResultado := NovoVetor('[1.0078, 0.9961]');
  RetornoGaussSeidel := GaussSeidel(x, AproximacaoInicial, Matriz, Vetor, 10, 2, 2, 0.1);
  ASSERT(VetorEquals(x, xResultado, 2));
  ASSERT(RetornoGaussSeidel = 4);

end;

procedure TestJacobi;
var
  Matriz : TMatriz;
  Vetor, AproximacaoInicial, x, xResultado : TVetor;
  RetornoJacobi : integer;
begin
  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0, 0, 0] com maximo de 0 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0, 0, 0]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 0, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoJacobi = 0);

  InitTest('A matriz [[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.9]] com vetor [1, 1, 1] deve retornar -1 por NÃO convergir');
  //F=[[0, -0.25, -0.75][-0.4, 0, -0.2][-0.22222, -0.33333, 0]]
  matriz := NovaMatriz('[[0.4, 0.1, 0.3][0.2, 0.5, 0.1][0.2, 0.3, 0.9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[1, 1, 1]');
  xResultado := NovoVetor('[0, 0, 0]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 0, 3, 3, 0.001);
  ASSERT(RetornoJacobi = -1);

  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[1, 1, 1] com maximo de 1 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  //F=[[0, -0.33333, -0.33333][-0.4, 0, -0.2][-0.22222, -0.44444, 0]] e d=[1, 1, 1]
  //x=[0.5904, 0.6476, 0.5809]
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[1, 1, 1]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 1, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoJacobi = 0);

  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.3334, 0.4, 0.3334] com maximo de 2 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.3334, 0.4, 0.3334]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 2, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoJacobi = 0);

  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.7555, 0.7999, 0.7481] com maximo de 3 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.7555, 0.7999, 0.7481]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 3, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoJacobi = 0);

  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.4840, 0.5481, 0.4766] com maximo de 4 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.4840, 0.5481, 0.4766]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 4, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoJacobi = 0);

  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.5899, 0.6471, 0.5804] com maximo de 16 iterações e retornar 0 por convergir, mas não chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.5899, 0.6471, 0.5804]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 16, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoJacobi = 0);

  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.5908, 0.6479, 0.5813] com maximo de 17 iterações e retornar 17 por convergir, e chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.5908, 0.6479, 0.5813]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 17, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoJacobi = 17);

  InitTest('A matriz [[3, 1, 1][2, 5, 1][2, 4, 9]] com vetor [3, 5, 9] e aproximação [0, 0, 0] deve gerar x=[0.5908, 0.6479, 0.5813] com maximo de 18 iterações e retornar 17 por convergir, e chegar ao valor proximo');
  Matriz := NovaMatriz('[[3, 1, 1][2, 5, 1][2, 4, 9]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[3, 5, 9]');
  xResultado := NovoVetor('[0.5908, 0.6479, 0.5813]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 18, 3, 3, 0.001);
  ASSERT(VetorEquals(x, xResultado, 3));
  ASSERT(RetornoJacobi = 17);

  InitTest('A matriz [[2, -1][1, 2]] com vetor [1, 3] e aproximação [0, 0, 0] deve gerar x=[0.969, 1.031] após 10 iterações e retornar 5 por convergir, e chegar ao valor proximo');
  Matriz := NovaMatriz('[[2, -1][1, 2]]');
  AproximacaoInicial := NovoVetor('[0, 0, 0]');
  Vetor := NovoVetor('[1, 3]');
  xResultado := NovoVetor('[0.9688, 1.0313]');
  RetornoJacobi := Jacobi(x, AproximacaoInicial, Matriz, Vetor, 10, 2, 2, 0.1);
  ASSERT(VetorEquals(x, xResultado, 2));
  ASSERT(RetornoJacobi = 5);

end;

end.

