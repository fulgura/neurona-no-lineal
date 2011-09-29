function [training,test] = trainingTestSplit(M,percentaje)
% 
% 
% 
% 
% 

sizeM = size(M);
CantPatrones = sizeM(1);
mezcla = randperm(CantPatrones);

M = M(mezcla,:);
n = floor(CantPatrones*percentaje);

training = M(1:n,:);
test = M((n+1):CantPatrones,:);


