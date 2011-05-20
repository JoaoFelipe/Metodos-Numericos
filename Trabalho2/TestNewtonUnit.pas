unit TestNewtonUnit;

interface
  uses NewtonUnit, UtilsUnit, TestUnit ;

  procedure DoAllNewtonTests;
  procedure TestDiferencaDividida;
  procedure TestTermosNewton;
  procedure TestPolinomioNewton;

  procedure DoAllNewtonGregoryTests;
  procedure TestPossibilidadeNG;
  procedure TestDiferencaFinita;
  procedure TestDiferencaDivididaNG;
  procedure TestPolinomioNewtonGregory;

  procedure TestTermosNewtonValor;
  procedure TestPolinomioNewtonValor;
  procedure TestPolinomioNewtonGregoryValor;
  
implementation

procedure DoAllNewtonTests;
begin
  TestCase('Diferença dividida', @TestDiferencaDividida);		  
  TestCase('Termos Newton', @TestTermosNewton);		  
  TestCase('Termos Newton com Valor', @TestTermosNewtonValor);		  
  TestCase('Polinomio de Newton', @TestPolinomioNewton);		  
  TestCase('Polinomio de Newton com valor', @TestPolinomioNewtonValor);		  
end;

procedure DoAllNewtonGregoryTests;
begin
  TestCase('Prossivel por Newton Gregory', @TestPossibilidadeNG);		  
  TestCase('Diferença finita', @TestDiferencaFinita);		  
  TestCase('Diferença dividida por Newton Gregory', @TestDiferencaDivididaNG);		  
  TestCase('Polinomio de Newton Gregory', @TestPolinomioNewtonGregory);	
  TestCase('Polinomio de Newton Gregory', @TestPolinomioNewtonGregoryValor);	
end;

