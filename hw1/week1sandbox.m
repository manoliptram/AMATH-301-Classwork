%% Logicals

% == equal to
% < less than
% > greater than
% <= less than or equal to
% >= greater than or equal to
% -= not equal to

%%
clear; close all; clc

for i = 1:22
    for j = 1:22
        A(i, j) = 1/(i*j);
    end
end

disp(A);

%%
clear; close all; clc;

x1 = -10:0.1:10;
y1 = sin(x1);

x2 = [-5 sqrt(3) pi 4];
y2 = sin(x2);

x3 = linspace(-10, 10, 64);
y3 = x3.*sin(x3);

plot(x1, y1), hold on
plot(x2, y2, 'ko', 'Linewidth', 3), hold on
plot(x3, y3, 'b');

save filename;

%%
clear; close all; clc;

display(f(0));

function result = f(x)
result = x^2-9;
end


