function D = DictNormalize(D)
%=============================================
% normalize the dictionary
% input arguments: 
%       D - the dictionary 
% output arguments: 
%       D - the dictionary be normalized
%=============================================
sumDictElems = sum(abs(D));
zerosIdx = find(sumDictElems < eps);
D(:,zerosIdx) = randn(size(D,1),length(zerosIdx));
D = D*diag(1./sqrt(sum(D.*D)));


  