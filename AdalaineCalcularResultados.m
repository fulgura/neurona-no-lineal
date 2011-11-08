function [Salidas IgualesExactas Parecidas] = AdalaineCalcularResultados(funcion, Patrones, Clase, W, b)

if strcmp(funcion, 'tansig') == 1
    
    Salidas = feval ('tansig', W * Patrones + b);
    unos = Salidas >= 0.8;
    menosunos = Salidas <= -0.8;
    
    Salidas(unos) = 1;
    Salidas(menosunos) = -1;
    
    IgualesExactas = sum(Clase == Salidas);
    Parecidas = sum(abs(Clase - Salidas) < 0.2);
    
else
    Salidas = feval ('logsig', W * Patrones + b);
    unos = Salidas >= 0.8;
    ceros = Salidas <= 0.2;
    
    Salidas(unos) = 1;
    Salidas(ceros) = 0;
    
    IgualesExactas = sum(Clase == Salidas);
    Parecidas = sum(abs(Clase - Salidas) < 0.2);
    
end

end
