function eff = uniformity(N,C,d,X,LOC,I,flag,shape,flag_3D,tol)
%%
if(shape==1)
alpha = 4*pi*10^-7*I*d^2/2; % Circular coil coefficient (does not include current)
end;

if(shape==2)
alpha = 8*sqrt(2)*10^-7*I/d;
end;

if(shape==3)
alpha = 2.598*2*10^-7*I*d^2;
end;

%%
tolerance = 0.001;

% stores value from end to center 
D = flipud(C);

if(mod(N,2)==1)
    C = C(2:end);
end;

% H stores ampere turns of the coils
H  = cat(1,D,C);
disp(H);

% computes magnetic field at the all points seperated by tolerance and
% situated between extreme equi-potential points

k=1;

for z = X(1):tolerance:X(length(X))
    Mat(k) = 0;
for j=1:length(LOC)
        % computes magnetic field due to each coil at a particular point
        % and sums up in matrics
        % circular coil equation
        
        if(shape==1)
        Mat(k) = Mat(k)+ alpha*H(j)./(((d^2+(LOC(j)+z).^2).^1.5));   
        end;
        
        if(shape==2)
        % square coil equation 
        % square isnt working
        Mat(k) = Mat(k)+ alpha*H(j)./((1+4*((z+LOC(j)).^2)./d^2).*(1+2*((z+LOC(j)).^2)./d^2).^0.5);
        end;
        
        if(shape==3)
        % Hexagonal coil system
        Mat(k) = Mat(k)+alpha*H(j)./((0.7499*d^2+(z+LOC(j)).^2).*(d^2+(z+LOC(j)).^2).^0.5);
        end;
        
end;
k = k+1;
end;
z = X(1):tolerance:X(length(X));
%%
if(flag==1) 
figure,
plot(z,Mat,'Linewidth',2,'color','black');
title('Plot of Magnetic field (in Tesla)');
xlabel('Distance (in meters)');
ylabel('Uniformity')
end;

U = X(1):0.01:X(length(X));
V = U;
[u,v] = meshgrid(U,V);

[ROW,COL] = size(v);

for l = 1:ROW
for i = 1:COL
    Mat_new(l,i)=0;
for j=1:length(LOC)
  %%
        % computes magnetic field due to each coil at a particular point
        % and sums up in matrics
        % circular coil equation
        
        if(shape==1)
        Mat_new(l,i) =Mat_new(l,i)+ alpha*H(j)/((d^2+(LOC(j)+v(l,i)).^2)^1.5);   
        end;
        
        if(shape==2)
        % square coil equation 
        Mat_new(l,i) =Mat_new(l,i)+ alpha*H(j)/((1+4*(LOC(j)+v(l,i)).^2./d^2).*(1+2*(LOC(j)+v(l,i)).^2./d^2).^0.5);
        end;
        
        if(shape==3)
        Mat_new(l,i) = Mat_new(l,i)+alpha*H(j)/((0.7499*d^2+(LOC(j)+v(l,i)).^2).*(d^2+(LOC(j)+v(l,i)).^2).^0.5);
        end;
end;
end;
end;

if(flag_3D ==1)

figure,
surf(u,v,Mat_new);
ylabel('Distance (in meter)');
zlabel('Magnetic field (in Tesla)');
title('Spatial variation of magnetic field')

end;
%%
B = Mat;
disp(max(B))
disp(min(B))
disp(mean(B))
B_center = B(round(length(B)/2));
eff(1) = B_center;
eff(2) = (1-(abs(max(B)-min(B))/abs(mean(B))))*100;
eff(3) = suv(Mat_new,tol);
end
