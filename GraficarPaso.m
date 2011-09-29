function GraficarPaso(PtoAnt, PtoAct)
%PtoAnt y PtoAct son de la forma --> [ x y z ]
%son las coordenadas anteriores y actual del pto

    subplot(1,2,1),  
    XL = xlim;
    YL = ylim;
    ZL = zlim;
    menores = [XL(1) YL(1) ZL(1)];
    mayores = [XL(2) YL(2) ZL(2)];
    
    PtoAct1 = max(PtoAct,menores);
    PtoAct1 = min(PtoAct1,mayores);
    
    PtoAnt1 = max(PtoAnt,menores);
    PtoAnt1 = min(PtoAnt1,mayores);
    
    plot3([PtoAnt1(1),PtoAct1(1)],[PtoAnt1(2),PtoAct1(2)],[PtoAnt1(3),PtoAct1(3)],'-r*', 'LineWidth',2);
    
    
    subplot(1,2,2),  
    XL = xlim;
    YL = ylim;
    ZL = zlim;
    menores = [XL(1) YL(1) ZL(1)];
    mayores = [XL(2) YL(2) ZL(2)];
    
    PtoAct2 = max(PtoAct,menores);
    PtoAct2 = min(PtoAct2,mayores);
    
    PtoAnt2 = max(PtoAnt,menores);
    PtoAnt2 = min(PtoAnt2,mayores);
    
    plot([PtoAnt2(1),PtoAct2(1)],[PtoAnt2(2),PtoAct2(2)],'-r*', 'LineWidth',2)
end
