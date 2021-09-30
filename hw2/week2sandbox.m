%% Coding the bisection method
clear; close all; clc;
% plot
f = @ (x) sin(x);
x = linspace(0, 2*pi, 1000);
plot(x,f(x));
hold on
plot(x, 0*x, '--r', 'LineWidth', 2);
axis([1 5 -1 1]);

disp(rBisectionRoot(f, 0, 2*pi, 10^-5));

% functions

function root = rBisectionRoot(f, left, right, tol)
   mid = (left + right)/2;
   f_mid = f(mid);
   if (abs(f_mid) < tol)
       root = mid;
   elseif (f_mid*f(left) < 0)
       root = rBisectionRoot(f, left, mid, tol);
   elseif (f_mid*f(right) < 0)
       root = rBisectionRoot(f, mid, right, tol);
   else
       disp('Root not found in interval [' + str(left) + ', ' + str(right) + '].');
       return;
   end
end