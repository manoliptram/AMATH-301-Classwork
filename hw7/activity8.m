clear; close all; clc;

%% Test Functions
dydt = @(t, y) 0.3*y + t;
[tans, yans] = forward_euler(dydt, 0:0.1:1, 1);
yans(end);

dydt = @(t, y) 0.3*y + t;
[tans, yans] = backward_euler(dydt, 0:0.1:1, 1);
yans(end);

dydt = @(t, y) 0.3*y + t;
[tans, yans] = midpoint(dydt, 0:0.1:1, 1);
yans(end);

dydt = @(t, y) 0.3*y + t;
[tans, yans] = ode45(dydt, 0:0.1:1, 1);
yans(end);


%% System 1
% Error Check
dydt = @ (t,y) y.^3-y;
exact_sol = 3.451397662017099;
tspan = 0:0.001:0.1;
y0 = 2;

% Forward Euler Solution
[t_sol,y_sol] = forward_euler(dydt, tspan, y0);
fwdError = abs(exact_sol - y_sol(end));

% Backward Euler Solution
[t_sol,y_sol] = backward_euler(dydt, tspan, y0);
bkwdError = abs(exact_sol - y_sol(end));

% Midpoint Solution
[t_sol, y_sol] = midpoint(dydt, tspan, y0);
midError = abs(exact_sol - y_sol(end));

% RK4 Solution
[t_sol, y_sol] = ode45(dydt, tspan, y0);
rk4Error = abs(exact_sol - y_sol(end));

% Timing Check
% Forward Euler
tic
[t_sol,y_sol] = forward_euler(dydt,tspan,y0);
time_FE = toc;

% Backward Euler
tic
[t_sol,y_sol] = backward_euler(dydt,tspan,y0);
time_BE = toc;

% Midpoint
tic
[t_sol,y_sol] = midpoint(dydt,tspan,y0);
time_MID = toc;

% RK4
tic
[t_sol,y_sol] = ode45(dydt,tspan,y0);
time_RK4 = toc;

%% System 2

dydt = @(t,y) 5e5*(-y + sin(t));
exact_sol = -1e-6;
tspan = linspace(0, 2*pi, 100);
y0 = 0;

% Forward Euler
% tic
% [t, y] = forward_euler(dydt, tspan, y0);
% error_FE = abs(exact_sol - y(end));
% time_FE = toc;

% Backward Euler
tic
[t, y] = backward_euler(dydt, tspan, y0);
error_BE = abs(exact_sol - y(end));
time_BE = toc;

% Midpoint
% tic
% [t, y] = midpoint(dydt, tspan, y0);
% error_MID = abs(exact_sol - y(end));
% time_MID = toc;

% RK4
tic
[t, y] = ode45(dydt, tspan, y0);
error_RK4 = abs(exact_sol - y(end));
time_RK4 = toc;


%% Functions

function [t, y] = forward_euler(odefun, tspan, y0)
    % Forward Euler method
    % Solves the differential equation y' = f(t,y) at the times
    % specified by the vector tspan and with initial condition y0.
    %  - odefun is an anonymous function of the form odefun = @(t, v) ...
    %  - tspan is a row or column vector
    %  - y0 is a number
    
    dt = tspan(2)-tspan(1); % Calculate dt from the t values
    y = zeros(length(tspan), 1); % Setup our solution column vector
    y(1) = y0; % Define the initial condition
    for k = 1:length(y)-1
        y(k+1) = y(k) + dt*odefun(tspan(k), y(k)); % Forward Euler step
    end
    t = tspan;
end

function [t, y] = backward_euler(odefun, tspan, y0)
    % Backward Euler method
    % Solves the differential equation y' = f(t,y) at the times
    % specified by the vector tspan and with initial condition y0.
    %  - odefun is an anonymous function of the form odefun = @(t, v) ...
    %  - tspan is a row or column vector
    %  - y0 is a number
    
    dt = tspan(2)-tspan(1); % Calculate dt from the t values
    y = zeros(length(tspan), 1); % Setup our solution column vector
    y(1) = y0; % Define the initial condition
    for k = 1:length(y)-1
        % Define root-finding problem (g(0) = y_(k+1)
        g = @(x) y(k) + dt*odefun(tspan(k+1), x) - x;
        % Solve root-finding problem
        y(k+1) = fzero(g, y(k));
    end
    t = tspan;
end

function [t, y] = midpoint(odefun, tspan, y0)
    % Midpoint method
    % Solves the differential equation y' = f(t,y) at the times
    % specified by the vector tspan and with initial condition y0.
    %  - odefun is an anonymous function of the form odefun = @(t, v) ...
    %  - tspan is a row or column vector
    %  - y0 is a number
    
    dt = tspan(2)-tspan(1); % Calculate dt from the t values
    y = zeros(length(tspan), 1); % Setup our solution column vector
    y(1) = y0; % Define the initial condition
    for k = 1:length(y)-1
        k1 = odefun(tspan(k), y(k)); % Slope @ t(k), y(k)
        k2 = odefun(tspan(k) + dt/2, y(k) + (dt/2)*k1); % Slope @ midpoint
        y(k+1) = y(k) + dt*k2; % Forward Euler step with midpoint slope
    end
    t = tspan;
end