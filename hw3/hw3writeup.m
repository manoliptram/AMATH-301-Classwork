clear; close all; clc;

%% Problem 1

% a) Create Special Matrix
N = 2000;
A = -1*diag(ones(N,1)) + 4*diag(ones(N-1,1),1) + 4*diag(ones(N-1,1),-1);

% b) Run Tests for the Backslash Method
bsRes = 0;
tic;
for i = 1:100
    b = rand(2000, 1);
    x = A\b;
    % e) Record total residual magnitude for the Backslash Method
    bsRes = bsRes + norm(A*x-b);
end
bsTime = toc;

% c) Run Tests for PLU Decomposition
lupRes = 0;
tic
[L, U, P] = lu(A);
for i = 1:100
    b = rand(2000, 1);
    y = L\(P*b);
    x = U\y;
    % e) Record total residual magnitude for PLU Decomposition
    lupRes = lupRes + norm(A*x-b);
end
lupTime = toc;

% d) Run Tests for the Inverse Method
invRes = 0;
tic
invA = inv(A);
for i = 1:100
    b = rand(2000, 1);
    x = invA*b;
    % e) Record total residual magnitude for the Inverse Method
    invRes = invRes + norm(A*x-b);
end
invTime = toc;

%% Problem 2
nVals = [700, 1200, 2400, 6000, 9000];

% b) Find Backslash solution times
bsTimes = [ bsRandSolve(700),...
            bsRandSolve(1200),...
            bsRandSolve(2400),...
            bsRandSolve(6000),...
            bsRandSolve(9000)];

% c) Find PLU Decomposition solution times
pluTimes = [pluRandSolve(700),...
            pluRandSolve(1200),...
            pluRandSolve(2400),...
            pluRandSolve(6000),...
            pluRandSolve(9000)];

% d) Find Inverse solution times
invTimes = [invRandSolve(700),...
            invRandSolve(1200),...
            invRandSolve(2400),...
            invRandSolve(6000),...
            invRandSolve(9000)];

n = 300:10000;
set(gca, 'Fontsize', 15);
% e-g) Plot solution times for all 3 solution methods
loglog(nVals, bsTimes, 'bo',...
    nVals, pluTimes, 'rd',...
    nVals, invTimes, 'gs',...
    'Linewidth', 1);
hold on
% h) Add trendlines for O(N^2) and O(N^3)
loglog(n, n.^2, 'k-',...
    n, n.^3, 'b-',...
    'Linewidth', 2);
% i) Make the graph look nice (title, axis labels, legend)
title('Solving Matrices with Various Methods: Solution Times by Matrix Size');
xlabel('Square Matrix Size (NxN)');
ylabel('Solution Time (Seconds)');
legend('Backslash', 'PLU Decomposition', 'Inverse', 'O(N^2)', 'O(N^3)',...
    'Location', 'Best');
    
% Random Solve Functions
function time = bsRandSolve(n)
    A = rand(n);
    b = rand(n, 1);
    tic
    A\b;
    time = toc;
end

function time = pluRandSolve(n)
    A = rand(n);
    b = rand(n, 1);
    tic
    [L, U, P] = lu(A);
    y = L\(P*b);
    U\y;
    time = toc;
end

function time = invRandSolve(n)
    A = rand(n);
    b = rand(n, 1);
    tic
    inv(A)*b;
    time = toc;
end