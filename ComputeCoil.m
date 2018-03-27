function c = ComputeCoil(N,Z,X,d,shape)
% coefficient for circular coil
if(shape==1)
alpha = 4*pi*10^-7*d^2/2;
end;
% coefficient for square coil
if(shape==2)
alpha =  8*sqrt(2)*10^-7/d;
end;
% coefficient for hexagonal coil
if(shape==3)
alpha = 2.598*2*10^-7*d^2;
end;

% Location of coils 
LOC = loc(N,Z,d);
% outer loop evaluates magnetic field at the equi-potential points
% inner loop iterates over each coil
% This loop produces a matrix of rows which contains each equipotential
% points and columns of field due to each coils at this points

for i=1:length(X)
    for j=1:length(LOC)
        %% Equation for circular coil
        if(shape==1)
        Mat(i,j) = alpha/((d^2+(LOC(j)+X(i))^2)^1.5);
        end;
        %% Equation of square coil
        if(shape==2)
        Mat(i,j) = alpha/((1+4*((LOC(j)+X(i)).^2)./d^2).*(1+2*((LOC(j)+X(i)).^2)./d^2).^0.5);
        end;
        %% Equation of Hexagonal coil
        if(shape==3)
        Mat(i,j) = alpha/((0.7499*d^2+(LOC(j)+X(i)).^2).*(d^2+(X(i)+LOC(j)).^2).^0.5);
        end;
    end;
end;

for i=1:floor(N/2)
    EQ(:,i) = Mat(:,i)+Mat(:,N+1-i);
end;
if(mod(N,2)==1)
    EQ(:,i+1) = Mat(:,round(N/2));
end;

a = EQ(:,1:size(EQ,2)-1);
b = EQ(:,size(EQ,2));

A = a - ones(size(a,1),1)*a(round(N/2),:);
B = b(round(N/2)) - b;

A = A(1:round(N/2)-1,:);
B = B(1:round(N/2)-1);

C = pinv(A)*B;
C(length(C)+1)= 1;
if(length(C)==2)
    c = fliplr(C);
else
c  =  flipud(C);
end;
%disp(c);
end

% verfied for square and circular coil systems