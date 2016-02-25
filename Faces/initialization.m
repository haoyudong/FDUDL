% =========================================================================
%              Initialize Dictioanary Randomly and Cluster Data 
% =========================================================================
%    K, ...         the number of atoms in a sub-dictionary              
%    S, ...         sparse level constraint
K = 14;
S = 4;

total = size(Data, 2);
perm = randperm(total);

% initialize dict randomly
Dict = cell(1,C);
for i = 1:C
    Dict{i} = Data(:, perm((i-1)*K+1:i*K));
end

for i = 1:C
    Dict{i} = DictNormalize(Dict{i});
end


% using dict to cluster data 

T = zeros(total, 1);
for t = 1:total
	temp = zeros(C,1);
	for i = 1:C
        a = OMP(Dict{i},Data(:,t),S); 
        temp(i) = sum(abs(Data(:,t)-Dict{i}*a));
    end
	pos = find(temp == min(temp));
	pos = pos(1);
    T(t) = pos;	
end

% calculate the initial accuracy
class = getclass(Data, T, C);
accuracy(label,T)




