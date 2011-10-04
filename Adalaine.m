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
        CantidadDntradas
        CantidadaPatrones
    end
    
    methods
        
        function obj = Adalaine(Patrones, Clase, Funcion, Alfa, MaxIteracion, Cota)
            
            obj.Patrones = Patrones;
            obj.Clase = Clase;
            obj.Funcion = Funcion;
            obj.Alfa = Alfa;
            obj.MaxIteracion = MaxIteracion;
            obj.Cota = Cota;
            [obj.CantidadDntradas, obj.CantidadaPatrones] = size(obj.Patrones);
            
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
            
%             error_Ant = 0;
%             error_Act = sum((T2 - tansig(W*X+b))).^2 / CantPatrones;
%             ite = 0;
%             
%             while (ite < obj.MaxIteracion) & (abs(error_Act - error_Ant) > obj.Cota)
%                 
%                 ite = ite + 1;
%                 error_Ant = error_Act;
%                 suma_error = 0;
%                 
%                 for patr = 1 : CantPatrones
%                     
%                     salida = tansig(W*X(:,patr) + b);
%                     errorK = T2(patr) - salida;
%                     gradiente = -2*errorK*(1 - salida^2)*X(:, patr);%ir al reves del gradiente
%                     W = W - alfa * gradiente';  % tenemos que cambiarle el signo
%                     b = b - alfa * (-2*errorK*(1 - salida^2));
%                     suma_error = suma_error + errorK^2;
%                     
%                 end
%                 
%                 error_Act = suma_error / CantPatrones;
%                 [(error_Act - error_Ant) ite]
%                 
%             end
            
        end
    end
end

