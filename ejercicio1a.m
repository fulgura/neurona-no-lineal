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
CotaError = 0.00001;
funcion = 'logsig';

%% Empieza el experimento
fid = fopen('Salidas/Ejercicio1a.csv','w');

fprintf(' Alfa, CotaError, MaxIteraciones, iteracion, Cantidad Patrones Training, Iguales Exactas Training, Parecidas Training,Eficiencia Training,Cantidad Patrones Test,Iguales Exactas Test,Parecidas Test, Eficiencia Test\n');
fprintf(fid,' Alfa, CotaError, MaxIteraciones, iteracion, Cantidad Patrones Training, Iguales Exactas Training, Parecidas Training,Eficiencia Training,Cantidad Patrones Test,Iguales Exactas Test,Parecidas Test, Eficiencia Test\n');

for i = 1 : 10
    
    ADS.Mezclar;
    [Training Test] = ADS.Separar(0.8);
    
    A = Adalaine(Training.Patrones', Training.Clase', ...
                    funcion, Alfa, MaxIteraciones, CotaError);
    
    [W b iteracion] = A.Procesar();
    
    [Salidas ...
     IgualesExactas ...
     Parecidas] = Adalaine.CalcularResultados(funcion, ...
                                        Training.Patrones', ...
                                        Training.Clase', ...
                                        W, ...
                                        b);
                                    
    [SalidasTest ...
     IgualesExactasTest ...
     ParecidasTest] = Adalaine.CalcularResultados(funcion, ...
                                                  Test.Patrones', ...
                                                  Test.Clase', ...
                                                  W, ...
                                                  b);
                                              
    fprintf('%1.4f,%1.6f,%d,%d,%d,%d,%d,%1.4f,%d,%d,%d,%1.4f\n', Alfa, CotaError, MaxIteraciones, iteracion, Training.CantidadPatrones, IgualesExactas, Parecidas,IgualesExactas/Training.CantidadPatrones,Test.CantidadPatrones,IgualesExactasTest,ParecidasTest,IgualesExactasTest/Test.CantidadPatrones);
    
    fprintf(fid,'%1.4f,%1.6f,%d,%d,%d,%d,%d,%1.4f,%d,%d,%d,%1.4f\n', Alfa, CotaError, MaxIteraciones, iteracion, Training.CantidadPatrones, IgualesExactas, Parecidas,IgualesExactas/Training.CantidadPatrones,Test.CantidadPatrones,IgualesExactasTest,ParecidasTest,IgualesExactasTest/Test.CantidadPatrones);
    
end

fclose(fid);

fprintf('FIN\n');

