clear; close all; clc;

f = @(x,y) (x-2).^2 + (y+1).^2 + 5.*sin(x).*sin(y) + 100;
fp = @(p) f(p(1), p(2)); %p = [x;y]
fgrad = @(p) [2.*(p(1)-2) + 5.*cos(p(1)).*sin(p(2))
              2.*(p(2)+1) + 5.*sin(p(1)).*cos(p(2))];
phi = @(t) [6;4] - t.*fgrad([6;4]);
f_of_phi = @(t) fp(phi(t));
[a, b] = gradDescent(fp, fgrad, [6;4], 0)

function [min, argminf] = gradDescent(fp, fgrad, v0, tol)
    phi = @(t) v0 - t.*fgrad(v0);
    f_of_phi = @(t) fp(phi(t));
    argminf = phi(fminbnd(f_of_phi, 0, 1));
    min = fp(argminf);
end