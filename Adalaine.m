classdef Adalaine  < handle
    %PERCEPTRON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    properties (SetAccess = private)
        Patrones
        Clase
        Alfa
        MaxIteracion
        Cota
    end
    
    methods
        
        function obj = Adalaine(Patrones, Clase, Alfa, MaxIteracion, Cota)
           obj.Patrones = Patrones;
           obj.Clase = Clase;
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
    end
end

