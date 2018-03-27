function LOC = loc(N,Z,d)
% gives the location of each coil  
init_loc = -(N-1)*Z*d/2 ;  
for i=1:N                  
    LOC(i) = init_loc;
    init_loc = init_loc + Z*d;
end;
% verified for both odd and even coils
end

% independent of the shape of the coil