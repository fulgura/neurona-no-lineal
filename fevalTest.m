clear all;
clc;

P = [ -1 -1	1 1;
    -1 1 -1 1];
T = [ 0 1 1 0 ];
T2 = [-1 1 1 -1];

[Entradas, CantPatrones] = size(P);
Ocultas = 2;
Salidas = 1;

funcion = 'tansig';

w1 = rand(Ocultas,Entradas) - 0.5 * ones(Ocultas,Entradas);
b1 = rand(Ocultas,1) - 0.5 * ones(Ocultas,1);

% calculo del error
error = w1 * P + b1 * ones(1,CantPatrones);

tansig_aplicada = tansig(error)
feval_aplicada = feval ( funcion, error )

tansig_aplicada == feval_aplicada
