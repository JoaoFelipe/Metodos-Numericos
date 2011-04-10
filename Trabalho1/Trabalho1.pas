program Trabalho1;

uses TestUnit, MatrizUnit, TestReducaoGaussUnit, TestMetodosIterativosUnit;

var
  Tamanho, Iteracoes, RetornoIterativo : integer;
  Precisao : real;
  Escolha : integer;
  Coeficientes, CoeficientesTemp : TMatriz;
  TermosIndependentes, TermosIndependentesTemp, Resultado : TVetor;
  rodando: boolean;

procedure LerMatriz;
var i, j: integer;
begin
  Tamanho := 21;
  while Tamanho > 20 do
  begin
    writeln('Digite o numero de incognitas');
    readln(Tamanho);
  end;

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


procedure ExecutarIterativo(func: TIterativo);
begin
  writeln('Digite o numero máximo de iterações');
  readln(Iteracoes);
  writeln('Digite a precisão (ex 0.1)');
  readln(Precisao);
  RetornoIterativo := func(Resultado, NovoVetor('[0, 0, 0]'), CoeficientesTemp, TermosIndependentesTemp, Iteracoes, Tamanho, Tamanho, Precisao);
  if RetornoIterativo = -1 then
    writeln('Não é possível resolver, o sistema não satisfaz as condições suficientes de convergencia')
  else begin
    if RetornoIterativo = 0 then
      writeln('O numero de iteracoes Máximo não foi suficiente para definir o resultado com a precisao definida')
    else
      writeln('A seguinte solucao foi encontrada com ', RetornoIterativo, ' iterações');
      MostrarResultados(Resultado, Tamanho);
  end;
end;

begin
  LerMatriz;
  rodando := true;
  while rodando do
  begin(
    writeln;
    writeln('Resolvendo o seguinte sistema');
    MostrarSistema(Coeficientes, TermosIndependentes, Tamanho, Tamanho);
    writeln;
    writeln('Por que metodo você deseja resolver?');
    writeln('1- Redução de Gauss');
    writeln('2- Jacobi');
    writeln('3- Gauss-Seidel');
    writeln('4- Desejo escolher outro sistema');
    writeln('5- Sair');
    readln(Escolha);
    //Esqueci como usar case e não estou com vontade de procurar agora
    CoeficientesTemp := Coeficientes;
    TermosIndependentesTemp := TermosIndependentes;
    if Escolha = 1 then
    begin
      
      Resultado := ResolucaoCompletaGauss(CoeficientesTemp, TermosIndependentesTemp, Tamanho, Tamanho);
      MostrarResultados(Resultado, Tamanho);
    end else if Escolha = 2 then 
    begin
      ExecutarIterativo(@jacobi);
    end;
  end;
end.
