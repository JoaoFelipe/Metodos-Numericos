program Trabalho2;
uses UtilsUnit, LagrangeUnit, NewtonUnit,crt;
var
  Escolha, tamanho: Integer;
  rodando: Boolean;
  matriz: TMatriz;
  passo: Boolean;

procedure AlterarPrecisao();
var 
  ler:integer;
  i: integer;
begin
  ler := -1;
  repeat
    writeln('Voce deseja que os numeros sejam mostrados com quantas casas decimais?');
    readln(ler);
  until ler > -1;
  
  if ler > 0 then
  begin
    FloatFormated := '0.';
    for i:= 1 to ler do
      FloatFormated := FloatFormated+'0';
  end 
    else FloatFormated := '0';
  
end;

procedure LerTabela;
var
  i:integer;
begin
  writeln('Quantos Pontos voce tem?');
  readln(tamanho);
  for i := 1 to tamanho do
  begin
    writeln('Digite o valor de x',i-1);
    readln(matriz[1,i]);
    writeln('Digite o valor de f(x',i-1,')');
    readln(matriz[2,i]);
  end;

end;

procedure ResolverLagrange;
var temp:string;
begin
  writeln('Resolvendo seguinte interpolacao pela Forma de Lagrange');
  MostrarTabela(matriz, tamanho);
  writeln;
  temp := PolinomioLagrange(matriz, tamanho, passo);
  write('P(x) = ');
  writeln(temp);
  writeln;
  writeln('Pressione alguma tecla para voltar ao menu');
  readln;;
end;

procedure ResolverNewton(tipo: String);
var temp:string;
begin
  writeln('Resolvendo seguinte interpolacao pela Forma de ', tipo);
  MostrarTabela(matriz, tamanho);
  writeln;
  temp := PolinomioNewton(matriz, -1, tamanho, tipo, passo);
  write('P(x) = ');
  writeln(temp);
  writeln;
  writeln('Pressione alguma tecla para voltar ao menu');
  readln;
end;

procedure LerPasso;
var
  ler:char;
begin
  writeln('Deseja mostrar informacoes completas?');
  writeln('N-Nao');
  writeln('s-Sim');
  readln(ler);
  passo := ((ler = 's') or (ler = 'S'));
end;

begin
  clrscr;
  AlterarPrecisao;
  LerTabela;
  LerPasso;
  rodando := True;
  while rodando do
  begin
    clrscr;
    MostrarTabela(matriz, tamanho);
    writeln('O que voce deseja fazer?');
    writeln('1-Encontrar polinomio pela forma de Lagrange');
    writeln('2-Encontrar polinomio pela forma de Newton');
    if PossivelNG(matriz, tamanho) then
      writeln('3-Encontrar polinomio pela forma de Newton-Gregory')
    else
      writeln('Newton-Gregory indisponivel');
    writeln('4-Mudar tabela de interpolacao');
    writeln('5-Mudar precisao usada');
    writeln('6-Mudar decisao de mostrar informacoes completas');
    writeln('7-Sair');
    write('Digite um numero: ');
    readln(Escolha);

    clrscr;
    case Escolha of
      1: ResolverLagrange;
      2: ResolverNewton('Newton');
      3: if PossivelNG(matriz, tamanho) then ResolverNewton('Newton-Gregory');
      4: LerTabela;
      5: AlterarPrecisao;
      6: LerPasso;
      7: rodando := false;
    end;
    

  end;
end.
