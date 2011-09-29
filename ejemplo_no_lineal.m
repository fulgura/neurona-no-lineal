clear
clc
%==========  Areas de grafico ===========
figure(1), 
set(1,'Position',[400 400 700 300])

%====== muestras ======
X = [ 2 3 1 3 0 2 -1 2 ;
      2 1 0 3 1 4  1 5 ];
T = [ 0 1 0 1 0 1  0 1 ]; %salida binaria para dibujar
T2 = [ -1 1 -1 1 -1 1  -1 1 ]; % salida bipolar para tansig

[entradas, CantPatrones] = size(X);

b = 0.01; W = [0.01 0.01];

Grafico3D(X,T,W,b, 'tansig');

alfa = 0.05;
MAX_ITE = 1000;
cota = 0.000001;
error_Ant = 0;
error_Act = sum((T2 - tansig(W*X+b))).^2 / CantPatrones;
ite = 0;

while (ite < MAX_ITE) & (abs(error_Act - error_Ant) > cota)

    ite = ite + 1;
    error_Ant = error_Act;
    suma_error = 0;
    
    for patr = 1 : CantPatrones
    
        salida = tansig(W*X(:,patr) + b);
        errorK = T2(patr) - salida;
        gradiente = -2*errorK*(1 - salida^2)*X(:, patr);%ir al reves del gradiente
        W = W - alfa * gradiente';  % tenemos que cambiarle el signo
        b = b - alfa * (-2*errorK*(1 - salida^2)); 
        suma_error = suma_error + errorK^2;
    
    end
    
    error_Act = suma_error / CantPatrones;
    [(error_Act - error_Ant) ite]
    
    Grafico3D(X,T,W,b, 'tansig');
end


% -- la neurona no lineal ya est? entrenada
salidas = tansig(W*X+b);
unos = find(salidas >= 0.8);
menosunos = find(salidas <= -0.8);
salidas(unos)=1;
salidas(menosunos)=-1;

IgualesExactas = sum(T2 == salidas)
Parecidas = sum(abs(T2-salidas) < 0.2)





