clear
clear all
clc

dataset = csvread('sample.csv');

%Convertimos a tansig loos datos
[CantidadFilas, CantidadColumnas] = size(dataset);


indicesUno = find(dataset(:,CantidadColumnas) == 1);
indicesMenosUno = find(dataset(:,CantidadColumnas) ~= 0);

dataset(indicesUno,CantidadColumnas) = 1;
dataset(indicesMenosUno,CantidadColumnas) = -1;


C = ConjuntoDatos(dataset, 1, 2, 3);
C.Clase
C.Patrones
C.Datos
C.Escalar
C.Datos
C.Recargar
C.Datos
C.Mezclar
C.EscalarColumnas(2,2)
C.Datos
