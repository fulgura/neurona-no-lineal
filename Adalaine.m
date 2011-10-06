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
        
        function [W b] = Calcular(obj)
            b = 0.01;
            W = [0.01 0.01];
            
            error_Ant = 0;
            feval_aplicada = feval ( obj.Funcion, W * obj.Patrones + b);
            error_Act = sum((obj.Clase - feval_aplicada)).^2 / obj.CantidadPatrones;
            ite = 0;
            
            while (ite < obj.MaxIteracion) & (abs(error_Act - error_Ant) > obj.Cota)
                
                ite = ite + 1;
                error_Ant = error_Act;
                suma_error = 0;
                
                for patr = 1 : obj.CantidadPatrones
                    
                    salida = feval ( obj.Funcion, W * obj.Patrones(:,patr) + b);                    
                    errorK = obj.Clase(patr) - salida;
                    
                    gradiente = -2 * errorK * (1 - salida^2) * obj.Patrones(:, patr);%ir al reves del gradiente

                    W = W - obj.Alfa * gradiente';  % tenemos que cambiarle el signo
                    b = b - obj.Alfa * (-2*errorK*(1 - salida^2));

                    suma_error = suma_error + errorK^2;
                    
                end
                
                error_Act = suma_error / obj.CantidadPatrones;
                [error_Act error_Ant (error_Act - error_Ant) ite]
                
            end
            
        end
    end
end

