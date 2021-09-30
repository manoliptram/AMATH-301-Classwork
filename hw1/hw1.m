clear; close all; clc;

%% Coding Problems

%% Problem 1
A = [1, 2, -1; 0, 3, -1; 9, 6, 9];
B = [3, 0, 11, 8; 9, 0, 2, 1];
C = [pi, exp(1); 0, 4];
x = [3; 4; 9];
y = [7, 9];
z = [8; 1; -pi; 0];

A1 = A*x;
A2 = B*z + y.';
A3 = C*B;
A4 = (B.')*C;

%% Problem 2
A5 = zeros(22, 22);

for i = 1:22
    for j = 1:22
        A5(i, j) = 1/(i*j);
    end
end

A6 = A5;

for j = 1:22
    A6(12, j) = 1;
end

A7 = A5(1:3, end-3:end);

%% Problem 3
u = linspace(-1, 3, 9);
v = 4:-1.5:-2;

A8 = u;
A9 = v;

w = u.^3;
A10 = w;

x = cos(v);
A11 = x;

%% Problem 4
A12 = 'B';

%% Written Problems

%% Problem 1
y1 = 0;
for i = 1:10^5
    y1 = y1 + 0.1;
end

y2 = 0;
for i = 1:10^8
    y2 = y2 + 0.1;
end

y3 = 0;
for i = 1:10^8
    y3 = y3 + 0.25;
end

y4 = 0;
for i = 1:10^8
    y4 = y4 + 0.5;
end

x1 = abs((10^4) - y1);
x2 = abs(y2 - (10^7));
x3 = abs((2.5 * 10^7) - y3);
x4 = abs(y4 - (5 * 10^7));

%% Problem 2
x = -1:10^-2:1;
y1 = asin(x);
y2 = asinTaylor(1, x);
y3 = asinTaylor(3, x);
y4 = asinTaylor(9, x);

plot(x, y1, '-', x, y2, '--', x, y3, '-.', x, y4, ':', 'Linewidth', [2]);
set(gca, 'Fontsize', 10);

legend('Original Function', 'n = 1', 'n = 3', 'n = 9', 'Location', 'Best');
xlabel('x-values', 'Fontsize', [10]);
ylabel('arcsin(x)');
title('arcsin(x) and its Taylor approximations');

function output = asinTaylor(n, x)
    output = 0;
    for k = 0:1:n
        output = output + ((factorial(2*k))*(x.^(2*k + 1)))/((4^k)*(factorial(k)^2)*(2*k + 1));
    end
end

