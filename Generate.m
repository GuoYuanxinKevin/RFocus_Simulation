function [h, h_z]= Generate(N, st)
X = unifrnd(-pi, pi, 1, N);
h = complex(cos(X)+normrnd(0,st,1,N),(sin(X)+normrnd(0,st,1,N)));
h_z = unifrnd(20,50,1,1)*exp(complex(0,unifrnd(0,2*pi,1,1)));
%h_z = unifrnd(-50, 50, 1, 1)+unifrnvd(-50, 50, 1, 1)*i;
H = h;
H(N+1) = h_z;
csvwrite('H.csv',H);