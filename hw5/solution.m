% Homework 5 MATLAB template file
% Your main file should be named "solution.m" and it should be saved as UTF-8 file.

function [consoleout, A1, A2, A3, A4, A5, A6, A7, A8] = solution()
 [consoleout, A1, A2, A3, A4, A5, A6, A7, A8] = evalc('student_solution(0)'); 
end

function [A1, A2, A3, A4, A5, A6, A7, A8] = student_solution(dummy_argument)
   [A1, A2, A3, A4] = problem1(0);
   [A5, A6, A7, A8] = problem2(0);
end

% Problem 1

function [A1, A2, A3, A4] = problem1(~)
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
end

% Problem 2

function [A5, A6, A7, A8] = problem2(~)
    M = readmatrix('CO2_data.csv');
    co2 = M(1, :);
    yrs = M(2, :);

    LSQ1 = @(p) sumSQ1(yrs, co2, p(1), p(2), p(3));
    A5 = fminsearch(LSQ1, [30 0.03 300]);
    A6 = LSQ1(A5);

    LSQ2 = @(p) sumSQ2(yrs, co2, p);
    options = optimset('MaxFunEvals', 2000);
    A7 = fminsearch(LSQ2, [A5(1) A5(2) A5(3) -5 4 0], options);
    A8 = LSQ2(A7);
end

function error = sumSQ1(X, Y, a, r, b)
    f = @(t) a.*exp(r.*t) + b;
    error = sum(abs(f(X) - Y).^2);
end

function error = sumSQ2(X, Y, p)
    f = @(t) p(1).*exp(p(2).*t) + p(3) + p(4).*sin(p(5).*(t - p(6)));
    error = sum(abs(f(X) - Y).^2);
end