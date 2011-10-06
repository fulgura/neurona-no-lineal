clear
clear all
clc


%====== muestras ======
X = [ 2 3 1 3 0 2 -1 2 ;
      2 1 0 3 1 4  1 5 ];
T = [ 0 1 0 1 0 1  0 1 ]; %salida binaria para dibujar
T2 = [ -1 1 -1 1 -1 1  -1 1 ]; % salida bipolar para tansig

dataset = csvread('drug5.csv');
C = ConjuntoDatos(dataset, 1, 2, 3);

drogaY = 1;

[CantidadFilas, CantidadColumnas] = size(dataset);
P = dataset(:,1:CantidadColumnas - 1);
T = dataset(:,CantidadColumnas);  

indicesUno = find(T == drogaY);
indicesMenosUno = find(T ~= drogaY);
T(indicesUno) = 1;
T(indicesMenosUno) = -1;

P = P';
T = T';

[entradas, CantPatrones] = size(P);


Alfa = 0.05;
MAX_ITE = 1000;
Cota = 0.0001;


A = Adalaine(P, T, 'tansig', Alfa, MAX_ITE, Cota);

[W b iteracion] = A.Calcular();


salidas = feval ( A.Funcion, W * A.Patrones + b);
unos = find(salidas >= 0.8);
menosunos = find(salidas <= -0.8);

salidas(unos)=1;
salidas(menosunos)=-1;

IgualesExactas = sum(T == salidas)
Parecidas = sum(abs(T - salidas) < 0.2)





