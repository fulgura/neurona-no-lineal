%% Calculo de los mejores par?metros de la neurona no lineal.

clear
clear all
clc

%Convertimos a tansig los datos
adalaineDataset = csvread('drug5.csv');
adalaineDataset((adalaineDataset(:,7) == 1),7) = 1;
adalaineDataset((adalaineDataset(:,7) ~= 1),7) = -1;

%% Preparamos los datos para procesar. De lo aprendido en el TP sabemos que
% tenemos que escalar los datos.

ADS = ConjuntoDatos(adalaineDataset, 1, 6, 7);
ADS.Escalar

%% Hacemos variaciones de Alfa, Cota Error y M?xima cantidad de iteraciones
%

Alfas = [0.4, 0.3, 0.2, 0.1, 0.05, 0.04, 0.03, 0.02, 0.01, 0.001];
Iteraciones = [500, 1000, 1500, 2000, 3000];
Cotas = [0.01, 0.005, 0.0001, 0.00005, 0.000001];

fid = fopen('Ejercicio1.csv','w');
if fid == -1,
    error('Cannot open file');
end

fprintf(fid,'Alfa,CotaError,MaxIteraciones,iteracion,Iguales Exactas,Parecidas,Iguales Exactas Test,Parecidas Test\n');

for i = 1 : length(Alfas)
    for j = 1 : length(Iteraciones)
        for k = 1 : length(Cotas)
            
            ADS.Mezclar;
            [Training Test] = ADS.Separar(0.8);
            
            Alfa = Alfas(i);
            MaxIteraciones = Iteraciones(j);
            CotaError = Cotas(k);
            
            A = Adalaine(Training.Patrones', Training.Clase', 'tansig', Alfa, MaxIteraciones, CotaError);
            
            [W b iteracion] = A.Procesar();
            
            [Salidas IgualesExactas Parecidas] = Adalaine.CalcularResultadosTansig(Training.Patrones', Training.Clase', W, b);
            [SalidasTest IgualesExactasTest ParecidasTest] = Adalaine.CalcularResultadosTansig(Test.Patrones', Test.Clase', W, b);
            
            fprintf(fid,'%1.4f,%1.6f,%d,%d,%d,%d,%d,%d\n', Alfa, CotaError, MaxIteraciones, iteracion, IgualesExactas, Parecidas,IgualesExactasTest,ParecidasTest);
            
        end
    end
end

fclose(fid);



