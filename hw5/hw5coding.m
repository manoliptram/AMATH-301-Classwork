clear; close all; clc;

%% Problem 1 (Written & Coding)

% Calculating Polynomial Fits for Salmon Data
% From Coding Problem (1)
M = readmatrix('salmon_data.csv');
yrs = M(:, 1);
salmon = M(:, 2);

A1 = polyfit(yrs, salmon, 1);
A2 = polyfit(yrs, salmon, 3);
A3 = polyfit(yrs, salmon, 5);

y2019 = 381773;
errA1 = abs(polyval(A1, 2019) - y2019);
errA2 = abs(polyval(A2, 2019) - y2019);
errA3 = abs(polyval(A3, 2019) - y2019);
A4 = [errA1 errA2 errA3];

% a) Plot the polynomial fits with the real data
xplot = 1930:2020;

figure(1);
plot(yrs, salmon, '-k.');
xlim([1930 2020]);
ylim([1e5 1.5e6]);
hold on;
plot(xplot, polyval(A1, xplot), 'b-',...
    xplot, polyval(A2, xplot), 'r-',...
    xplot, polyval(A3, xplot), 'm-',...
    'Linewidth', 2);
legend('Real Data Points', 'Degree 1 Polynomial Fit',...
    'Degree 3 Polynomial Fit', 'Degree 5 Polynomial Fit',...
    'Location', 'Best');
xlabel('Year');
ylabel('Number of Salmon');
title('Trends in Annual Salmon Population at Bonneville');

% d) Predict the salmon population for the year 2050
d = [polyval(A1, 2050) polyval(A2, 2050) polyval(A3, 2050)];

%% Problem 2 (Written & Coding)

% Curve fitting for Atmospheric CO2 Data
% From Coding Problem (2)
M = readmatrix('CO2_data.csv');
co2 = M(1, :);
yrs = M(2, :);

LSQ1 = @(p) sumSQ1(yrs, co2, p(1), p(2), p(3));
A5 = fminsearch(LSQ1, [30 0.03 300]);
% b) Error from the exponential fit
A6 = LSQ1(A5);

LSQ2 = @(p) sumSQ2(yrs, co2, p);
options = optimset('MaxFunEvals', 2000);
A7 = fminsearch(LSQ2, [A5(1) A5(2) A5(3) -5 4 0], options);
% b) Error for the exponential + sinusoidal fit
A8 = LSQ2(A7);

% a) Plot the Atmospheric CO2 trend lines with the real data
xplot = 0:0.1:65;

figure(2);
plot(yrs, co2, '-k.');
xlim([0 65]);
hold on;
f1 = @(t) A5(1).*exp(A5(2).*t) + A5(3);
plot(xplot, f1(xplot), 'r-', 'Linewidth', 2);
f2 = @(t) A7(1).*exp(A7(2).*t) + A7(3) + A7(4).*sin(A7(5).*(t - A7(6)));
plot(xplot, f2(xplot), 'b-', 'Linewidth', 2);
xlabel('Years since January 1958');
ylabel('Atmospheric CO_2');
legend('Real Data Points', 'Exponential Fit',...
    'Exponential + Sinusoidal Fit', 'Location', 'Best');
title('Trends in Atmospheric CO_2 Levels Over Time');

% Important functions
function error = sumSQ1(X, Y, a, r, b)
    f = @(t) a.*exp(r.*t) + b;
    error = sum(abs(f(X) - Y).^2);
end

function error = sumSQ2(X, Y, p)
    f = @(t) p(1).*exp(p(2).*t) + p(3) + p(4).*sin(p(5).*(t - p(6)));
    error = sum(abs(f(X) - Y).^2);
end