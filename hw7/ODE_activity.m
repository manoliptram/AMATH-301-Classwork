clear; close all; clc

% model parameters
m = 5; % Mass
k = 1; % Spring constant
x0 = 3; % Initial position
v0 = 1; % Initial velocity

% model equations - this is the only thing you need to change here, the
% rest remains untouched.
dxdt = @(x, v) v;
dvdt = @(x, v) (-k/m).*x;

% numerical solution with ode45
endtime = 30; % This determines the length of the animation, 
              %  you could change this.
ts = 0:.1:endtime; % Times at which we will get the ODE solution
Z0 = [x0;v0]; % Initial condition
odefun = @(t,Z) [ dxdt(Z(1),Z(2));
                  dvdt(Z(1),Z(2)) ]; % This is the ODE we are solving
[tsol,Zsol] = ode45(odefun,ts,Z0); % tsol is the times at which we have 
                       % the solution, Zsol is the solution, as a matrix

% Everything below this is for the animation, do not change it
wall = -10;
coilamp = 3;
amp = .5;

clf
hold on
axis equal
xlim([-10 10]);
for nn = 1:numel(tsol)
    xpos = Zsol(nn,1);
    
    cla
    
    % drawing the spring
    a = wall; b = xpos-1;
    Nturns = 15;
    ts = linspace(-pi/2,Nturns*2*pi+pi/2,1000);
    xs = ts + coilamp*sin(ts);
    xs = a+(b-a)*(xs-(-pi/2-coilamp))/(Nturns*2*pi + pi+2*coilamp);
    ys = amp*sin(ts+pi/2);
    plot(xs,ys,'k');
    
    hold on
    patch(xpos+[-1 1 1 -1],[-1 -1 1 1],'k');
    title( sprintf('Time = %0.1f',tsol(nn)) );
    pause(.03);
end

%% phase portrait code goes here!


clf % Clears the current figure
hold on
axis equal % Makes the x axis and the y axis the same length, looks better
% draw axes
plot([-6 6], [0 0], 'k-');
plot([0 0], [-5 5], 'k-');

% draw arrows
x_space = -6:0.5:6;
v_space = -5:0.5:5;
[X, V] = meshgrid(x_space, v_space);

quiver(X, V, dxdt(X, V), dvdt(X, V));
xlabel('Position (x)');
ylabel('Velocity (v = dx/dt)');


% draw trajectory
plot(Zsol(:, 1), Zsol(:, 2), 'r-', 'Linewidth', 2);

