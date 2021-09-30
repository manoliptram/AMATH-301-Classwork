clear; close all; clc;

a = 1;
b = 2;
c = 3;

disp(findRoots(a, b, c));

function roots = findRoots(a, b, c)
    tol = 10^-12;
    discriminant = b^2 - 4*a*c;
    
    if abs(discriminant) < tol
        disp('There is one real root')
        roots = [-b/(2*a)];
    elseif discriminant >= tol
        disp('There are two real roots')
        root1 = (-b - sqrt(discriminant))/(2*a);
        root2 = (-b + sqrt(discriminant))/(2*a);
        roots = [root1 root2];
    else
        disp('There are no real roots')
        roots = [];
    end
end