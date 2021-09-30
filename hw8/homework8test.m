clear; close all; clc;

%% Coding Homework
[A1, A2, A3, A4, A5, A6, A7] = problem1(0);
[A8, A9, A10] = problem2(0);


%% Coding Solutions

function [A1, A2, A3, A4, A5, A6, A7] = problem1(~)
    % Constant Definitions
    g = 9.8;
    L = 21;
    sigma = 0.08;

    % 'A' Matrix for I + dt*A
    A = [0 1
        -g/L -sigma];
    
    % b) Largest Magnitude Eigenvalue for dt = 0.02
    A1 = norm(eig(eye(2) + 0.02.*A), inf);
    
    % c) Finding largest dt for which I + dt*A is stable
    % g) Finding one more entry past the dt value from c
    dt_space = logspace(0, -4, 20);
    dt_opt = 0;
    dt_bad = 0;

    for k = 1:20
        if (norm(eig(eye(2) + dt_space(k).*A), inf) <= 1)
            dt_opt = dt_space(k);
            dt_bad = dt_space(k - 1);
            break;
        end
    end
    
    A2 = dt_opt;

    % d) Creating vector of timestep values for evaluation
    t_span = 0:dt_opt:100;
    A3 = t_span';
    
    % e) Solution to the linear system using fwd euler
    A_lnr = @(y) A;
    A4 = matrix_fwd_euler(A_lnr, t_span, [pi/6; 0.1]);
    
    % f) Solution to the nonlinear system using fwd euler
    dtheta_dt = @(theta, v) v;
    dv_dt = @(theta, v) (-g/L)*sin(theta) - sigma*v;
    f = @ (t,x) [dtheta_dt(x(1),x(2)); dv_dt(x(1),x(2))];
    
    A5 = forward_euler(f, t_span, [pi/6; 0.1]);
    
    % g) Solution to the linear system using dt_bad & fwd euler
    t_span_bad = 0:dt_bad:100;
    A6 = matrix_fwd_euler(A_lnr, t_span_bad, [pi/6; 0.1]);
    
    % h) Solution to the nonlinear system using dt_bad & fwd euler
    A7 = forward_euler(f, t_span_bad, [pi/6; 0.1]);
    
    % Graphs for debugging
%     plot(t_span, A4(1, :), 'r-');
%     hold on
%     plot(t_span, A4(2, :), 'b-');
%     plot(t_span_bad, A6(1, :), 'r:');
%     plot(t_span_bad, A6(2, :), 'b:');
%     
%     figure(2)
%     plot(t_span, A5(1, :), 'r-');
%     hold on
%     plot(t_span, A5(2, :), 'b-');
%     plot(t_span_bad, A7(1, :), 'r:');
%     plot(t_span_bad, A7(2, :), 'b:');
end

function [A8, A9, A10] = problem2(~)
    % Constant Definitions
    g = 9.8;
    L = 21;
    sigma = 0.08;

    % 'A' Matrix for Linear RK4
    A = [0 1
        -g/L -sigma];
    
    % dt value
    dt = 0.2;
    
    % 'B' Matrix for RK4
    B = eye(2) + dt.*A + ((dt^2)/2)*(A^2)...
                + ((dt^3)/6)*(A^3) + ((dt^4)/24)*(A^4);
    
    % a) Magnitude of Largest Eigenval of B
    A8 = norm(eig(B), inf);
    
    tspan = 0:dt:100;
    
    % b) Solution to the linear system using RK4
    A_lnr = @(y) A;
    sol_lnr = matrix_RK4(A_lnr, tspan, [pi/6; 0.1]);
    A9 = sol_lnr(:, end);
    
    % c) Solution to the nonlinear system using RK4
    dtheta_dt = @(theta, v) v;
    dv_dt = @(theta, v) (-g/L)*sin(theta) - sigma*v;
    f = @ (t,x) [dtheta_dt(x(1),x(2)); dv_dt(x(1),x(2))];
    
    sol_nlnr = rk4(f, tspan, [pi/6; 0.1]);
    A10 = sol_nlnr(:, end);
    
    % Graphs for Debugging
%     figure
%     plot(tspan, sol_lnr(1, :), 'r-');
%     hold on
%     plot(tspan, sol_lnr(2, :), 'b-');
%     figure
%     plot(tspan, sol_nlnr(1, :), 'r-');
%     hold on
%     plot(tspan, sol_nlnr(2, :), 'b-');
end

%% Additional Functions

% A_fxn must yield a square matrix that is NxN, where N = length(y0)
function y = matrix_fwd_euler(A_fxn, tspan, y0)
    dt = tspan(2) - tspan(1);
    y = zeros(length(y0), length(tspan));
    
    y(:, 1) = y0;
    for k = 1:length(tspan)-1
        y(:, k+1) = (eye(length(y0)) + dt.*A_fxn(y(:, k)))*y(:, k);
    end
end

% A_fxn must yield a square matrix that is NxN, where N = length(y0)
function y = matrix_RK4(A_fxn, tspan, y0)
    dt = tspan(2) - tspan(1);
    y = zeros(length(y0), length(tspan));
    y(:, 1) = y0;
    
    for k = 1:length(tspan)-1
        A = A_fxn(y(:, k));
        B = eye(length(y0)) + dt.*A + ((dt^2)/2)*(A^2)...
            + ((dt^3)/6)*(A^3) + ((dt^4)/24)*(A^4);
        y(:, k+1) = B*y(:, k);
    end
end

function y = forward_euler(odefun, tspan, y0)
    % Forward Euler method
    % Solves the differential equation y' = f(t,y) at the times
    % specified by the vector tspan and with initial condition y0.
    %  - odefun is an anonymous function of the form odefun = @(t, v) ...
    %  - tspan is a row or column vector
    %  - y0 is a number
    
    dt = tspan(2)-tspan(1); % Calculate dt from the t values
    y = zeros(length(y0), length(tspan)); % Setup our solution row vector
    y(:, 1) = y0; % Define the initial condition
    for k = 1:length(tspan)-1
        y(:, k+1) = y(:, k) + dt*odefun(tspan(k), y(:, k)); % Forward Euler step
    end
end

function y = rk4(odefun, tspan, y0)
    dt = tspan(2)-tspan(1); % Calculate dt from the t values
    y = zeros(length(y0), length(tspan)); % Setup our solution row vector
    y(:, 1) = y0; % Define the initial condition
    for k = 1:length(tspan)-1
        k1 = odefun(tspan(k), y(:, k));
        k2 = odefun(tspan(k) + dt/2, y(:, k) + (dt/2)*k1);
        k3 = odefun(tspan(k) + dt/2, y(:, k) + (dt/2)*k2);
        k4 = odefun(tspan(k + 1), y(:, k) + dt*k3);
        
        y(:, k+1) = y(:, k) + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
end