procedure TestDiferencaDividida;
var
  vetor: TVetor;
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]]');
  
  InitTest('Diferença dividida f[-1] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar 1');
  vetor := NovoVetor('[-1]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 0, 5), 1));
 
  InitTest('Diferença dividida f[0] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar 1');
  vetor := NovoVetor('[0]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 0, 5), 1));

  InitTest('Diferença dividida f[1] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar 0');
  vetor := NovoVetor('[1]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 0, 5), 0));

  InitTest('Diferença dividida f[2] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar -1');
  vetor := NovoVetor('[2]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 0, 5), -1));

  InitTest('Diferença dividida f[3] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar -2');
  vetor := NovoVetor('[3]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 0, 5), -2));


  InitTest('Diferença dividida f[-1, 0] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar 0');
  vetor := NovoVetor('[-1, 0]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 1, 5), 0));

  InitTest('Diferença dividida f[0, 1] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar -1');
  vetor := NovoVetor('[0, 1]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 1, 5), -1));

  InitTest('Diferença dividida f[1, 2] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar -1');
  vetor := NovoVetor('[1, 2]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 1, 5), -1));

  InitTest('Diferença dividida f[2, 3] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar -1');
  vetor := NovoVetor('[2, 3]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 1, 5), -1));


  InitTest('Diferença dividida f[-1, 0, 1] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar -0.5');
  vetor := NovoVetor('[-1, 0, 1]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 2, 5), -0.5));

  InitTest('Diferença dividida f[0, 1, 2] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar 0');
  vetor := NovoVetor('[0, 1, 2]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 2, 5), 0));

  InitTest('Diferença dividida f[1, 2, 3] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar 0');
  vetor := NovoVetor('[1, 2, 3]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 2, 5), 0));


  InitTest('Diferença dividida f[-1, 0, 1, 2] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar 1/6');
  vetor := NovoVetor('[-1, 0, 1, 2]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 3, 5), 1/6));

  InitTest('Diferença dividida f[0, 1, 2, 3] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar 0');
  vetor := NovoVetor('[0, 1, 2, 3]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 3, 5), 0));


  InitTest('Diferença dividida f[-1, 0, 1, 2, 3] de [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]] deve retornar -1/24');
  vetor := NovoVetor('[-1, 0, 1, 2, 3]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 4, 5), -1/24));


  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  InitTest('Diferença dividida f[-1] de [[-1, 0, 2],[4, 1, -1]] deve retornar 4');
  vetor := NovoVetor('[-1]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 0, 3), 4));
  
  InitTest('Diferença dividida f[0] de [[-1, 0, 2],[4, 1, -1]] deve retornar 1');
  vetor := NovoVetor('[0]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 0, 3), 1));
  
  InitTest('Diferença dividida f[2] de [[-1, 0, 2],[4, 1, -1]] deve retornar -1');
  vetor := NovoVetor('[2]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 0, 3), -1));


  InitTest('Diferença dividida f[-1, 0] de [[-1, 0, 2],[4, 1, -1]] deve retornar -3');
  vetor := NovoVetor('[-1, 0]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 1, 3), -3));

  InitTest('Diferença dividida f[0, 2] de [[-1, 0, 2],[4, 1, -1]] deve retornar -1');
  vetor := NovoVetor('[0, 2]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 1, 3), -1));


  InitTest('Diferença dividida f[-1, 0, 2] de [[-1, 0, 2],[4, 1, -1]] deve retornar 2/3');
  vetor := NovoVetor('[-1, 0, 2]');
  Assert(FloatEquals(DiferencaDividida(matriz, vetor, 2, 3), 2/3));
  
end;

procedure TestTermosNewton;
var
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  
  InitTest('Termo 0 de [[-1, 0, 2],[4, 1, -1]] deve retornar ""');
  Assert(TermoNewton(matriz, 0) = '');

  InitTest('Termo 1 de [[-1, 0, 2],[4, 1, -1]] deve retornar (x+1.000)');
  Assert(TermoNewton(matriz, 1) = '(x+1.000)');

  InitTest('Termo 2 de [[-1, 0, 2],[4, 1, -1]] deve retornar (x+1.000)x');
  Assert(TermoNewton(matriz, 2) = '(x+1.000)x');


  matriz := NovaMatriz('[[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]]');
  
  InitTest('Termo 0 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar ""');
  Assert(TermoNewton(matriz, 0) = '');

  InitTest('Termo 1 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar (x+1.000)');
  Assert(TermoNewton(matriz, 1) = '(x+1.000)');

  InitTest('Termo 2 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar (x+1.000)x');
  Assert(TermoNewton(matriz, 2) = '(x+1.000)x');

  InitTest('Termo 3 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar (x+1.000)x(x-1.000)');
  Assert(TermoNewton(matriz, 3) = '(x+1.000)x(x-1.000)');

  InitTest('Termo 4 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar (x+1.000)x(x-1.000)(x-2.000)');
  Assert(TermoNewton(matriz, 4) = '(x+1.000)x(x-1.000)(x-2.000)');
end;


procedure TestPolinomioNewton;
var
  vetor: TVetor;
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  
  InitTest('Polinomio de ordem 2 de [[-1, 0, 2],[4, 1, -1]] deve retornar 4.000 - 3.000(x+1.000) + 0.666(x+1.000)x');
  Assert(PolinomioNewton(matriz, 2, 3, 'Newton', false) = '4.000 - 3.000(x+1.000) + 0.667(x+1.000)x');

  InitTest('Polinomio de ordem maxima(-1) de [[-1, 0, 2],[4, 1, -1]] deve retornar 4.000 - 3.000(x+1.000) + 0.666(x+1.000)x');
  Assert(PolinomioNewton(matriz, -1, 3, 'Newton', false) = '4.000 - 3.000(x+1.000) + 0.667(x+1.000)x');
end;

//fazer f(1) = -2/3



procedure TestPossibilidadeNG;
var
  matriz: TMatriz;
begin
  InitTest('É possível usar Newton-Gregory em [[-1, 0, 1, 2, 3],[1, 1, 0, -1, -2]]');
  matriz := NovaMatriz('[[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]]');
  Assert(PossivelNG(matriz, 5));

  InitTest('NÃO é possível usar Newton-Gregory em [[-2, 0, 1, 2, 3],[1, 1, 0, -1, -2]]');
  matriz := NovaMatriz('[[-2, 0, 1, 2, 3][1, 1, 0, -1, -2]]');
  Assert(PossivelNG(matriz, 5) = False);

  InitTest('NÃO é possível usar Newton-Gregory em [[-1, 0, 1, 3, 4],[1, 1, 0, -1, -2]]');
  matriz := NovaMatriz('[[-1, 0, 1, 3, 4][1, 1, 0, -1, -2]]');
  Assert(PossivelNG(matriz, 5) = False);

  InitTest('É possível usar Newton-Gregory em [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]]');
  matriz := NovaMatriz('[[0, 0.5, 1, 1.5, 2][0, 1.1487, 2.7183, 4.9811, 8.3890]]');
  Assert(PossivelNG(matriz, 5));
end;

procedure TestDiferencaFinita;
var
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[0, 0.5, 1, 1.5, 2][0, 1.1487, 2.7183, 4.9811, 8.3890]]');
  InitTest('Diferença finita D0f(xo) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0');
  Assert(FloatEquals(DiferencaFinita(matriz, 0, 0, 5), 0));

  InitTest('Diferença finita D0f(x1) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 1.1487');
  Assert(FloatEquals(DiferencaFinita(matriz, 1, 0, 5), 1.1487));

  InitTest('Diferença finita D0f(x2) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 2.7183');
  Assert(FloatEquals(DiferencaFinita(matriz, 2, 0, 5), 2.7183));

  InitTest('Diferença finita D0f(x3) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 4.9811');
  Assert(FloatEquals(DiferencaFinita(matriz, 3, 0, 5), 4.9811));

  InitTest('Diferença finita D0f(x4) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 8.3890');
  Assert(FloatEquals(DiferencaFinita(matriz, 4, 0, 5), 8.3890));


  InitTest('Diferença finita D1f(x0) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 1.1487');
  Assert(FloatEquals(DiferencaFinita(matriz, 0, 1, 5), 1.1487));

  InitTest('Diferença finita D1f(x1) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 1.5696');
  Assert(FloatEquals(DiferencaFinita(matriz, 1, 1, 5), 1.5696));

  InitTest('Diferença finita D1f(x2) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 2.2628');
  Assert(FloatEquals(DiferencaFinita(matriz, 2, 1, 5), 2.2628));

  InitTest('Diferença finita D1f(x3) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 3.4079');
  Assert(FloatEquals(DiferencaFinita(matriz, 3, 1, 5), 3.4079));


  InitTest('Diferença finita D2f(x0) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0.4209');
  Assert(FloatEquals(DiferencaFinita(matriz, 0, 2, 5), 0.4209));
  
  InitTest('Diferença finita D2f(x1) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0.6932');
  Assert(FloatEquals(DiferencaFinita(matriz, 1, 2, 5), 0.6932));

  InitTest('Diferença finita D2f(x2) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 1.1451');
  Assert(FloatEquals(DiferencaFinita(matriz, 2, 2, 5), 1.1451));


  InitTest('Diferença finita D3f(x0) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0.2723');
  Assert(FloatEquals(DiferencaFinita(matriz, 0, 3, 5), 0.2723));

  InitTest('Diferença finita D3f(x1) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0.4519');
  Assert(FloatEquals(DiferencaFinita(matriz, 1, 3, 5), 0.4519));


  InitTest('Diferença finita D4f(x0) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0.1796');
  Assert(FloatEquals(DiferencaFinita(matriz, 0, 4, 5), 0.1796));
end;

procedure TestDiferencaDivididaNG;
var
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[0, 0.5, 1, 1.5, 2][0, 1.1487, 2.7183, 4.9811, 8.3890]]');
  
  InitTest('Diferença dividida F[x0] (ordem 0) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0');
  Assert(FloatEquals(DiferencaDivididaNG(matriz, 0, 5), 0));

  InitTest('Diferença dividida F[x0, x1] (ordem 1) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 2.2974');
  Assert(FloatEquals(DiferencaDivididaNG(matriz, 1, 5), 2.2974));

  InitTest('Diferença dividida F[x0, x1, x2] (ordem 2) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0.8418');
  Assert(FloatEquals(DiferencaDivididaNG(matriz, 2, 5), 0.8418));

  InitTest('Diferença dividida F[x0, x1, x2, x3] (ordem 3) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0.3631');
  Assert(FloatEquals(DiferencaDivididaNG(matriz, 3, 5), 0.3631));

  InitTest('Diferença dividida F[x0, x1, x2, x3, x4] (ordem 4) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0.1197');
  Assert(FloatEquals(DiferencaDivididaNG(matriz, 4, 5), 0.1197));
end;


procedure TestPolinomioNewtonGregory;
var
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[0, 0.5, 1, 1.5, 2][0, 1.1487, 2.7183, 4.9811, 8.3890]]');
  InitTest('Polinomio de ordem 4 de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0 + 2.297x + 0.842x(x-0.500) + 0.363x(x-0.500)(x-1.000) + 0.120x(x-0.500)(x-1.000)(x-1.500)');
  Assert(PolinomioNewton(matriz, 4, 5, 'NewtonGregory', false) = '0.000 + 2.297x + 0.842x(x-0.500) + 0.363x(x-0.500)(x-1.000) + 0.120x(x-0.500)(x-1.000)(x-1.500)');

  InitTest('Polinomio de ordem máxima (-1) de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 0 + 2.297x + 0.842x(x-0.500) + 0.363x(x-0.500)(x-1.000) + 0.120x(x-0.500)(x-1.000)(x-1.500)');
  Assert(PolinomioNewton(matriz, -1, 5, 'NewtonGregory', false) = '0.000 + 2.297x + 0.842x(x-0.500) + 0.363x(x-0.500)(x-1.000) + 0.120x(x-0.500)(x-1.000)(x-1.500)');

end;
//fazer f(0.7) = 1.7148

procedure TestTermosNewtonValor;
var
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  
  InitTest('Termo 0 para x = 1 de [[-1, 0, 2],[4, 1, -1]] deve retornar 1');
  Assert(FloatEquals(TermoNewtonValor(matriz, 0, 1), 1));

  InitTest('Termo 1 para x = 1 de [[-1, 0, 2],[4, 1, -1]] deve retornar 2');
  Assert(FloatEquals(TermoNewtonValor(matriz, 1, 1), 2));

  InitTest('Termo 2 para x = 1 de [[-1, 0, 2],[4, 1, -1]] deve retornar 2');
  Assert(FloatEquals(TermoNewtonValor(matriz, 2, 1), 2));

  matriz := NovaMatriz('[[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]]');
  
  InitTest('Termo 0 para x = 0.7 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar 1');
  Assert(FloatEquals(TermoNewtonValor(matriz, 0, 0.7), 1));

  InitTest('Termo 1 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar 1.7');
  Assert(FloatEquals(TermoNewtonValor(matriz, 1, 0.7), 1.7));

  InitTest('Termo 2 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar 1.19');
  Assert(FloatEquals(TermoNewtonValor(matriz, 2, 0.7), 1.19));

  InitTest('Termo 3 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar -0.357');
  Assert(FloatEquals(TermoNewtonValor(matriz, 3, 0.7), -0.357));

  InitTest('Termo 4 de [[-1, 0, 1, 2, 3][1, 1, 0, -1, -2]] deve retornar 0,4641');
  Assert(FloatEquals(TermoNewtonValor(matriz, 4, 0.7), 0.4641));
end;

procedure TestPolinomioNewtonValor;
var
  vetor: TVetor;
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[-1, 0, 2][4, 1, -1]]');
  
  InitTest('Polinomio de ordem 2 em x=1 de [[-1, 0, 2],[4, 1, -1]] deve retornar -2/3');
  Assert(FloatEquals(PolinomioNewtonValor(matriz, 2, 3, 'Newton', 1) , -2/3));

  InitTest('Polinomio de ordem maxima(-1) em x=1 de [[-1, 0, 2],[4, 1, -1]] deve retornar -2/3');
  Assert(FloatEquals(PolinomioNewtonValor(matriz, -1, 3, 'Newton', 1) , -2/3));
end;

procedure TestPolinomioNewtonGregoryValor;
var
  matriz: TMatriz;
begin
  FloatFormated := '0.000';
  matriz := NovaMatriz('[[0, 0.5, 1, 1.5, 2][0, 1.1487, 2.7183, 4.9811, 8.3890]]');
  InitTest('Polinomio de ordem 4 em x = 0.7 de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 1.7148');
  Assert(FloatEquals(PolinomioNewtonValor(matriz, 4, 5, 'NewtonGregory', 0.7), 1.7148));

  Assert(FloatEquals(PolinomioNewtonValor(matriz, 4, 5, 'NewtonGregory', 0.7), 1.7148));
  InitTest('Polinomio de ordem máxima (-1) em x = 0.7 de [[0, 0.5, 1, 1.5, 2],[0, 1.1487, 2.7183, 4.9811, 8.3890]] deve retornar 1.7148');
  Assert(FloatEquals(PolinomioNewtonValor(matriz, -1, 5, 'NewtonGregory', 0.7), 1.7148));

end;
//fazer f(0.7) = 1.7148

end.
