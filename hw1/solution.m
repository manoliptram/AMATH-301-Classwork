% Homework 1 MATLAB template file
% Your main file should be named "solution.m" and it should be saved as UTF-8 file.

function [consoleout, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12] = solution()
 [consoleout, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12] = evalc('student_solution(0)'); 
end

function [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12] = student_solution(dummy_argument)
   %% Problem 1
    A = [1, 2, -1; 0, 3, -1; 9, 6, 9];
    B = [3, 0, 11, 8; 9, 0, 2, 1];
    C = [pi, exp(1); 0, 4];
    x = [3; 4; 9];
    y = [7, 9];
    z = [8; 1; -pi; 0];

    A1 = A*x;
    A2 = B*z + y.';
    A3 = C*B;
    A4 = (B.')*C;
    
    %% Problem 2
    A5 = zeros(22, 22);

    for i = 1:22
        for j = 1:22
            A5(i, j) = 1/(i*j);
        end
    end

    A6 = A5;

    for j = 1:22
        A6(12, j) = 1;
    end

    A7 = A5(1:3, end-3:end);
    
    %% Problem 3
    u = linspace(-1, 3, 9);
    v = 4:-1.5:-2;

    A8 = u;
    A9 = v;

    w = u.^3;
    A10 = w;

    x = cos(v);
    A11 = x;
    
    %% Problem 4
    A12 = 'B';
end