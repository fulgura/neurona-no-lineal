%% Calculo de los mejores par?metros de la neurona no lineal.

clear
clear all
clc

%Convertimos a tansig los datos
adalaineDataset = csvread('drug5.csv');
adalaineDataset((adalaineDataset(:,7) == 1),7) = 1;
adalaineDataset((adalaineDataset(:,7) ~= 1),7) = -1;

%% Preparamos los datos para procesar. De lo aprendido en el TP sabemos que tenemos que escalar los datos.
ADS = ConjuntoDatos(adalaineDataset, 1, 6, 7);
ADS.Escalar


%% Definimos los par?metros
Alfa = 0.4;
MaxIteraciones = 2000;
CotaError = 0.0001;
funcion = 'logsig';

%% Empieza el experimento
fid = fopen('Salidas/Ejercicio1a.csv','w');

for i = 1 : 10
    
    ADS.Mezclar;
    [Training Test] = ADS.Separar(0.8);
    
    A = Adalaine(Training.Patrones', Training.Clase', funcion, Alfa, MaxIteraciones, CotaError);
    
    [W b iteracion] = A.Procesar();
    
    [Salidas IgualesExactas Parecidas] = Adalaine.CalcularResultados(funcion, Training.Patrones', Training.Clase', W, b);
    [SalidasTest IgualesExactasTest ParecidasTest] = Adalaine.CalcularResultados(funcion, Test.Patrones', Test.Clase', W, b);
    
    fprintf(fid,'%1.4f,%1.6f,%d,%d,%d,%d,%d,%d,%d,%d\n', Alfa, CotaError, MaxIteraciones, iteracion, Training.CantidadPatrones, IgualesExactas, Parecidas,Test.CantidadPatrones,IgualesExactasTest,ParecidasTest);
    
end

fclose(fid);

fprintf('FIN\n');

