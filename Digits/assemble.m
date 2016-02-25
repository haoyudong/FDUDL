function k = assemble( Dict, x, S )
% Compute cluster label using the dictionary for a piece of data
%
%   Input  : Dict : dictionary 
%            x : a piece of data 
%            S : sparse level constraint
%   Output : k : cluster label of data

C = length(Dict);
temp = zeros(C, 1);
for i = 1:C
	a = OMP(Dict{i},x,S);
	temp(i) = sum(abs(x-Dict{i}*a));
end
pos = find(temp == min(temp));
k = pos(1);
end

