clear
clear all
clc

%==========  Areas de grafico ===========
figure(1),
set(1,'Position',[400 400 700 300])

%====== muestras ======
X = [ 2 3 1 3 0 2 -1 2 ;
      2 1 0 3 1 4  1 5 ];
T = [ 0 1 0 1 0 1  0 1 ]; %salida binaria para dibujar
T2 = [ -1 1 -1 1 -1 1  -1 1 ]; % salida bipolar para tansig
[entradas, CantPatrones] = size(X);


%Convertimos a tansig loos datos
adalaineDataset = csvread('adalaine-dataset.csv');
adalaineDataset((adalaineDataset(:,3) == 0),3) = -1;
adalaineDataset((adalaineDataset(:,3) == 1),3) = 1;

ADS = ConjuntoDatos(adalaineDataset, 1, 2, 3);
ADS.Patrones
ADS.Clase


A = Adalaine(X, T2, 'tansig', 0.05, 1000, 0.0001);

[W b iteracion] = A.Procesar();
[Salidas IgualesExactas Parecidas] = A.CalcularResultados(W, b)



% salidas = feval ( A.Funcion, W * A.Patrones + b)
% unos = find(salidas >= 0.8);
% menosunos = find(salidas <= -0.8);
% 
% salidas(unos)=1;
% salidas(menosunos)=-1;
% 
% IgualesExactas = sum(T2 == salidas)
% Parecidas = sum(abs(T2-salidas) < 0.2)
% 
% 



