unit MetodosIterativosUnit;


interface
  uses MatrizUnit;

  function ConvergeCriterioLinhas(Matriz: TMatriz; Linhas, Colunas:integer; epsilon: real): boolean;
  function ConvergeCriterioColunas(Matriz: TMatriz; Linhas, Colunas:integer; epsilon: real): boolean;
  function ConvergeCriterioSassenfeld(Matriz: TMatriz; Linhas, Colunas:integer; epsilon: real): boolean;
  function Converge(Matriz: TMatriz; Linhas, Colunas:integer; epsilon: real): boolean;
  
  procedure MontarSistema(var F: TMatriz; var d: TVetor; Matriz: TMatriz; Vetor: TVetor; Linhas, Colunas:integer);
  function GaussSeidel(var x, xInicial: TVetor; Matriz: TMatriz; Vetor: TVetor; Iteracoes, Linhas, Colunas: integer; epsilon: real):integer;
  function Jacobi(var x, xInicial: TVetor; Matriz: TMatriz; Vetor: TVetor; Iteracoes, Linhas, Colunas: integer; epsilon: real):integer;
  function MetodosIterativos(var x, xInicial: TVetor; pX : TVetor; Matriz: TMatriz; Vetor: TVetor; Iteracoes, Linhas, Colunas: integer; epsilon: real):integer;
const
  SemiEpsilon: real = 0.9;
 

implementation
  
Uses SysUtils;
 
function ConvergeCriterioLinhas(Matriz: TMatriz; Linhas, Colunas:integer; epsilon: real): boolean;
var 
  i, j: integer;
  soma: real;
begin
  ConvergeCriterioLinhas := true;
  for i := 1 to Linhas do
  begin
    soma := 0;
    for j := 1 to Colunas do
      if i<>j then
        soma := soma + ABS(Matriz[i,j]);
    ConvergeCriterioLinhas := ConvergeCriterioLinhas and (Matriz[i, i] > soma + SemiEpsilon*epsilon); 
  end;
end;

function ConvergeCriterioColunas(Matriz: TMatriz; Linhas, Colunas:integer; epsilon: real): boolean;
var 
  i, j: integer;
  soma: real;
begin
  ConvergeCriterioColunas := true;
  for j := 1 to Colunas do
  begin
    soma := 0;
    for i := 1 to Linhas do
      if i<>j then
        soma := soma + ABS(Matriz[i,j]);
    ConvergeCriterioColunas := ConvergeCriterioColunas and (Matriz[j, j] > soma + SemiEpsilon*epsilon); 
  end;
end;

function ConvergeCriterioSassenfeld(Matriz: TMatriz; Linhas, Colunas:integer; epsilon: real): boolean;
var 
  i, j: integer;
  soma: real;
begin
  ConvergeCriterioSassenfeld := true;
  for i := 1 to Linhas do
  begin
    soma := 0;
    for j := 1 to Colunas do
      soma := soma + ABS(Matriz[i,j]);
    ConvergeCriterioSassenfeld := ConvergeCriterioSassenfeld and (soma < 1 - SemiEpsilon*epsilon); 
  end;
end;

function Converge(Matriz: TMatriz; Linhas, Colunas:integer; epsilon: real): boolean;
begin
  Converge := ConvergeCriterioLinhas(Matriz, Linhas, Colunas, epsilon) or 
              ConvergeCriterioColunas(Matriz, Linhas, Colunas, epsilon);
end;

procedure MontarSistema(var F: TMatriz; var d: TVetor; Matriz: TMatriz; Vetor: TVetor; Linhas, Colunas:integer);
var 
  i, j: integer;
begin
  for i := 1 to Linhas do
  begin
    F[i, i] := 0;
    for j:= 1 to Colunas do
      if i<>j then
        F[i, j] := -Matriz[i, j] / Matriz[i, i];
    d[i] := Vetor[i] / Matriz[i, i];
  end;
end;

