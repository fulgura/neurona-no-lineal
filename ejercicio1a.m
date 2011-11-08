%% Calculo de los mejores par?metros de la neurona no lineal.

clear
clear all
clc

%Convertimos a tansig los datos
adalaineDataset = csvread('drug5.csv');
adalaineDataset((adalaineDataset(:,7) == 1),7) = 1;
adalaineDataset((adalaineDataset(:,7) ~= 1),7) = -1;

%% Preparamos los datos para procesar. De lo aprendido en el TP sabemos que tenemos que escalar los datos.
DatosOriginales = adalaineDataset;
ColumnaDesdeAtributos = 1;
ColumnaHastaAtributos = 6;
ColumnaClase = 7;
Datos = DatosOriginales;

[CantidadPatrones, CantidadAtributos] = size(Datos);

%% ADS = ConjuntoDatos(adalaineDataset, 1, 6, 7);
patrones = Datos(:, ColumnaDesdeAtributos:ColumnaHastaAtributos);
clase = Datos(:, ColumnaClase);


%% ADS.Escalar
for index=ColumnaDesdeAtributos:ColumnaHastaAtributos
    minimo = min(Datos(:, index));
    maximo = max(Datos(:, index));
    Datos(:,index) = ((Datos(:,index) - minimo) ./ (maximo - minimo));
end



%% Definimos los par?metros
Alfa = 0.4;
MaxIteraciones = 2000;
CotaError = 0.00001;
Funcion = 'logsig';

%% Empieza el experimento
fid = fopen('Salidas/Ejercicio1a.csv','w');

fprintf(' Alfa, CotaError, MaxIteraciones, iteracion, Cantidad Patrones Training, Iguales Exactas Training, Parecidas Training,Eficiencia Training,Cantidad Patrones Test,Iguales Exactas Test,Parecidas Test, Eficiencia Test\n');
fprintf(fid,' Alfa, CotaError, MaxIteraciones, iteracion, Cantidad Patrones Training, Iguales Exactas Training, Parecidas Training,Eficiencia Training,Cantidad Patrones Test,Iguales Exactas Test,Parecidas Test, Eficiencia Test\n');

for i = 1 : 10
    
    %% ADS.Mezclar;
    mezcla = randperm(CantidadPatrones);
    Datos = Datos(mezcla,:);
    
    %% [Training Test] = ADS.Separar(0.8);
    porcentaje = 0.8;
    sizeM = size(Datos);
    CantPatrones = sizeM(1);
    n = floor(CantPatrones*porcentaje);
    
    Training = Datos(1:n,:);
    sizeTraining = size(Training);
    TrainingCantidadPatrones = sizeTraining(1);
    
    Test = Datos((n+1):CantPatrones,:);
    sizeTest = size(Test);
    TestCantidadPatrones = sizeTest(1);

    %% A = Adalaine(Training.Patrones', Training.Clase', ...
    %                funcion, Alfa, MaxIteraciones, CotaError);
    % [W b iteracion] = A.Procesar();
    
    [W b iteracion] = AdalaineProcesar(Training(:,1:6)', Training(:,7)', Funcion, Alfa, MaxIteraciones, CotaError);
    
    
    [Salidas IgualesExactas Parecidas] = AdalaineCalcularResultados(Funcion, ...
                                                                    Training(:,1:6)', ...
                                                                    Training(:,7)', ...
                                                                    W, ...
                                                                    b);
                                    
    [SalidasTest IgualesExactasTest ParecidasTest] = AdalaineCalcularResultados(Funcion, ...
                                                                              Test(:,1:6)', ...
                                                                              Test(:,7)', ...
                                                                              W, ...
                                                                              b);
    
    
    
    fprintf('%1.4f,%1.6f,%d,%d,%d,%d,%d,%1.4f,%d,%d,%d,%1.4f\n', Alfa, CotaError, MaxIteraciones, iteracion, TrainingCantidadPatrones, IgualesExactas, Parecidas,IgualesExactas/TrainingCantidadPatrones,TestCantidadPatrones,IgualesExactasTest,ParecidasTest,IgualesExactasTest/TestCantidadPatrones);
    
    fprintf(fid,'%1.4f,%1.6f,%d,%d,%d,%d,%d,%1.4f,%d,%d,%d,%1.4f\n', Alfa, CotaError, MaxIteraciones, iteracion, TrainingCantidadPatrones, IgualesExactas, Parecidas,IgualesExactas/TrainingCantidadPatrones,TestCantidadPatrones,IgualesExactasTest,ParecidasTest,IgualesExactasTest/TestCantidadPatrones);
    
end

fclose(fid);

fprintf('FIN\n');

