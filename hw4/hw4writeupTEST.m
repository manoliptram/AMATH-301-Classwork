clear; close all; clc;

%% Problem 1

% Define anonymous fxn
fxy = @(x,y) exp(-0.2).*sqrt(x.^2 + y.^2) + 3.*(cos(2.*x) + sin(2.*y));
f = @(p) fxy(p(1), p(2));

% Create x & y domains
x = linspace(-3, 3, 40);
y = linspace(-3, 3, 40);
[X, Y] = meshgrid(x, y);

set(gca, 'Fontsize', 15);

% a) Create a surface plot of the Modified Ackley Function
figure(1);
surf(X, Y, fxy(X, Y));
colormap('hot');
colorbar;
view(70,30);
shading interp;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('Representative Surface for the Modified Ackley Function');


% b) Create a contour plot of the Modified Ackley Function
figure(2);
x = linspace(-3, 3, 100);
y = linspace(-3, 3, 100);
[X, Y] = meshgrid(x, y);
contourf(X, Y, fxy(X, Y));
colormap('jet');
xlabel('x');
ylabel('y');
colorbar;
title('Contour Grid for the Modified Ackley Function'); % come back to this after c


% c) Add appropriate contour markers

% Add markers for solutions from coding problem #2
load('writeup_data.mat');
hold on;
point1 = plot(fmsARGMIN(1), fmsARGMIN(2), 'ro',...
    'DisplayName', 'True Minimum',...
    'MarkerSize', 12,...
    'Linewidth', 2);
point2 = plot(gradARGMIN(1), gradARGMIN(2), 'gs',...
    'DisplayName', 'Gradient Descent',...
    'MarkerSize', 10,...
    'Linewidth', 2);

% Find & add marker for other global minimum
argmin_g2 = fminsearch(f, [1 -1]'); % Initial guess: (x, y) = (1, -1)
point3 = plot(argmin_g2(1), argmin_g2(2), 'y*',...
    'DisplayName', 'Other Global Min',...
    'MarkerSize', 10,...
    'Linewidth', 2);

% Find & add marker for a non-global minimum
argmin_loc = fminsearch(f, [-1 0.9]'); % Initial guess: (x, y) = (-1, 0.9)
point4 = plot(argmin_loc(1), argmin_loc(2), 'rx',...
    'DisplayName', 'Non-Global Min',...
    'MarkerSize', 10,...
    'Linewidth', 2);

% Create a legend for all markers
legend( [point1, point2, point3, point4] );

%% Problem 2
fxy = @(x,y) exp(-0.2).*sqrt(x.^2 + y.^2) + 3.*(cos(2.*x) + sin(2.*y));
f = @(p) fxy(p(1), p(2));
p0 = [-1 -0.5]';
tol = 1e-10;
maxItr = 10000;
gradfxy = @(x,y)...
    [exp(-0.2).*(x./sqrt((x.^2)+(y.^2))) - 6.*sin(2.*x)
    exp(-0.2).*(y./sqrt((x.^2)+(y.^2))) + 6.*cos(2.*y)];
gradf = @(p) gradfxy(p(1), p(2));
tstep = 0.2;
itr = 0;
p = p0;
tic
grad = gradf(p0);
while (norm(grad, inf) > tol && itr < maxItr)
    p = p - tstep*grad;
    grad = gradf(p);
    itr = itr + 1;
    disp(itr);
    disp(p);
end
time = toc;