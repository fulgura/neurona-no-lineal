clear
clear all
clc


%====== muestras ======
X = [ 2 3 1 3 0 2 -1 2 ;
      2 1 0 3 1 4  1 5 ];
T = [ 0 1 0 1 0 1  0 1 ]; %salida binaria para dibujar
T2 = [ -1 1 -1 1 -1 1  -1 1 ]; % salida bipolar para tansig

[entradas, CantPatrones] = size(X);

b = 0.01; W = [0.01 0.01];
% W = rand(1,4);     % W = [W1 W2 W3 W4]
% b = rand;       % esto es el bias o W0

Alfa = 0.05;
MAX_ITE = 1000;
Cota = 0.001;

b = 0.01; W = [0.01 0.01];

A = Adalaine(X, T2, 'tansig', Alfa, MAX_ITE, Cota);
[W b] = A.Calcular();

salidas = tansig(W * X + b)
feval ( A.Funcion, W * A.Patrones + b)
unos = find(salidas >= 0.8);
menosunos = find(salidas <= -0.8);

salidas(unos)=1;
salidas(menosunos)=-1;

IgualesExactas = sum(T2 == salidas)
Parecidas = sum(abs(T2-salidas) < 0.2)





