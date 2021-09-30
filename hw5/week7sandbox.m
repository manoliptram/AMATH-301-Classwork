clear; close all; clc;

M = readmatrix('data1.csv');
x = M(1, :);
y = M(2, :);

plot(x, y, 'ko');
hold on;

domain = linspace(x(1), x(end), 20);
linfit = polyfit(x, y, 1);
plot(domain, polyval(linfit, domain), 'b:');

quadfit = polyfit(x, y, 2);
plot(domain, polyval(quadfit, domain), 'r:');

cubefit = polyfit(x, y, 3);
plot(domain, polyval(cubefit, domain), 'g:');

%%
clear; close all; clc;
M = readmatrix('fitdata.csv');
x = M(:, 1);
y = M(:, 2);

plot(x, y, 'ko');

% Try to fit with polynomial


%%
clear; close all; clc;

M = readmatrix('data2.csv');
x = M(:, 1);
y = M(:, 2);
plot(x, y, 'ko');
x_plot = linspace(x(1), x(end));

poly_interp = polyfit(x, y, 19);
hold on;
plot(x_plot, polyval(poly_interp, x_plot), 'b-');
