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
    end
    
    methods
        
        function obj = Adalaine(Patrones, Clase, Funcion, Alfa, MaxIteracion, Cota)
            
            obj.Patrones = Patrones;
            obj.Clase = Clase;
            obj.Funcion = Funcion;
            obj.Alfa = Alfa;
            obj.MaxIteracion = MaxIteracion;
            obj.Cota = Cota;
            [obj.CantidadEntradas, obj.CantidadPatrones] = size(obj.Patrones);
            
        end
        
        function patrones = get.Patrones(obj)
            patrones = obj.Patrones;
        end
        
        function clase = get.Clase(obj)
            clase = obj.Clase;
        end
        
        function [W b iteracion] = Procesar(obj)
            
            W = rand(1, obj.CantidadEntradas);
            b = rand;
            
            %             Grafico3D(obj.Patrones,obj.Clase,W,b, 'tansig');
            
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
                %[error_Act errorAnterior abs(error_Act - errorAnterior) iteracion]
                %                 Grafico3D(obj.Patrones,obj.Clase,W,b, 'tansig');
            end
            
        end
    end
    methods(Static)
        function [Salidas IgualesExactas Parecidas] = CalcularResultadosTansig(Patrones, Clase, W, b)
            
            Salidas = feval ('tansig', W * Patrones + b);
            unos = find(Salidas >= 0.8);
            menosunos = find(Salidas <= -0.8);
            
            Salidas(unos) = 1;
            Salidas(menosunos) = -1;
            
            IgualesExactas = sum(Clase == Salidas);
            Parecidas = sum(abs(Clase - Salidas) < 0.2);
        end
    end
end

