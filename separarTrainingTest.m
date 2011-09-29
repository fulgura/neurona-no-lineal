function [ training, test ] = separarTrainingTest( M, percentaje )
%separarTrainingTest Toma la matriz M y genera dos nuevas matrices para
%training y test. La separaci?n la hace por el porcentaje psado como
%par?metros
% 
% 

sizeM = size(M);
CantPatrones = sizeM(1);

n = floor(CantPatrones*percentaje);

training = M(1:n,:);
test = M((n+1):CantPatrones,:);

end

