function SUV = suv(B,tolerance)
[len wid] = size(B);
Vol = round(len);
B_mean = mean(mean(B));
S = (B-B_mean)*100/B_mean;
m = abs(S) < tolerance;
v = mean(sum(m));
SUV = v*100/Vol;
end