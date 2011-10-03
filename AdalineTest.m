clear
clear all
clc


C = ConjuntoDatos('sample.csv', 1, 2, 3);

Alfa = 0.05;
MAX_ITE = 1000;
Cota = 0.000001;

A = Adalaine(C.Patrones, C.Clase, Alfa, MAX_ITE, Cota);
