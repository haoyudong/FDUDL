% =========================================================================
%           Alternately Do Signal Assignment and Dictionary Learning 
% =========================================================================
%    iteration,...      the number of iterations for Alternately Doing Signal Assignment and Dictionary Learning
%    theta1, ...         the trade-off factor between reconstruction and
%                                within-class distermination.
%    theta2, ...         the trade-off factor between reconstruction and
%                                between-class distermination.       
%    K, ...         the number of atoms in a sub-dictionary              
%    S, ...         sparse level constraint
%    numIteration, ...      the number of iterations for Dictionary Learning  


iteration = 100;
params.theta1 = 0; 
params.theta2 = 0; 
params.S = 5;
params.K = 30;
params.numIteration = 80;

finished = 0;  
locked = 0;   

aaa = showEnergy(Dict, class, S, params.theta1, params.theta2);


energy = zeros(iteration,1);
values = zeros(iteration,4);        % energy_r; energy_d1; energy_d2; energy_d
acc = zeros(iteration,1);

for m = 1:iteration   
    
    Dict = FD(class, params);    
    T = zeros(total,1);
    for t = 1:total
        T(t)=assemble(Dict,Data(:,t),S);       
    end   
    class = getclass(Data, T, C);
    
	acc(m) = accuracy(label,T);
    fprintf('\n iteration %d, theta1 = %d, theta2 = %d.\n', m, params.theta1, params.theta2);
    fprintf('accuracy = %.4f.\n', acc(m));	
    [energy(m), values(m,:)] = showEnergy( Dict, class, S, params.theta1,  params.theta2);
    fprintf('energy_r = %.4i, energy_d1 = %.4i, energy_d2 = %.4i\n', values(m,1),  values(m,2),  values(m,3));
    fprintf('energy_reconstruction = %.4i, energy_discriminative = %.4i\n',  values(m,1),  values(m,4));
    fprintf('total energy = %.4i\n', energy(m));
    bbb = energy(m);               
        
    
    if(abs((bbb-aaa)/bbb) < 0.001)
		if(finished < 2)
			finished = finished + 1;			
		else
			if(params.theta2 < 28)
                params.theta1 = params.theta1 + 0.4;
                params.theta2 = params.theta2 + 2;
                finished = 0;
            else
                return
            end 
        end
    elseif(abs((bbb-aaa)/bbb) < 0.01)
		finished = 0;
        if(locked < 4)
            locked = locked + 1;
        else
            if(params.theta2 < 28)
                params.theta1 = params.theta1 + 0.4;
                params.theta2 = params.theta2 + 2;
                locked = 0;
            else
                return
            end   
        end	
    else
		locked = 0;
        finished = 0;  
    end
                
    
    aaa = bbb;          
    
end
     
