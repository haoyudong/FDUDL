function [ class ] = getclass( Data, T, C )
%
% [ class ] = getclass( Data, T, C )
%
%  re-range the Data according to their labels
%
%   Input  : T: cluster labels 
%            C: number of Classes 
%            Data: dataset to be clustered
%
%   Output :  class: a cell where each element is a cluster for a class
class = cell(1,C);

for i = 1:C
	class{i} = Data(:,T==i);
end
end

