function [X0,Y0] = GraficoGradiente(NroFuncion)
% limites = cada columna tiene el mínimo y el máximo de c/atributo
% etiquetas --> ejeX, ejeY, ejeZ
% [CantDatos, CantAtributos] = size(limites);
% if (CantDatos==2) & (CantAtributos==2),
%     PASO = 0.2;

%     [x,y] = meshgrid(limites(1,1):PASO:limites(2,1), limites(1,2):PASO:limites(2,2));
%     [f,c]=size(x);
%     z = zeros(f,c);
%     for i=1:f,
%         for j=1:c,
%             z(i,j) = Funcion(x(i,j), y(i,j));
%         end
%     end
%     
    [x,y,z,etiqu] = CalcularFuncion(NroFuncion);
    figure(1), 
    set(1,'Position',[400 400 700 300])

    subplot(1,2,1), mesh(x,y,z),
    if (length(etiqu)==3),
        xlabel(etiqu(1));
        ylabel(etiqu(2));
        zlabel(etiqu(3));
    end
    hold on

    [pr,ph] = gradient(z,0.2,0.2);
    subplot(1,2,2), contour(x,y,z),
    if (length(etiqu)>=2),
        xlabel(etiqu(1));
        ylabel(etiqu(2));
    end
    hold on, 
    quiver(x,y,pr,ph)

    %------- esto escribe CLICK AQUI centrado ---------
    xPos = get(gca,'xlim');  % [Xmin  Xmax]
    yPos = get(gca,'ylim');  % [Ymin  Ymax]
    aux = text((xPos(2)+xPos(1))*0.5,(yPos(2)+yPos(1))*0.5,'*CLICK AQUI*'); 
    set(aux,'horizontal','center'); % centra el texto respecto del pto indicado arriba
    set(aux,'fontweight','bold');   % negrita
    set(aux,'color',[0 0 0]);       % color negro
    %-------------------------------------------------

    [X0, Y0] = ginput(1);
    delete(aux)    % borra el texto CLICK AQUÍ  
%end