clear all;
clc;

T = [ -1 -1	1 1;
    -1 1 -1 1];

funcion = 'logsig';

feval_aplicada = feval ( funcion, T );


funcion = 'tansig';
netah = -4:0.1:4; 
plot(netah);
salidah = feval ( funcion, netah ); 
plot(netah,salidah)

feval ( [ 'd' 'tansig' ], netah, salidah )


