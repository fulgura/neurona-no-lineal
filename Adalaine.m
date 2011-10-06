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
        
        function [W b iteracion] = Calcular(obj)
            
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
                    
                    % Aplicamos el vector de entrada, X sub k
                    salida = feval ( obj.Funcion, W * obj.Patrones(:,patr) + b); 
                    errorK = obj.Clase(patr) - salida;
                    
                    derivada = feval ( [ 'd' obj.Funcion ],   W * obj.Patrones(:,patr) + b, salida );
                    
                    % Calcular el gradiente utilizando -2 Error(t) * X
                    gradiente = -2 * errorK * derivada * obj.Patrones(:, patr);
                    
                    %Actualizar el vector de pesos W(t+1) + 2 uEX
                    W = W - obj.Alfa * gradiente';  % tenemos que cambiarle el signo
                    b = b - obj.Alfa * (-2 * errorK * derivada);
                    
                    suma_error = suma_error + errorK^2;
                    
                end
                
                error_Act = suma_error / obj.CantidadPatrones;
                [error_Act errorAnterior (error_Act - errorAnterior) iteracion]
                
            end
            
        end
    end
end

