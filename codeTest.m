clc;
clear all;

% Checking the loc.m file %
% file returns the locations of coils%
% code is independent of shape and depends on even and odd
% All simulations are done for unit sidelength/radius
Z = 0.5; d = 1;
N = 5;                        % Checking odd number of coils
_LOC = loc(N,Z,d);
assert(_LOC,[-1.0,-0.5,0,0.5,1.0]);
N = 6;                        % Checking even number of coils
_LOC = loc(N,Z,d);
assert(_LOC,[-1.25,-0.75,-0.25,0.25,0.75,1.25]);


Z = 0.3; d = 5;
N = 5;                        % Checking odd number of coils
_LOC = loc(N,Z,d);
assert(_LOC,[-3.0,-1.5,0,1.5,3.0]);
N = 6;                        % Checking even number of coils
_LOC = loc(N,Z,d);
assert(_LOC,[-3.75,-2.25,-0.75,0.75,2.25,3.75]);
disp("Checking of loc.m is done....")


% Checking the posi.m file %
% file returns position of the equipotential points
% code is independent of shape and depends on odd and even

V=50;Z=0.5;
N = 5;                        % Checking for odd number of coils
_posi = posi(N,V,Z);
assert(_posi,[-0.5,-0.25,0,0.25,0.5]);

V=100;Z=0.6;
N = 6;                        % Checking for odd number of coils
_posi = posi(N,V,Z);
assert(_posi,[-1.5,-0.75,0,0.75,1.5]);

V=50;Z=0.5;
N = 7;                        % Checking for odd number of coils
_posi = posi(N,V,Z);
assert(_posi,[-0.75,-0.5,-0.25,0,0.25,0.5,0.75]);
disp("Checking of posi.m is done....")


% Checking the computeCoil.m file %
% file returns number of turns in each coil
N = 5; Z = 0.25; X = [-0.25,-0.15,0,0.15,0.25]; d=1;
shape = 2;
C = ComputeCoil(N,Z,X,d,shape);
assert(C,[1,0.40849,1.92643]',tol = 0.0001);
disp("Checking of computeCoil.m is done....")
