function [x,y,z, etiquetas] = CalcularFuncion(NroFuncion)

    switch NroFuncion 
        case 1  % Paraboloide 3x^2+y^2 entre -2 y 2
                %            X      Y
                limites = [ -2     -2 ; 
                             2      2 ];
                PASO = 0.2;
                etiquetas = ['X', 'Y', 'z=3x^2+y^2'];
                [x,y] = meshgrid(limites(1,1):PASO:limites(2,1), limites(1,2):PASO:limites(2,2));
                z = 3* x.^2 +  y.^2;    
            
        case 2  % Volumen del cono
                % cada columna es un atributo distinto
                %          RADIO  ALTURA
                limites = [ -2     -2 ; 
                             2      2 ];
                PASO = 0.2;
                etiquetas = ['Radio', 'Altura', 'Volumen'];
                [x,y] = meshgrid(limites(1,1):PASO:limites(2,1), limites(1,2):PASO:limites(2,2));
                z = (x.^2 .* y .* pi)/3;    %la 3er. coord. corresp. al VOLUMEN
                
        case 3  % Error cuadrático
                limites = [-11 -8; 
                             9 12];
                PASO = 1;         
                etiquetas = ['w0', 'w1', 'Error'];
                [x,y] = meshgrid(limites(1,1):PASO:limites(2,1), limites(1,2):PASO:limites(2,2));
                z = 1/3*((3-2*y-x).^2+(1-y-x).^2+(-3+y-x).^2);
            
                
      otherwise fprintf('NO DEFINIDA!!!');
    end

end