unit TestMatrizUnit;

interface
  uses MatrizUnit, TestUnit;

  procedure DoAllMatrizTests;
  procedure TestCompararMatrizes;
  procedure TestInstanciarMatrizPorTexto;
  procedure TestCompararVetores;
  procedure TestInstanciarVetorPorTexto;
  procedure TestOperacoes;

implementation

procedure DoAllMatrizTests;
begin
  TestCase('Comparar Matrizes', @TestCompararMatrizes);		  
  TestCase('Instanciar Matriz por Texto', @TestInstanciarMatrizPorTexto);	
  TestCase('Comparar Vetores', @TestCompararVetores);	
  TestCase('Instanciar Vetor por Texto', @TestInstanciarVetorPorTexto);
  TestCase('Operacoes Matrizes', @TestOperacoes);	
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
  Assert(MatrizNotEquals(matriz1, matriz2, 2, 3));
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
  Assert(VetorNotEquals(Vetor1, Vetor2, 3));
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


end.
