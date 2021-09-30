clear; close all; clc;

%% Problem 1
% Define anonymous functions
x = @(t) (10/9)*(exp(-t/12)-exp(-t));
dx = @(t) (10/9)*(exp(-t)-(exp(-t/12)/12));

% Find argmax using fzero and dx
A1(1) = fzero(dx, 1);
% Find max from argmax value
A1(2) = x(A1(1));

% Find argmax & max using fminbnd
[A2(1), A2(2)] = fminbnd(@(t) -x(t), 0, 10); % Using -x finds max instead of min
A2(2) = -A2(2); % max(f) = -min(-f)
A2 = A2'; % Make A2 a column vector instead of a row vector

%% Problem 2
% Define anonymous function
fxy = @(x,y) exp(-0.2).*sqrt(x.^2 + y.^2) + 3.*(cos(2.*x) + sin(2.*y));
f = @(p) fxy(p(1), p(2));

% Find argmin using fminsearch and p0 = [-1 -0.5]'
A3 = fminsearch(f, [-1 -0.5]');

% Find argmin using gradient descent and p0 = [-1 -0.5]
% End Conditions: Infinity norm of grad is below 10^-6 OR
% 1000 iterations completed.
gradfxy = @(x,y)...
    [exp(-0.2).*(x./sqrt((x.^2)+(y.^2))) - 6.*sin(2.*x)
    exp(-0.2).*(y./sqrt((x.^2)+(y.^2))) + 6.*cos(2.*y)];
gradf = @(p) gradfxy(p(1), p(2));
A4 = norm(gradf(A3));
A5 = [-1 -0.5]';
grad = gradf(A5);
A6 = 0;
tol = 1e-6;
% Use && since the while uses the contrapositive of the end condition
while (norm(grad, inf) > tol && A6 < 1000)
    phi = @ (t) A5 - t*grad;
    f_of_phi = @(t) f(phi(t));
    tmin = fminbnd(f_of_phi, 0, 1);
    A5 = phi(tmin);
    A6 = A6 + 1;
    grad = gradf(A5);
end

fmsARGMIN = A3;
gradARGMIN = A5;

save('writeup_data.mat', 'fmsARGMIN', 'gradARGMIN');

%% Graph ModAckley (for clarification)
ackley4 = @(x,y) exp(-0.2).*sqrt(x.^2 + y.^2) + 3.*(cos(2.*x) + sin(2.*y));
% Create x & y domains
x = linspace(-2, -1, 20);
y = linspace(-1, 0, 20);
[X, Y] = meshgrid(x, y);

% Plot surface with settings
set(gca, 'Fontsize', 15);
surf(X, Y, ackley4(X, Y));
hold on
contour(X, Y, ackley4(X,Y));
colormap('hot');
colorbar;
view(70,30);
shading interp;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('Representative Surface for the Modified Ackley Function');