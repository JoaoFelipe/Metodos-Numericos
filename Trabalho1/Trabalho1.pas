program Trabalho1;

uses MatrizUnit, ReducaoGaussUnit, MetodosIterativosUnit, SysUtils;

var
  Tamanho, Iteracoes, RetornoIterativo : integer;
  Precisao : real;
  Escolha : integer;
  Coeficientes, CoeficientesTemp : TMatriz;
  TermosIndependentes, TermosIndependentesTemp, Resultado, AproxInicial : TVetor;
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

procedure RedGauss;
begin
  Resultado := ResolucaoCompletaGauss(CoeficientesTemp, TermosIndependentesTemp, Tamanho, Tamanho);
  MostrarResultados(Resultado, Tamanho);
end;

procedure Iterativo(metodo:String);
var i: integer;
begin 
  for i := 1 to Tamanho do
    AproxInicial[i] := 0;
  writeln('Digite o numero maximo de iteracoes');
  readln(Iteracoes);
  
  if metodo = 'Jacobi' then
    RetornoIterativo := Jacobi(Resultado, AproxInicial, CoeficientesTemp, TermosIndependentesTemp, Iteracoes, Tamanho, Tamanho, Precisao)
  else  
    RetornoIterativo := GaussSeidel(Resultado, AproxInicial, CoeficientesTemp, TermosIndependentesTemp, Iteracoes, Tamanho, Tamanho, Precisao);
     
  if RetornoIterativo = -1 then
    writeln('Nao eh possivel resolver, o sistema nao satisfaz as condicoes suficientes de convergencia')
  else begin
    if RetornoIterativo = 0 then
      writeln('O numero de iteracoes Maximo nao foi suficiente para definir o resultado com a precisao definida')
    else
      writeln('A seguinte solucao foi encontrada com ', RetornoIterativo, ' iteracoes');
    MostrarResultados(Resultado, Tamanho);
  end;
end;

procedure DefinirPrecisao;
var i:integer;
begin
  writeln('Digite a precisao (ex 0.1)');
  readln(Precisao);
  FloatFormated := FloatToStr(Precisao);  
	for i := 1 to length(FloatFormated) do
	begin
		if (FloatFormated[i] = ',') or (FloatFormated[i] = '.') then FloatFormated[i] := '.'
			else if FloatFormated[i] <> '0' then FloatFormated[i] := '0';
	end; 
  writeln(FloatFormated);

end;

begin
  DefinirPrecisao;
  LerMatriz;
  rodando := true;
  while rodando do
  begin
    writeln;
    writeln('Resolvendo o seguinte sistema');
    MostrarSistema(Coeficientes, TermosIndependentes, Tamanho, Tamanho);
    writeln;
    writeln('Por que metodo você deseja resolver?');
    writeln('1- Reducao de Gauss');
    writeln('2- Jacobi');
    writeln('3- Gauss-Seidel');
    writeln('4- Desejo escolher outro sistema');
    writeln('5- Alterar Precisao');
    writeln('6- Sair');
    readln(Escolha);

    CoeficientesTemp := Coeficientes;
    TermosIndependentesTemp := TermosIndependentes;
    
    case Escolha of
      1: RedGauss;
      2: Iterativo('Jacobi');
      3: Iterativo('GaussSeidel');
      4: LerMatriz;
      5: DefinirPrecisao;
      6: rodando := false;
    end;

  end;
end.
