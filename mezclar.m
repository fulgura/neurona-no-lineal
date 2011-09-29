function R = mezclar(M)
%   Mezcla aleatoriamente las filas de la matriz M.
% 
%   Retorna la misma matriz pero desordenada en forma random

sizeM = size(M);
CantPatrones = sizeM(1);
mezcla = randperm(CantPatrones);

R = M(mezcla,:);

