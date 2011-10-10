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
MaxIteraciones = 1000;
CotaError = 0.001;


%% Empieza el experimento 
fid = fopen('Ejercicio1.csv','w');

for i = 1 : 10
    
    ADS.Mezclar;
    [Training Test] = ADS.Separar(0.8);
    A = Adalaine(Training.Patrones', Training.Clase', 'tansig', 0.4, 1000, 0.0001);
    
    [W b iteracion] = A.Procesar();
    
    [Salidas IgualesExactas Parecidas] = Adalaine.CalcularResultadosTansig(Training.Patrones', Training.Clase', W, b);
    [SalidasTest IgualesExactasTest ParecidasTest] = Adalaine.CalcularResultadosTansig(Test.Patrones', Test.Clase', W, b);
    
    fprintf(fid,'%1.4f,%1.6f,%d,%d,%d,%d,%d,%d\n', Alfa, CotaError, MaxIteraciones, iteracion, IgualesExactas, Parecidas,IgualesExactasTest,ParecidasTest);
    fprintf('%1.4f,%1.6f,%d,%d,%d,%d,%d,%d\n', Alfa, CotaError, MaxIteraciones, iteracion, IgualesExactas, Parecidas,IgualesExactasTest,ParecidasTest);
    
end

fclose(fid)

