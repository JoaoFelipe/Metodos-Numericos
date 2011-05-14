unit TestUtilsUnit;

interface
  uses UtilsUnit, TestUnit;

  procedure DoAllUtilsTests;

  procedure TestFloatToStr;
  procedure TestFloatToSignedString;
  procedure TestPotFat;

  procedure TestCompararMatrizes;
  procedure TestInstanciarMatrizPorTexto;
  procedure TestCompararVetores;
  procedure TestInstanciarVetorPorTexto;

  procedure TestTrimVetor;
  procedure TestExtrairLinha;

implementation

procedure DoAllUtilsTests;
begin
  TestCase('Converter Float para String', @TestFloatToStr);		  
  TestCase('Converter Float para String com Sinal', @TestFloatToSignedString);		  
  TestCase('Potencia e Fatorial', @TestPotFat);		  
  TestCase('Comparar Matrizes', @TestCompararMatrizes);		  
  TestCase('Instanciar Matriz por Texto', @TestInstanciarMatrizPorTexto);	
  TestCase('Comparar Vetores', @TestCompararVetores);	
  TestCase('Instanciar Vetor por Texto', @TestInstanciarVetorPorTexto);
  TestCase('Trim Vetor', @TestTrimVetor);
  TestCase('Extrair Linha', @TestExtrairLinha);
end;

procedure TestFloatToStr;
begin
  InitTest('1 deve ser convertido como "1", com FloatFormated = 0'); 
  FloatFormated := '0';
  Assert(FloatToString(1) = '1');

  InitTest('1 deve ser convertido como "1.0", com FloatFormated = 0.0'); 
  FloatFormated := '0.0';
  Assert(FloatToString(1) = '1.0');

  InitTest('1 deve ser convertido como "1.00", com FloatFormated = 0.00'); 
  FloatFormated := '0.00';
  Assert(FloatToString(1) = '1.00');

  InitTest('1 deve ser convertido como "1.000", com FloatFormated = 0.000'); 
  FloatFormated := '0.000';
  Assert(FloatToString(1) = '1.000');

  InitTest('1 deve ser convertido como "1.0000000", com FloatFormated = 0.0000000'); 
  FloatFormated := '0.0000000';
  Assert(FloatToString(1) = '1.0000000');

  InitTest('0.1 deve ser convertido como "0", com FloatFormated = 0'); 
  FloatFormated := '0';
  Assert(FloatToString(0.1) = '0');

  InitTest('0.9 deve ser convertido como "1", com FloatFormated = 0'); 
  FloatFormated := '0';
  Assert(FloatToString(0.9) = '1');

  InitTest('0.1 deve ser convertido como "0.1", com FloatFormated = 0.0'); 
  FloatFormated := '0.0';
  Assert(FloatToString(0.1) = '0.1');

  InitTest('0.9 deve ser convertido como "0.9", com FloatFormated = 0.0'); 
  FloatFormated := '0.0';
  Assert(FloatToString(0.9) = '0.9');

  InitTest('1/3 deve ser convertido como "0.333", com FloatFormated = 0.000'); 
  FloatFormated := '0.000';
  Assert(FloatToString(1/3) = '0.333');

  InitTest('2/3 deve ser convertido como "0.667", com FloatFormated = 0.000'); 
  FloatFormated := '0.000';
  Assert(FloatToString(2/3) = '0.667');

  InitTest('3/3 deve ser convertido como "1.000", com FloatFormated = 0.000'); 
  FloatFormated := '0.000';
  Assert(FloatToString(3/3) = '1.000');
end;

procedure TestFloatToSignedString;
begin
  FloatFormated := '0.000';
 
  InitTest('1 deve ser convertido como "+1.000"');
  Assert(FloatToSignedString(1) = '+1.000');

  InitTest('-1 deve ser convertido como "-1.000"');
  Assert(FloatToSignedString(-1) = '-1.000');

  InitTest('1 deve ser convertido como " + 1.000" com separador " "');
  Assert(FloatToSignedString(1, ' ') = ' + 1.000');

  InitTest('-1 deve ser convertido como " - 1.000" com separador " "');
  Assert(FloatToSignedString(-1, ' ') = ' - 1.000');
end;

