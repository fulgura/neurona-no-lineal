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
%         
%         function Mezclar(CD)
%             
%             mezcla = randperm(CD.CantidadPatrones);
%             CD.Datos = CD.Datos(mezcla,:);
%             
%         end
%         
%         function Escalar(CD)
%             
%             for index=CD.ColumnaDesdeAtributos:CD.ColumnaHastaAtributos
%                 minimo = min(CD.Datos(:, index));
%                 maximo = max(CD.Datos(:, index));
%                 CD.Datos(:,index) = ((CD.Datos(:,index) - minimo) ./ (maximo - minimo));
%             end
%             
%         end
    end
    
end

