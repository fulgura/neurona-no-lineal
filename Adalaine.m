classdef Adalaine  < handle
    %PERCEPTRON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        W
    end
    
    properties (SetAccess = private)
        Patrones
        Clase
        Funcion
        Alfa
        MaxIteracion
        Cota
        CantidadEntradas
        CantidadPatrones
        Verbose
    end
    
    methods
        
        function obj = Adalaine(Patrones, Clase, Funcion, Alfa, MaxIteracion, Cota)
            
            obj.Patrones = Patrones;
            obj.Clase = Clase;
            obj.Funcion = Funcion;
            obj.Alfa = Alfa;
            obj.MaxIteracion = MaxIteracion;
            obj.Cota = Cota;
            obj.Verbose = false;
            [obj.CantidadEntradas, obj.CantidadPatrones] = size(obj.Patrones);
            
        end
        
        function patrones = get.Patrones(obj)
            patrones = obj.Patrones;
        end
        
        function clase = get.Clase(obj)
            clase = obj.Clase;
        end
        %% Procesa los patrones y guarda el resultado de cada iteraci?n en
        % un archivo.
        function [W b iteracion] = ProcesarGuardando(obj, filename)
            
            fid = fopen(filename,'w');
            if fid == -1,
                error('Cannot open file');
            end
            
            fprintf(fid, 'Iteracion,Alfa,Cota,Max Cant. Iteraciones,Error Actual,Error Anterior, Diferencia,Iguales, Porc. \n');
            
            
            W = rand(1, obj.CantidadEntradas);
            b = rand;
            
            errorAnterior = 0;
            feval_aplicada = feval ( obj.Funcion, W * obj.Patrones + b);
            error_Act = sum((obj.Clase - feval_aplicada)).^2 / obj.CantidadPatrones;
            iteracion = 0;
            
            while (iteracion < obj.MaxIteracion) & (abs(error_Act - errorAnterior) > obj.Cota)
                
                iteracion = iteracion + 1;
                errorAnterior = error_Act;
                suma_error = 0;
                
                % Para cada vector de entrada
                for patr = 1 : obj.CantidadPatrones
                    
                    neta = W * obj.Patrones(:,patr) + b;
                    % Aplicamos el vector de entrada, X sub k
                    f_neta = feval ( obj.Funcion, neta); % es W * P
                    
                    errorK = obj.Clase(patr) - f_neta;
                    
                    f_prima_neta = feval ( [ 'd' obj.Funcion ], neta, f_neta );
                    
                    % Calcular el gradiente utilizando -2 Error(t) * X
                    gradiente = -2 * errorK * f_prima_neta * obj.Patrones(:, patr);
                    
                    %Actualizar el vector de pesos W(t+1) + 2 uEX
                    W = W - obj.Alfa * gradiente';  % tenemos que cambiarle el signo
                    b = b - obj.Alfa * (-2 * errorK * f_prima_neta);
                    
                    suma_error = suma_error + errorK^2;
                end
                
                error_Act = suma_error / obj.CantidadPatrones;
                [Salidas Iguales] = Adalaine.CalcularResultados(obj.Funcion, obj.Patrones, obj.Clase, W, b);
                fprintf(fid, '%d,%1.4f,%1.6f,%d,%1.6f,%1.6f,%1.6f,%d,%2.2f\n',iteracion, obj.Alfa, obj.Cota, obj.MaxIteracion, error_Act, errorAnterior, abs(error_Act - errorAnterior),Iguales, (Iguales / obj.CantidadPatrones) * 100);
            end
            
            fclose(fid);
        end
        %% Procesa los patrones con los que fu? creada la neurona no
        % lineal.
        function [W b iteracion] = Procesar(obj)
            
            W = rand(1, obj.CantidadEntradas);
            b = rand;
            
            errorAnterior = 0;
            feval_aplicada = feval ( obj.Funcion, W * obj.Patrones + b);
            error_Act = sum((obj.Clase - feval_aplicada)).^2 / obj.CantidadPatrones;
            iteracion = 0;
            
            while (iteracion < obj.MaxIteracion) & (abs(error_Act - errorAnterior) > obj.Cota)
                
                iteracion = iteracion + 1;
                errorAnterior = error_Act;
                suma_error = 0;
                
                % Para cada vector de entrada
                for patr = 1 : obj.CantidadPatrones
                    
                    neta = W * obj.Patrones(:,patr) + b;
                    % Aplicamos el vector de entrada, X sub k
                    f_neta = feval ( obj.Funcion, neta); % es W * P
                    
                    errorK = obj.Clase(patr) - f_neta;
                    
                    f_prima_neta = feval ( [ 'd' obj.Funcion ], neta, f_neta );
                    
                    % Calcular el gradiente utilizando -2 Error(t) * X
                    gradiente = -2 * errorK * f_prima_neta * obj.Patrones(:, patr);
                    
                    %Actualizar el vector de pesos W(t+1) + 2 uEX
                    W = W - obj.Alfa * gradiente';  % tenemos que cambiarle el signo
                    b = b - obj.Alfa * (-2 * errorK * f_prima_neta);
                    
                    suma_error = suma_error + errorK^2;
                    
                end
                
                error_Act = suma_error / obj.CantidadPatrones;
                if obj.Verbose
                    [Salidas IgualesExactas Parecidas] = Adalaine.CalcularResultados(obj.Funcion, obj.Patrones, obj.Clase, W, b);
                    fprintf('%d,%1.4f,%1.6f,%d,%1.6f,%1.6f,%1.6f,%d,%d\n',iteracion, obj.Alfa, obj.Cota, obj.MaxIteracion, error_Act, errorAnterior, abs(error_Act - errorAnterior),IgualesExactas, Parecidas);
                    
                end
            end
            
        end
    end
    methods(Static)
        function [Salidas IgualesExactas Parecidas] = CalcularResultados(funcion, Patrones, Clase, W, b)
            
            if strcmp(funcion, 'tansig') == 1

                Salidas = feval ('tansig', W * Patrones + b);
                unos = Salidas >= 0.8;
                menosunos = Salidas <= -0.8;
                
                Salidas(unos) = 1;
                Salidas(menosunos) = -1;
                
                IgualesExactas = sum(Clase == Salidas);
                Parecidas = sum(abs(Clase - Salidas) < 0.2);
                
            else
                Salidas = feval ('logsig', W * Patrones + b);
                unos = Salidas >= 0.8;
                ceros = Salidas <= 0.2;
                
                Salidas(unos) = 1;
                Salidas(ceros) = 0;
                
                IgualesExactas = sum(Clase == Salidas);
                Parecidas = sum(abs(Clase - Salidas) < 0.2);
                
            end
            
        end
    end
end

