clear all;
clc;

T = [ -1 -1	1 1;
    -1 1 -1 1];

funcion = 'logsig';

feval_aplicada = feval ( funcion, T )

