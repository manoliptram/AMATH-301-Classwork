clear; close all; clc;

%% Problem 1
r5 = sqrt(5);
A = [-1/r5 1 0 0 0 0 0 1/r5 0 0 0
    -2/r5 0 0 0 0 0 0 -2/r5 0 0 0
    0 -1 1 0 0 0 0 0 -1/r5 1/r5 0
    0 0 0 0 0 0 0 0 -2/r5 -2/r5 0
    0 0 -1 1/r5 0 0 0 0 0 0 -1/r5
    0 0 0 -1/r5 0 0 0 0 0 0 -1/r5
    0 0 0 -1/r5 -1 0 0 0 0 0 0
    0 0 0 0 1 -1 0 0 0 -1/r5 1/r5
    0 0 0 0 0 0 0 0 0 2/r5 2/r5
    0 0 0 0 0 1 -1 -1/r5 1/r5 0 0
    0 0 0 0 0 0 0 2/r5 2/r5 0 0];
[A1, U, P] = lu(A);
A2 = findForces(A, 15000, 22000);
A3 = max(abs(A2));

x = A2;
currentW6 = 15000;
while (max(abs(x)) <= 41000)
    currentW6 = currentW6 + 20;
    x = findForces(A, currentW6, 22000);
end

A4 = currentW6;
[~, A5] = max(abs(x));

%% Problem 2
R = @(theta) [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
A6 = R(pi/7);
y = [9;-pi;13];
A7 = A6\y;
[L, U, P] = lu(A6);
v = L\(P*y);
A8 = U\v;

%% Functions
function F = findForces(A, w6, w7)
    b = zeros(11, 1);
    b(9, 1) = w6;
    b(11, 1) = w7;
    F = A\b;
end
