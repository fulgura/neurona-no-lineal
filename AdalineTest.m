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

Alfa = 0.05;
MAX_ITE = 1000;
Cota = 0.001;

b = 0.01; W = [0.01 0.01];

A = Adalaine(X, T2, 'tansig', Alfa, MAX_ITE, Cota);
A.Calcular()