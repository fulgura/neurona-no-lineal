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


%% Definimos los par?metros
Alfa = 0.03;
MaxIteraciones = 100;
CotaError = 0.00001;
funcion = 'tansig';

fprintf('Alfa,CotaError,MaxIteraciones,iteracion,Iguales Exactas,Parecidas,Iguales Exactas Test,Parecidas Test\n');


[Training Test] = ADS.Separar(0.8);

A = Adalaine(Training.Patrones', Training.Clase', funcion, Alfa, MaxIteraciones, CotaError);

[W b iteracion] = A.ProcesarGuardando('Salidas/adelaine-test.csv');

[Salidas IgualesExactas Parecidas] = Adalaine.CalcularResultados(funcion, Training.Patrones', Training.Clase', W, b);
[SalidasTest IgualesExactasTest ParecidasTest] = Adalaine.CalcularResultados(funcion, Test.Patrones', Test.Clase', W, b);

fprintf('%1.4f,%1.6f,%d,%d,%d,%d,%d,%d\n', Alfa, CotaError, MaxIteraciones, iteracion, IgualesExactas, Parecidas,IgualesExactasTest,ParecidasTest);

