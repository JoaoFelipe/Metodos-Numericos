program TestExercicio1gauss;

uses TestUnit, Exercicio1gaussUnit, SysUtils;



function MatrizEquals(matriz1, matriz2: TMatriz; linhas, colunas: integer): boolean;
var i, j: integer;
begin
  MatrizEquals := true;
  for i := 1 to linhas do
    for j := 1 to colunas do
    begin
      
      if ABS(matriz1[i, j] - matriz2[i, j]) > 0.0001 then
      begin
        MatrizEquals := false;
        MostrarMatriz(matriz1, linhas, colunas); writeln;
        MostrarMatriz(matriz2, linhas, colunas); writeln;
        writeln('Posicao (', i, ', ', j, '): ', FormatFloat('0.00',matriz1[i,j]) , ' != ', FormatFloat('0.00',matriz2[i,j]) );
        exit();
      end;
    end;
end;


function VetorEquals(Vetor1, Vetor2: TVetor; Colunas: integer): boolean;
var i: integer;
begin
  VetorEquals := true;
  for i := 1 to Colunas do
    if ABS(Vetor1[i] - Vetor2[i]) > 0.0001 then
    begin
      VetorEquals := false;
      MostrarVetor(Vetor1, Colunas); writeln;
      MostrarVetor(Vetor2, Colunas); writeln;
      writeln('Posicao ', i, ': ', FormatFloat('0.00',Vetor1[i]) , ' != ', FormatFloat('0.00',Vetor2[i]) );
      exit();
    end;
end;


procedure TestCompararMatrizes;
var
  matriz1, matriz2: TMatriz;
begin
  matriz1[1, 1] := 1; matriz1[1, 2] := 2; matriz1[1, 3] := 3;
  matriz1[2, 1] := 4; matriz1[2, 2] := 5; matriz1[2, 3] := 6;
  matriz2[1, 1] := 1; matriz2[1, 2] := 2; matriz2[1, 3] := 3;
  matriz2[2, 1] := 4; matriz2[2, 2] := 5; matriz2[2, 3] := 6;
  InitTest('A matriz [[1, 2, 3],[4, 5, 6]] deve ser igual a uma matriz identica'); 
  Assert(MatrizEquals(matriz1, matriz2, 2, 3));

  InitTest('A matriz [[1, 2, 3],[4, 5, 6]] deve ser igual a ela mesma'); 
  Assert(MatrizEquals(matriz1, matriz1, 2, 3));

  InitTest('A matriz [[1, 2, 3],[4, 5, 6]] NÃO deve ser igual a matriz [[1, 2, 3],[4, 5, 7]]'); 
  matriz2[2, 3] := 7;
  Assert(not MatrizEquals(matriz1, matriz2, 2, 3));
end;

procedure TestInstanciarMatrizPorTexto;
var
  Matriz, MatrizResultado: TMatriz;
begin
  MatrizResultado[1, 1] := 1; MatrizResultado[1, 2] := 2; MatrizResultado[1, 3] := 3;
  MatrizResultado[2, 1] := 4; MatrizResultado[2, 2] := 5; MatrizResultado[2, 3] := 6;
  InitTest('A matriz [[1, 2, 3][4, 5, 6]] deve ser criada');
  Matriz := NovaMatriz('[[1, 2, 3][4, 5, 6]]');
  Assert(MatrizEquals(Matriz, MatrizResultado, 2, 3));  

  InitTest('A matriz [[1, 2, 3][4, 5, 6][7, 8, 9]] deve ser criada');
  MatrizResultado[3, 1] := 7; MatrizResultado[3, 2] := 8; MatrizResultado[3, 3] := 9;
  Matriz := NovaMatriz('[[1, 2, 3][4, 5, 6][7, 8, 9]]');
  Assert(MatrizEquals(Matriz, MatrizResultado, 3, 3)); 
end;

procedure TestOperacoes;
var
  Matriz, MatrizResultado: TMatriz;
