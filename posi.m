function x = posi(N,V,Z)
    % gives location of equi-potential points as fraction of radius/side 
    
    m = (N-1)*Z*V/100;         
    n = round(N/2);            
    k = 2*n-1;        
    x = linspace(-m/2,m/2,k); 

    % verified for both odd and even coil
end
