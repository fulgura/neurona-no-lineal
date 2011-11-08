function [W b iteracion] = AdalaineProcesar(Patrones, Clase, Funcion, Alfa, MaxIteracion, Cota)

[CantidadEntradas, CantidadPatrones] = size(Patrones);

W = rand(1, CantidadEntradas);
b = rand;

errorAnterior = 0;
feval_aplicada = feval ( Funcion, W * Patrones + b);
error_Act = sum((Clase - feval_aplicada)).^2 / CantidadPatrones;
iteracion = 0;

while (iteracion < MaxIteracion) & (abs(error_Act - errorAnterior) > Cota)
    
    iteracion = iteracion + 1;
    errorAnterior = error_Act;
    suma_error = 0;
    
    % Para cada vector de entrada
    for patr = 1 : CantidadPatrones
        
        neta = W * Patrones(:,patr) + b;
        % Aplicamos el vector de entrada, X sub k
        f_neta = feval ( Funcion, neta); % es W * P
        
        errorK = Clase(patr) - f_neta;
        
        f_prima_neta = feval ( [ 'd' Funcion ], neta, f_neta );
        
        % Calcular el gradiente utilizando -2 Error(t) * X
        gradiente = -2 * errorK * f_prima_neta * Patrones(:, patr);
        
        %Actualizar el vector de pesos W(t+1) + 2 uEX
        W = W - Alfa * gradiente';  % tenemos que cambiarle el signo
        b = b - Alfa * (-2 * errorK * f_prima_neta);
        
        suma_error = suma_error + errorK^2;
        
    end
    
    error_Act = suma_error / CantidadPatrones;
end

end
