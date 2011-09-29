function [P T CantPatrones CantAtrib] = leerDatos(filename, desordenados, columnaClase, desdeAtributos, hastaAtributos)
% 
% 
% 

datos = csvread(filename);

if desordenados
    datos = mezclar(datos);
end;

[CantPatrones, CantAtrib] = size(datos);

P = datos(:, desdeAtributos:hastaAtributos);
T = datos(:, columnaClase);