clear
clear all
clc

%==========  Areas de grafico ===========
% figure(1),
% set(1,'Position',[400 400 700 300])

%====== muestras ======
X = [ 2 3 1 3 0 2 -1 2 ;
      2 1 0 3 1 4  1 5 ];
T = [ 0 1 0 1 0 1  0 1 ]; %salida binaria para dibujar
T2 = [ -1 1 -1 1 -1 1  -1 1 ]; % salida bipolar para tansig
[entradas, CantPatrones] = size(X);


%Convertimos a tansig loos datos
% adalaineDataset = csvread('adalaine-dataset.csv');
adalaineDataset = csvread('drug5.csv');
adalaineDataset((adalaineDataset(:,7) == 1),7) = 1;
adalaineDataset((adalaineDataset(:,7) ~= 1),7) = -1;

ADS = ConjuntoDatos(adalaineDataset, 1, 6, 7);
ADS.Escalar;
[Training Test] = ADS.Separar(0.8);

A = Adalaine(Training.Patrones', Training.Clase', 'tansig', 0.03, 100, 0.00001);

[W b iteracion] = A.Procesar();

% [Salidas IgualesExactas Parecidas] = Training.CalcularResultadosTansig(W, b);
% 
% iteracion 
% IgualesExactas
% Parecidas

salidas = feval ( A.Funcion, W * Training.Patrones' + b);
unos = find(salidas >= 0.8);
menosunos = find(salidas <= -0.8);

salidas(unos)=1;
salidas(menosunos)=-1;

IgualesExactas = sum(Training.Clase' == salidas)
Parecidas = sum(abs(Training.Clase' - salidas) < 0.2)


salidas = feval ( A.Funcion, W * Test.Patrones' + b);
unos = find(salidas >= 0.8);
menosunos = find(salidas <= -0.8);

salidas(unos)=1;
salidas(menosunos)=-1;

IgualesExactas = sum(Test.Clase' == salidas)
Parecidas = sum(abs(Test.Clase' - salidas) < 0.2)




