%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                           %%%
%%%       Wolfe's Line Search Algorithm       %%%
%%%         (P) minimize f(x+alpha*d)         %%%
%%%    arguments                              %%%
%%%    f  - symbolic scalar function          %%%
%%%    x0 - numeric initial point             %%%
%%%    d  - search direction                  %%%
%%%    epsilon - bound for gradient           %%%
%%%    eta - factor to increase alpha         %%%
%%%                                           %%%
%%%    Author: Harrison Watts                 %%%
%%%                                           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function alpha = wolfe(f,x0,d,epsilon,eta)
    
    % epsilon = 1/2
    if(~exist('epsilon')) epsilon = 1/2;
    end
    
    % eta = 2
    if(~exist('eta'))    eta = 2;
    end
    
    % convert for symbolic use
    x0c = num2cell(x0);
    
    % initial alpha
    alpha = 1;

    % starting objective value
    phi_0 = f(x0c{:});
    
    % alpha derivative
    g = gradient(f);
    
    phi_prime_0 = g(x0c{:})'*d;
    
    % while condition is not met
    condition_met = 0;
    
    while ~condition_met
        
        % new location
        xc = num2cell(x0+alpha*d);
        
        % objective function value
        phi = double(f(xc{:}));
        
        % Armijo's rule
        armijos_rule = double(phi_0 + epsilon*phi_prime_0*alpha);

        condition_met = (phi <= armijos_rule);
        
        % alpha is too large
        if ~condition_met
            
            alpha = alpha/(3*eta);
            
            % Armijo's rule
            armijos_rule = double(phi_0 + epsilon*phi_prime_0*alpha);
            
            condition_met = (phi <= armijos_rule);
            
        % alpha is too small
        else 
            
            alpha = alpha*2*eta;
            
            % Wolfe condition
            f_prime = g(xc{:});
            
            phi_prime = double(f_prime)'*d;
            
            wolfe_condition = double((1-epsilon)*phi_prime_0);
            
            condition_met = (phi_prime <= wolfe_condition);

        end
        
    end
    
    alpha = alpha;
   
end