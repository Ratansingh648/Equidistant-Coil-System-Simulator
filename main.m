clc;
clear all;
close all;

% variables used
% N: number of coils used in system (integer)
% V: percentage volume of interest
% Z: Seperation between the coils
% d: sidelength of the sqaure coil
% I: Current of the central coil
% X: location of the equi-potential points

disp('Enter the shape of the coil::');
disp('(1.) Circular   (2.) Square  (3.) Hexagonal');
shape = input('Answer::');
clc;

N = input('Enter the number of coils::');  
V = input('Enter the percentage length of uniform region::');

if(shape==1)
d = input('Enter the length of radius of circular coil::');
Z_sub = input('Enter the seperation between each coil (as fraction of radius R)::');
Z_dist = Z_sub*d;
end;

if(shape==2)
d = input('Enter the length of side of Square coil::');
Z_sub = input('Enter the seperation between each coil (as fraction of d)::');
Z_dist = Z_sub*d;
end;

if(shape==3)
d = input('Enter the length of side of Hexagonal coil::');
Z_sub = input('Enter the seperation between each coil (as fraction of Height)::')*1.732;
Z_dist = Z_sub*d;
end;

tolerance_suv = input('Enter the percentage tolerance acceptable::');
I = input('Enter the current::');
clc;

disp('Do you want to give locations of points with equal magnitude?::');
disp('(1.) YES   (2.) NO');
response = ones(length(Z_sub))*input('Answer::');

disp('Do you want to see line plot of magnetic field of each system?::');
disp('(1.) YES   (2.) NO');
Line_plot_flag = ones(length(Z_sub))*input('Answer::');

disp('Do you want to see three dimensional plot of magnetic field of each system?::');
disp('(1.) YES   (2.) NO');
Surf_plot_flag = ones(length(Z_sub))*input('Answer::');

clc;

Data1 = [];
Data2 = [];
Data3 = [];

for o = 1:length(Z_sub)
    Z = Z_sub(o);
if(response(o) == 1)
    disp('The number of points required is::');
    disp(2*round(N/2)-1);
    X = input('Enter the above specified points::');
else

X = posi(N,V,Z)*d;
disp('Location of Equipotential points are::')
disp(X);
end;

% LOC: location of the coil with respect to the origin 
% C: number of turns in each coils

LOC = loc(N,Z,d);
C = ComputeCoil(N,Z,X,d,shape);
disp('Positioning of coil in space is::')
disp(LOC);

disp('The Ampere turns starting from center to end are::');
disp(C);

flag = Line_plot_flag(o);
flag_3D = Surf_plot_flag(o);

% EFF: gives uniformity and central magnetic field
EFF = uniformity(N,C,d,X,LOC,I,flag,shape,flag_3D,tolerance_suv);
disp('The strength of field generated at the center is::');
disp(EFF(1));
disp('The percentage uniformity is::');
disp(EFF(2));
disp('The Space volume utilization ratio is for given volume of observation is::');
disp(EFF(3));
if(EFF(3)==100)
    disp('The region of observation is fully uniform for given tolerance value.');
    disp('Please choose smaller tolerance range or increase region of observation');
end;
Data1(o,:) = EFF;
Data2(o,:) = cat(2,C',Z);
end;

Data = cat(2,Data1,Data2);
disp('Do you want to write the data into a csv file ?');
disp('1: YES    2: NO');
file_writing_flag = input('Answer::');

if(file_writing_flag==1)
disp('Enter the path of the file where you want to store the CSV file.');
file_path = input('file path::');
csvwrite(file_path,Data);
disp('Done writing the file !!!')
end;

disp('Do you want to see variation of magnetic field with respect to spatial variation ?');
disp('1: YES    2: NO');
Magnetic_field_flag = input('Answer::');

if(Magnetic_field_flag==1)
figure,
plot(Z_dist,abs(Data(:,1)),'Linewidth',2,'color','black')
title('Magnetic Field Versus seperation')
xlabel('Seperation')
ylabel('Magnetic field')
end;

disp('Do you want to see variation of uniformity with respect to spatial variation ?');
disp('1: YES    2: NO');
Uniformity_flag = input('Answer::');

if(Uniformity_flag==1)
figure,
plot(Z_dist,Data(:,2),'Linewidth',2,'color','black')
title('Uniformity Versus seperation')
xlabel('Seperation')
ylabel('Uniformity')
end;

disp('Do you want to see variation of Current in each coil with respect to spatial variation ?');
disp('1: YES    2: NO');
Coil_Current_flag = input('Answer::');

if(Coil_Current_flag==1)
figure,
plot(Z_dist,abs(Data(:,4)),'LineWidth',1,'color','red')
hold on;
plot(Z_dist,abs(Data(:,5)),'LineWidth',1,'color','green')
plot(Z_dist,abs(Data(:,6)),'LineWidth',1,'color','blue')
hold off;
title('Current Versus seperation')
xlabel('Seperation')
ylabel('Current')
end;

disp('Do you want to see variation of Total Ampere turn with respect to spatial variation ?');
disp('1: YES    2: NO');
Total_Current_flag = input('Answer::');

if(Total_Current_flag==1)
figure,
plot(Z_dist,(abs(Data(:,5))+abs(Data(:,4))+abs(Data(:,6))))
title('Total current Versus seperation')
xlabel('Seperation')
ylabel('Total current')
end;