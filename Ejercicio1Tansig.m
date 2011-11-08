%% Calculo de los mejores par?metros de la neurona no lineal.
clear
clear all
clc

%Convertimos a tansig los datos
adalaineDataset = csvread('drug5.csv');
adalaineDataset((adalaineDataset(:,7) == 1),7) = 1;
adalaineDataset((adalaineDataset(:,7) ~= 1),7) = 0;

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

%% Hacemos variaciones de Alfa, Cota Error y M?xima cantidad de iteraciones
%


Alfas = [0.001, 0.005, 0.003, 0.05, 0.1, 0.2, 0.3, 0.4];
Iteraciones = [500, 1000, 1100, 1200, 1300, 1400, 1500, 1600, ...
    1700, 1800, 1900, 2000, 2100,2200, 2300, 2400, 2500, ...
    2600, 2700, 2800, 2900, 3000, 3100,3200, 3300, 3400, ...
    3500, 3600, 3700, 3800, 3900, 4000];
Cotas = [0.0001, 0.001, 0.01, 0.1];
funcion = 'tansig';

fid = fopen('Salidas/Ejercicio1-tansig.csv','w');
if fid == -1,
    error('Cannot open file');
end

fprintf(fid,'Alfa,CotaError,MaxIteraciones,iteracion,Iguales Exactas,Parecidas,Iguales Exactas Test,Parecidas Test\n');

for i = 1 : length(Alfas)
    for j = 1 : length(Iteraciones)
        for k = 1 : length(Cotas)
            
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
            
            Alfa = Alfas(i);
            MaxIteraciones = Iteraciones(j);
            CotaError = Cotas(k);
            
            %%  A = Adalaine(Training.Patrones', Training.Clase', funcion, Alfa, MaxIteraciones, CotaError);
            % [W b iteracion] = A.Procesar();
            
            [W b iteracion] = AdalaineProcesar(Training(:,1:6)', Training(:,7)', funcion, Alfa, MaxIteraciones, CotaError);

            
            [Salidas IgualesExactas Parecidas] = AdalaineCalcularResultados(funcion, Training(:,1:6)', Training(:,7)', W, b);
            [SalidasTest IgualesExactasTest ParecidasTest] = AdalaineCalcularResultados(funcion, Test(:,1:6)', Test(:,7)', W, b);
            
            fprintf(fid,'%1.4f,%1.6f,%d,%d,%d,%d,%d,%d\n', Alfa, CotaError, MaxIteraciones, iteracion, IgualesExactas, Parecidas,IgualesExactasTest,ParecidasTest);
            fprintf('%1.4f,%1.6f,%d,%d,%d,%d,%d,%d\n', Alfa, CotaError, MaxIteraciones, iteracion, IgualesExactas, Parecidas,IgualesExactasTest,ParecidasTest);
        end
    end
end

fclose(fid);

fprintf('FIN\n');


