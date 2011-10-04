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
    end
    
    methods
        
        function obj = Adalaine(Patrones, Clase, Funcion, Alfa, MaxIteracion, Cota)
           
           obj.Patrones = Patrones;
           obj.Clase = Clase;
           obj.Funcion = Funcion;
           obj.Alfa = Alfa;
           obj.MaxIteracion = MaxIteracion;
           obj.Cota = Cota;
           
        end
        
        function patrones = get.Patrones(obj)
            patrones = obj.Patrones;
        end
        
        function clase = get.Clase(obj)
            clase = obj.Clase;
        end
        
%         function [W b] = Calcular(obj)
%             
%             b = 0.01; 
%             W = [0.01 0.01];
%         end
    end
end

