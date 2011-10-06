clear
clear all
clc

dataset = csvread('sample.csv');

C = ConjuntoDatos(dataset, 1, 2, 3);
C.Clase
C.Patrones
C.Datos
C.Escalar
C.Datos
C.Recargar
C.Datos
C.Mezclar
C.Datos
