% First define the vector fields (the x and v component of the derivative)
dxdt = @(x,v) v;
dvdt = @(x,v) x;

% Setup the meshgrid
xvec = [0 1 2];
vvec = [2.0 2.5 3.0];
[X,V] = meshgrid(xvec, vvec);

clf % Clear the current figure
quiver(X,V, dxdt(X,V), dvdt(X,V)); % Draw the arrows
hold on % Hold on, to plot things on top
axis equal % This makes the length of the x axis and the y axis the same,
           % which makes a better looking plot