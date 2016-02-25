function [ energy, values  ] = showEnergy( Dict, class, S, theta1, theta2 )       % energy_r; energy_d1; energy_d2; energy_d

% INPUT ARGUMENTS:
%   Dict             the dictionary for FDUDL
% ¡¡class				a cell where each element is a cluster for a class           
%    S, ...         sparse level constraint
%    theta1, ...         the trade-off factor between reconstruction and
%                                within-class distermination.
%    theta2, ...         the trade-off factor between reconstruction and
%                                between-class distermination.
% =========================================================================
% OUTPUT ARGUMENTS:
%   energy, values to evaluate the performance of our algorithms
% ============
C = length(Dict);
n = size(Dict{1},1);
K = size(Dict{1},2);

energy_r = 0;
energy_d1 = 0;   

for i = 1:C;
	Acoff = OMP(Dict{i}, class{i}, S);
	err = class{i} - Dict{i} * Acoff;
	energy_r = energy_r + sum(sum(err.^2));
end

c = zeros(n,C);
for i = 1:C;
	c(:,i) = mean(Dict{i}, 2);
	err = Dict{i} - repmat(c(:,i),1,K);
	energy_d1 = energy_d1 + sum(sum(err.^2));	
end

cm = mean(c,2);
err = c - repmat(cm,1,C);
energy_d2 = K*sum(sum(err.^2));	
energy_d = theta1*energy_d1 - theta2*energy_d2;

energy = energy_r + energy_d;
values = [energy_r, energy_d1, energy_d2,energy_d];

end

