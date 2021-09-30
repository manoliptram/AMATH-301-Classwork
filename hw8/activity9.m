clear; close all; clc;

A = [-0.125 -1.875; -0.5 0.375];
[V,D] = eig(A);
x = V(:,1);

clf
axis equal
hold on
compass(x(1),x(2))

y = A*x;
compass(y(1), y(2));

%%
clear; close all; clc;

M = [0.6 -0.6; 0.6 0.6];

lam = eig(M);
lam = abs(lam);