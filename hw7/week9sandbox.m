clear; close all; clc;

%% Explicit Euler

w = 2*pi;
d = 0.25;

% spring-mass damper system
A = [0 1
    -w^2 -2*d*w];
% \dot{x} = Ax

dt = 0.1; % timestep
T = 10; % amount of time to integrate

x0 = [2;0]; % initial condition (x = 2, v = 0)

% iterate explicit euler scheme
xE(:,1) = x0; %state
tE(1) = 0; %time
for (k = 1:(T/dt))
    tE(k+1) = k*dt; %next timestep
    xE(:, k+1) = (eye(2) + dt.*A)*xE(:, k); %x_(k+1) = (I + dt*A)x_k
end

plot(tE, xE(1, :)); % plot of position vs time
xlabel('Time');
ylabel('Position');

figure();
plot(xE(1, :), xE(2, :)); % plot of velocity vs position
xlabel('Position');
ylabel('Velocity');

figure();
plot3(tE, xE(1,:), xE(2, :));
xlabel('Time');
ylabel('Velocity');
zlabel('Position');

%% Implicit Euler
clear; close all; clc;

w = 2*pi;
d = 0.25;

% spring-mass damper system
A = [0 1
    -w^2 -2*d*w];
% \dot{x} = Ax

dt = 0.1; % timestep
T = 10; % amount of time to integrate

x0 = [2;0]; % initial condition (x = 2, v = 0)

% iterate explicit euler scheme
xI(:,1) = x0; %state
tI(1) = 0; %time
% [L, U, P] = lu(eye(2)-dt.*A);

for (k = 1:(T/dt))
    tI(k+1) = k*dt; %next timestep
%     y = L\xI(:, k);
%     xI(:, k+1) = U\y; %x_(k+1) = (I + dt*A)x_k
    xI(:, k+1) = (eye(2)-dt.*A)\xI(:, k);
end

plot(tI, xI(1, :)); % plot of position vs time
xlabel('Time');
ylabel('Position');

figure();
plot(xI(1, :), xI(2, :)); % plot of velocity vs position
xlabel('Position');
ylabel('Velocity');

figure();
plot3(tI, xI(1,:), xI(2, :));
xlabel('Time');
ylabel('Velocity');
zlabel('Position');

%% Built-In Matlab Integrater (4th-Order Runge Kutta Integrator)
clear; close all; clc;

w = 2*pi;
d = 0.25;

% spring-mass damper system
A = [0 1
    -w^2 -2*d*w];
% \dot{x} = Ax

dt = 0.1; % timestep
T = 10; % amount of time to integrate

x0 = [2;0]; % initial condition (x = 2, v = 0)

options = odeset('RelTol', dt);

[t, xGood] = ode45(@(t, x) A*x, [0 T], x0);

plot(t, xGood(:, 1));