function Grafico3D(X,T2,W,b, Fun) 
BORDE = 1; % le da un borde de 1 unidad en cada eje
PASO = 25; % dibuja 25 cortes para cada eje.
entradas = size(X,1);
if (entradas==2),
    minis = min(X, [], 2)' - BORDE;  %min(limites);
    maxis = max(X, [], 2)' + BORDE;  %max(limites);
    rangos = maxis-minis;  % rango de c/ atributo
    pasos = rangos/PASO; 
    for atrib=1:entradas
      Ejes(atrib,:) = [minis(atrib):pasos(atrib):maxis(atrib)];
    end

    %Sólo puede haber 2 clases
    mayor = max(T2);
    unos = find(T2==mayor);
    T = zeros(1,length(T2));
    T(unos)=1;
    subplot(1,2,1), plotpv(X,T)

    Ptos3D = cat(1,X,T2);
    P0 = (T2~=1);    P1 = (T2==1);
    subplot(1,2,2), 
    hold off
    plot3(Ptos3D(1,P0),Ptos3D(2,P0),Ptos3D(3,P0),'o',Ptos3D(1,P1),Ptos3D(2,P1),Ptos3D(3,P1),'+' ),
    axis([minis(1) maxis(1) minis(2) maxis(2) min(T2)-1 2]);
    hold on
    %--- Funcion discriminante inicial ---
    subplot(1,2,1), 
    linea=plotpc(W,b);   % Corte de la función discriminante en Z=0

    [x1,x2] = meshgrid(Ejes(1,:), Ejes(2,:));
    FuncDiscriminante3D = feval(Fun, W(1)*x1 + W(2)*x2 + b * ones(size(x1)));

    subplot(1,2,2), mesh(x1,x2,FuncDiscriminante3D);
    pause(0.01)
end