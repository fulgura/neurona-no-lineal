classdef ConjuntoDatos  < handle
    %CONJUNTODATOS Summary of this class goes here
    %   Detailed explanation goes here
    
    % The following properties can be set only by class methods
    properties (SetAccess = private)
        NombreArchivo
        ColumnaDesdeAtributos
        ColumnaHastaAtributos
        ColumnaClase
    end
    properties
        Datos
        CantidadPatrones
        CantidadAtributos
    end
    properties (Dependent = true, SetAccess = private)
        Patrones
        Clase
    end
    methods
        function CD = ConjuntoDatos(NombreArchivo, ColumnaDesdeAtributos, ColumnaHastaAtributos, ColumnaClase)
            CD.NombreArchivo = NombreArchivo;
            CD.ColumnaDesdeAtributos = ColumnaDesdeAtributos;
            CD.ColumnaHastaAtributos = ColumnaHastaAtributos;
            CD.ColumnaClase = ColumnaClase;
            
            CD.Datos = csvread(CD.NombreArchivo);
            
            [CD.CantidadPatrones, CD.CantidadAtributos] = size(CD.Datos);
            
        end
        
        function patrones = get.Patrones(CD)
            patrones = CD.Datos(:, CD.ColumnaDesdeAtributos:CD.ColumnaHastaAtributos);
        end
        
        function clase = get.Clase(CD)
            clase = CD.Datos(:, CD.ColumnaClase);
        end
        
        function Mezclar(obj)
            
            mezcla = randperm(obj.CantidadPatrones);
            obj.Datos = obj.Datos(mezcla,:);
            
        end
        
        function Escalar(CD)
            
            for index=CD.ColumnaDesdeAtributos:CD.ColumnaHastaAtributos
                minimo = min(CD.Datos(:, index));
                maximo = max(CD.Datos(:, index));
                CD.Datos(:,index) = ((CD.Datos(:,index) - minimo) ./ (maximo - minimo));
            end
            
        end
        function Recargar(CD)
            CD.Datos = csvread(CD.NombreArchivo);
            [CD.CantidadPatrones, CD.CantidadAtributos] = size(CD.Datos);
            
        end
        function [Training Test] = separar(CD)
            sizeM = size(CD.Datos);
            CantPatrones = sizeM(1);
            
            n = floor(CantPatrones*percentaje);
            
            Training = M(1:n,:);
            Test = M((n+1):CantPatrones,:);
        end
    end
    
end

