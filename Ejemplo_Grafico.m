clear
clc
%==========  Areas de grafico ===========
figure(1), 
set(1,'Position',[400 400 700 300])

%====== muestras ======
X = [ 2 3 1 3 0 2 -1 2 ;
      2 1 0 3 1 4  1 5 ];
T = [ 0 1 0 1 0 1  0 1 ];
T2 = [ -1 1 -1 1 -1 1  -1 1 ];
[entradas, CantPatrones] = size(X);

b = 0.01; W(1) = 0.01;  W(2) = 0.01;

Grafico3D(X,T,W,b, 'purelin');

