%% Week 2 Coding Problems - Attempt 2
clear; close all; clc;

% Problem 1
% A1 - Correct
% A2 - Correct
f1 = @(x) (x/(1-x))*sqrt(7/(2+x)) - 0.04;
[A1, A2] = bisection(f1, -1, 0.5, 1e-12);

% Problem 2
% A3 - Correct
% A4 - Correct
% A5 - Incorrect (not within tolerance)
% A6 - Incorrect (not within tolerance)
f2 = @(x) (2*x^3)-16;
df2 = @(x) (6*x^2);
A3 = abs(2 - newtonN(f2, df2, 20, 100));
A4 = 11;
A5 = newtonK(f2, df2, 20, 1e-14, 100);
err2 = @(x) abs(2 - x);
A6 = err2(A5);


% Problem 3
% A7 - Correct
% A8 - Incorrect (not within tolerance)
f3 = @(x) sin(x^2) + cos(pi*x) - 5*x;
A7 = fzero(f3, 4);
df3 = @(x) 2*x*cos(x^2) - pi*sin(pi*x) - 5;
err3 = @(x) abs(A7 - x);
r8 = newtonK(f3, df3, 0, 1e-11, 40);
A8 = [err3(r8(end));4];

% Problem 4
% A9 - Correct
A9 = 'C';


%% Functions

% bisection - Problem 1
% Uses the bisection method to find the root of f
% Also tracks num of iterations used
function [root, itr] = bisection(f, left, right, tol)
   mid = (left + right)/2;
   f_mid = f(mid);
   if (abs(f_mid) < tol)
       root = mid;
       itr = 1;
   elseif (f_mid*f(left) < 0)
       [root, itr] = bisection(f, left, mid, tol);
       itr = itr + 1;
   elseif (f_mid*f(right) < 0)
       [root, itr] = bisection(f, mid, right, tol);
       itr = itr + 1;
   else
       disp('Root not found in interval [' + str(left) + ', ' + str(right) + '].');
       return;
   end
end

% newtonN - Problem 2
% Uses Newton's Method with n iterations to find the root of f
function root = newtonN(f, df, x, n)
    if (n == 0)
        root = x;
    else
        root = newtonN(f, df, (x-(f(x)/df(x))), n - 1);
    end
end

% newtonK - Problem 2
% Uses Newton's Method to find the root of f
% End Condition: Root is found within tol or k iterations have passed
% Returns: [num iterations used, root found]
function roots = newtonK(f, df, x, tol, k)
    roots(1) = x;
    for i = 1:(k+1)
        
        if (abs(f(roots(i))) < tol)
            return;
        end
        roots(i+1) = newtonN(f, df, x, i);
    end
end


%% Garbage

%     f1 = @(x) (x/(1-x))*sqrt(7/(2+x)) - 0.04;
%     [A1, A2] = bisection(f1, -1, 0.5, 1e-12);
%     f2 = @(x) (2*x^3)-16;
%     df2 = @(x) (6*x^2);
%     A3 = abs(2 - newtonN(f2, df2, 20, 100));
%     [A4, A5] = newtonKL(f2, df2, 20, 1e-14, 100);
%     
%     err2 = @(x) abs(2 - x);
%     A6 = err2(A5);
%     f3 = @(x) sin(x^2) + cos(pi*x) - 5*x;
%     A7 = fzero(f3, 4);
%     df3 = @(x) 2*x*cos(x^2) - pi*sin(pi*x) - 5;
%     err3 = @(x) abs(A7 - x);
%     [n8, r8] = newtonK(f3, df3, 0, 1e-11, 40);
%     A8 = [err3(r8(end));n8];
%     A9 = 'C';

% function root = newtonN(f, df, x, n)
%     if (n == 0)
%         root = x;
%     else
%         root = newtonN(f, df, (x-(f(x)/df(x))), n - 1);
%     end
% end
% 
% function [n, root] = newtonK(f, df, x, tol, k)
%     if (k == 0 || abs(f(x)) < tol)
%         root = x;
%         n = 1;
%     else
%         [root, n] = newtonK(f, df, (x-(f(x)/df(x))), k - 1);
%         n = n + 1;
%     end
% end
% 
% function [n, roots] = newtonKL(f, df, x, tol, k)
%     roots(1) = x;
%     roots(2) = newtonN(f, df, x, 1);
%     for i = 1:k
%         if (abs(roots(i+1)-roots(i)) < tol)
%             n = i;
%             return;
%         end
%         
%         roots(i+2) = newtonN(f, df, x, i+2);
%     end
% end