procedure TestPotFat;
begin
  InitTest('1⁰ = 1');
  Assert(Pot(1, 0) = 1);
  InitTest('2⁰ = 1');
  Assert(Pot(2, 0) = 1);
  InitTest('1¹ = 1');
  Assert(Pot(1, 1) = 1);
  InitTest('1² = 1');
  Assert(Pot(1, 2) = 1);
  InitTest('2² = 4');
  Assert(Pot(2, 2) = 4);
  InitTest('3² = 9');
  Assert(Pot(3, 2) = 9);
  InitTest('3³ = 27');
  Assert(Pot(3, 3) = 27);

  InitTest('0! = 1');
  Assert(Fat(0) = 1);
  InitTest('1! = 1');
  Assert(Fat(1) = 1);
  InitTest('2! = 2');
  Assert(Fat(2) = 2);
  InitTest('3! = 6');
  Assert(Fat(3) = 6);
  InitTest('4! = 24');
  Assert(Fat(4) = 24);
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

procedure TestTrimVetor;
var
  Vetor, VetorResultado: TVetor;
begin
  Vetor := NovoVetor('[1, 5, 7, 8, 2, 4, 6]');

  InitTest('Trimar Vetor [1, 5, 7, 8, 2, 4, 6] de 1 a 7 deve retornar [1, 5, 7, 8, 2, 4, 6]'); 
  VetorResultado := NovoVetor('[1, 5, 7, 8, 2, 4, 6]'); 
  Assert(VetorEquals(TrimVetor(Vetor, 1, 7), VetorResultado, 7));

  InitTest('Trimar Vetor [1, 5, 7, 8, 2, 4, 6] de 1 a 6 deve retornar [1, 5, 7, 8, 2, 4]'); 
  VetorResultado := NovoVetor('[1, 5, 7, 8, 2, 4]'); 
  Assert(VetorEquals(TrimVetor(Vetor, 1, 6), VetorResultado, 6));

  InitTest('Trimar Vetor [1, 5, 7, 8, 2, 4, 6] de 2 a 6 deve retornar [5, 7, 8, 2, 4]'); 
  VetorResultado := NovoVetor('[5, 7, 8, 2, 4]'); 
  Assert(VetorEquals(TrimVetor(Vetor, 2, 6), VetorResultado, 5));

  InitTest('Trimar Vetor [1, 5, 7, 8, 2, 4, 6] de 2 a 5 deve retornar [5, 7, 8, 2]'); 
  VetorResultado := NovoVetor('[5, 7, 8, 2]'); 
  Assert(VetorEquals(TrimVetor(Vetor, 2, 5), VetorResultado, 4));

  InitTest('Trimar Vetor [1, 5, 7, 8, 2, 4, 6] de 3 a 4 deve retornar [7, 8]'); 
  VetorResultado := NovoVetor('[7, 8]'); 
  Assert(VetorEquals(TrimVetor(Vetor, 3, 4), VetorResultado, 2));

  InitTest('Trimar Vetor [1, 5, 7, 8, 2, 4, 6] de 4 a 4 deve retornar [8]'); 
  VetorResultado := NovoVetor('[8]'); 
  Assert(VetorEquals(TrimVetor(Vetor, 4, 4), VetorResultado, 1));
end;

procedure TestExtrairLinha;
var
  Matriz: TMatriz;
  Vetor: TVetor;
begin
  Matriz := NovaMatriz('[[1, 2, 3][4, 5, 6][7, 8, 9]]');

  InitTest('Extrair a Linha 1 de [[1, 2, 3][4, 5, 6][7, 8, 9]] deve retornar [1, 2, 3]'); 
  Vetor := NovoVetor('[1, 2, 3]');
  Assert(VetorEquals(ExtrairLinha(Matriz, 1, 3), Vetor, 3));

  InitTest('Extrair a Linha 2 de [[1, 2, 3][4, 5, 6][7, 8, 9]] deve retornar [4, 5, 6]'); 
  Vetor := NovoVetor('[4, 5, 6]');
  Assert(VetorEquals(ExtrairLinha(Matriz, 2, 3), Vetor, 3));

  InitTest('Extrair a Linha 3 de [[1, 2, 3][4, 5, 6][7, 8, 9]] deve retornar [7, 8, 9]'); 
  Vetor := NovoVetor('[7, 8, 9]');
  Assert(VetorEquals(ExtrairLinha(Matriz, 3, 3), Vetor, 3));
end;


end.
