clear; close all; clc;

R = [10, 20, 5, 15, 30, 25];
V = [20, 10, 5];

A = [(R(1) + R(2) + R(6)), (-R(1)), (-R(2));...
    (-R(1)), (R(3) + R(4) + R(1)), (-R(4));...
    (-R(2)), (-R(4)), (R(5) + R(4) + R(2))];
b = [V(1); V(2); V(3)];

I = A\b;

disp(I);
%%
clear; clc;

A = ones(5).*-1;

for i = 1:5
    A(i, i) = 0;
end

A(1, 2) = 808;
A(1, 5) = 832;
A(2, 1) = 808;
A(2, 3) = 382;
A(2, 5) = 736;
A(3, 2) = 382;
A(3, 4) = 270;
A(4, 3) = 270;
A(4, 5) = 421;
A(5, 1) = 832;
A(5, 2) = 736;
A(5, 4) = 421;

disp(A);

%%
clear; clc;
E = [1, 2, 808;...
    2, 1, 808;...
    2, 3, 382;...
    3, 2, 382;...
	3, 4, 270;...
    4, 3, 270;...
	4, 5, 421;...
	5, 4, 421;...
    2, 5, 736;...
    5, 2, 736];

%%
clear; close all; clc;
A = rand(1000, 1000); b = rand(1000, 1);
% A = [3 0 27; -2 2 1; 1 2 -3];
% b= [36;3;8];
tic %starts timer
x = A\b;
backslash_time = toc %stops timer

% compare to inverse
tic
x = inv(A)*b;
inv_time = toc

tic
[L, U, P] = lu(A);
y = L\(P*b);
x = U\y;
LU_time = toc