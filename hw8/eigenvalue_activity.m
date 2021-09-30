clear; close all; clc

% Define a matrix A and a vector x
A = [-1/2 sqrt(3)/2; sqrt(3)/2 1/2];
x = randn(2,1);
lam = abs(eig(A));

% Configure the plot window
clf
shg
xlim([-5 5]);
ylim([-5 5]);
daspect([1 1 1]);
grid on
hold on

% Plot x, Ax, A^2x, ..., A^(10)x
for jj = 1:11
    h = compass(x(1),x(2));
    set(h,'Linewidth',2)
    pause(0.1)
    x = A*x;
end