function MetodosIterativos(var x, xInicial: TVetor; pX : TVetor; Matriz: TMatriz; Vetor: TVetor; Iteracoes, Linhas, Colunas: integer; epsilon: real):integer;
var
  i, j, iter: integer;
  F: TMatriz;
  d: TVetor;
  delta : real;
begin  
  iter := 0;
  x := xInicial;
  MontarSistema(F, d, Matriz, Vetor, Linhas, Colunas);

  if (not (Converge(Matriz, Linhas, Colunas, epsilon) or ConvergeCriterioSassenfeld(F, Linhas, Colunas, epsilon))) then
  begin
    MetodosIterativos := -1;
    exit();
  end;

  delta := epsilon;
  while (iter < Iteracoes) and (delta >= epsilon) do
  begin

    for i := 1 to Linhas do
    begin
      x[i] := d[i];
      for j := 1 to Colunas do
        x[i]:= x[i] + F[i, j]*x[j];
    end;

    delta := 0;
    for i := 1 to Linhas do
      if ABS(x[i] - xInicial[i]) > delta then
        delta := ABS(x[i] - xInicial[i]);
    xInicial := x;
    inc(iter);
  end;

  if (delta >= epsilon) then
    MetodosIterativos := 0
  else
    MetodosIterativos := iter;
end;

function GaussSeidel(var x, xInicial: TVetor; Matriz: TMatriz; Vetor: TVetor; Iteracoes, Linhas, Colunas: integer; epsilon: real):integer;
var
  i, j, iter: integer;
  F: TMatriz;
  d: TVetor;
  delta : real;
begin  
  GaussSeidel:=MetodosIterativos(x, xInicial, x, Matriz, Vetor, Linhas, Colunas, epsilon);
//  iter := 0;
//  x := xInicial;
//  MontarSistema(F, d, Matriz, Vetor, Linhas, Colunas);
//
//  if (not (Converge(Matriz, Linhas, Colunas, epsilon) or ConvergeCriterioSassenfeld(F, Linhas, Colunas, epsilon))) then
//  begin
//    GaussSeidel := -1;
//    exit();
//  end;
//
//  delta := epsilon;
//  while (iter < Iteracoes) and (delta >= epsilon) do
//  begin
//
//    for i := 1 to Linhas do
//    begin
//      x[i] := d[i];
//      for j := 1 to Colunas do
//        x[i]:= x[i] + F[i, j]*x[j];
//    end;
//
//    delta := 0;
//    for i := 1 to Linhas do
//      if ABS(x[i] - xInicial[i]) > delta then
//        delta := ABS(x[i] - xInicial[i]);
//    xInicial := x;
//    inc(iter);
//  end;
//
//  if (delta >= epsilon) then
//    GaussSeidel := 0
//  else
//    GaussSeidel := iter;
end;

function Jacobi(var x, xInicial: TVetor; Matriz: TMatriz; Vetor: TVetor; Iteracoes, Linhas, Colunas: integer; epsilon: real):integer;
var
  i, j, iter: integer;
  F: TMatriz;
  d: TVetor;
  delta : real;
begin  
  iter := 0;
  x := xInicial;
  MontarSistema(F, d, Matriz, Vetor, Linhas, Colunas);

  if (not (Converge(Matriz, Linhas, Colunas, epsilon) or ConvergeCriterioSassenfeld(F, Linhas, Colunas, epsilon))) then
  begin
    Jacobi := -1;
    exit();
  end;

  delta := epsilon;
  while (iter < Iteracoes) and (delta >= epsilon) do
  begin

    for i := 1 to Linhas do
    begin
      x[i] := d[i];
      for j := 1 to Colunas do
        x[i]:= x[i] + F[i, j]*xInicial[j];
    end;

    delta := 0;
    for i := 1 to Linhas do
      if ABS(x[i] - xInicial[i]) > delta then
        delta := ABS(x[i] - xInicial[i]);
    xInicial := x;
    inc(iter);
  end;

  if (delta >= epsilon) then
    Jacobi := 0
  else
    Jacobi := iter;
end;

   
end.