begin
  Matriz := NovaMatriz('[[1, 2, 3][4, 5, 6][7, 8, 9]]');

  InitTest('Trocar linha 1 por 2 da matriz');
  MatrizResultado := NovaMatriz('[[4, 5, 6][1, 2, 3][7, 8, 9]]');
  Assert(MatrizEquals(TrocarLinha(Matriz, 1, 2, 1, 3), MatrizResultado, 3, 3));

  InitTest('Trocar linha 1 por 3 da matriz');
  MatrizResultado := NovaMatriz('[[7, 8, 9][4, 5, 6][1, 2, 3]]');
  Assert(MatrizEquals(TrocarLinha(Matriz, 1, 3, 1, 3), MatrizResultado, 3, 3));

  InitTest('Trocar linha 2 por 3 da matriz');
  MatrizResultado := NovaMatriz('[[1, 2, 3][7, 8, 9][4, 5, 6]]');
  Assert(MatrizEquals(TrocarLinha(Matriz, 2, 3, 1, 3), MatrizResultado, 3, 3));

  InitTest('Somar Linha 1 a Linha 2, multiplicado por 1');
  MatrizResultado := NovaMatriz('[[1, 2, 3][5, 7, 9][7, 8, 9]]');
  Assert(MatrizEquals(OperarLinha(Matriz, 2, 1, -1, 1, 3), MatrizResultado, 3, 3));

  InitTest('Somar Linha 1 a Linha 2, multiplicado por -4');
  MatrizResultado := NovaMatriz('[[1, 2, 3][0, -3, -6][7, 8, 9]]');
  Assert(MatrizEquals(OperarLinha(Matriz, 2, 1, 4, 1, 3), MatrizResultado, 3, 3));

  InitTest('Somar Linha 1 a Linha 3, multiplicado por -7 a partir do resultado anterior');
  Matriz := MatrizResultado;
  MatrizResultado := NovaMatriz('[[1, 2, 3][0, -3, -6][0, -6, -12]]');
  Assert(MatrizEquals(OperarLinha(Matriz, 3, 1, 7, 1, 3), MatrizResultado, 3, 3));

  InitTest('Somar Linha 2 a Linha 3, multiplicado por -2 a partir do resultado anterior, comecando da coluna 2');
  Matriz := MatrizResultado;
  MatrizResultado := NovaMatriz('[[1, 2, 3][0, -3, -6][0, 0, 0]]');
  Assert(MatrizEquals(OperarLinha(Matriz, 3, 2, 2, 2, 3), MatrizResultado, 3, 3));
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

procedure TestCompararVetores;
var
  Vetor1, Vetor2: TVetor;
begin
  Vetor1[1] := 1; Vetor1[2] := 2; Vetor1[3] := 3;
  Vetor2 := Vetor1;
  InitTest('O vetor [1, 2, 3] deve ser igual a um vetor identico'); 
  Assert(VetorEquals(Vetor1, Vetor2, 3));

  InitTest('O vetor [1, 2, 3] deve ser igual a ele mesmo'); 
  Assert(VetorEquals(Vetor1, Vetor1, 3));

  InitTest('O vetor [1, 2, 3] NÃO deve ser igual ao vetor [1, 2, 4]'); 
  Vetor2[3] := 4;
  Assert(not VetorEquals(Vetor1, Vetor2, 3));
end;

procedure TestInstanciarVetorPorTexto;
var
  Vetor, VetorResultado: TVetor;
begin
  InitTest('Instanciar Vetor [1, 2, 3]'); 
  VetorResultado[1] := 1; VetorResultado[2] := 2; VetorResultado[3] := 3;
  Vetor := NovoVetor('[1, 2, 3]');
  Assert(VetorEquals(Vetor, VetorResultado, 3));

  InitTest('Instanciar Vetor [1, 2, 3, 3, 2, 1]'); 
  VetorResultado[1] := 1; VetorResultado[2] := 2; VetorResultado[3] := 3;
  VetorResultado[6] := 1; VetorResultado[5] := 2; VetorResultado[4] := 3;
  Vetor := NovoVetor('[1, 2, 3, 3, 2, 1]');
  Assert(VetorEquals(Vetor, VetorResultado, 6));
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
var 
  m : TMatriz;
  v : TVetor;
begin
  //StartTests;
  //TestCase('Comparar Matrizes', @TestCompararMatrizes);		  
  //TestCase('Instanciar Matriz por Texto', @TestInstanciarMatrizPorTexto);	
	//TestCase('Operacoes Matrizes', @TestOperacoes);	
  //TestCase('Multiplicador', @TestMultiplicador);	

  //TestCase('Comparar Vetores', @TestCompararVetores);	
  //TestCase('Instanciar Vetor por Texto', @TestInstanciarVetorPorTexto);	
  //TestCase('Reducao de Gauss', @TestReducaoDeGauss);	
  //TestCase('Resolucao Gauss', @TestResolucaoGauss);	
  m := NovaMatriz('[[1, 1, 1][2, -1, 3][3, 2, -1]]');
  v := NovoVetor('[6, 3, 4]');
  ReducaoDeGauss(m, v, 3, 3);
  MostrarVetor(ResolucaoGauss(m, v, 3), 3);

  //EndTests;
end.
