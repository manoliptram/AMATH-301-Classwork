clear; close all; clc

M = readmatrix("fitdata2.csv"); % fitdata.csv stores the x values in the first column and the y values in the second column.
X = M(:,1); % x values are stored in the first column
Y = M(:,2); % y values are stored in the second column

plot(X,Y,'ko'); % Plot the data
hold on
ylim([-.5 1]); % Change the ylimit to match the data well


LSQ = @(in) sumSquaredError(X, Y, in(1), in(2));
minLSQ = fminsearch(LSQ, [2.25 0.75]);
mu = minLSQ(1);
sigma2 = minLSQ(2);
y = @(x) (1/sqrt(2*pi*sigma2)).*exp((-(x-mu).^2)/(2*sigma2));

L = @(in) averageError(X, Y, in(1), in(2));
minL = fminsearch(L, [2.25 0.75]);
mu_1 = minL(1);
sigma2_1 = minL(2);
y1 = @(x) (1/sqrt(2*pi*sigma2_1)).*exp((-(x-mu_1).^2)/(2*sigma2_1));

maxErr = @(in) maxError(X, Y, in(1), in(2));
minMaxErr = fminsearch(maxErr, [2.25 0.75]);
mu_2 = minMaxErr(1);
sigma2_2 = minMaxErr(2);
y2 = @(x) (1/sqrt(2*pi*sigma2_2)).*exp((-(x-mu_2).^2)/(2*sigma2_2));


xs = linspace(-6,8); % The x values for plotting
figure(1);
plot(xs,y(xs)); % Plot the model 'y'


for k = 1:length(X)
    
    xdata = X(k); % The kth x coordinate
    ydata = Y(k); % The kth y coordinate
    
    plot( xdata,y(xdata),'k.','markersize',20); % Plotting the model 
                                 %prediction of the y value at that x value
    plot( [xdata xdata], [ydata y(xdata)], 'r', 'linewidth',2);
    %The above line of code creates a red line between the true value and
    %the model's prediction. This is the error.
end

figure(2);
plot(X,Y,'ko');
hold on;
plot(xs,y1(xs)); % Plot the model 'y'

for k = 1:length(X)
    
    xdata = X(k); % The kth x coordinate
    ydata = Y(k); % The kth y coordinate
    
    plot( xdata,y1(xdata),'k.','markersize',20); % Plotting the model 
                                 %prediction of the y value at that x value
    plot( [xdata xdata], [ydata y1(xdata)], 'r', 'linewidth',2);
    %The above line of code creates a red line between the true value and
    %the model's prediction. This is the error.
end

figure(3);
plot(X,Y,'ko');
hold on;
plot(xs,y2(xs)); % Plot the model 'y'

for k = 1:length(X)
    
    xdata = X(k); % The kth x coordinate
    ydata = Y(k); % The kth y coordinate
    
    plot( xdata,y2(xdata),'k.','markersize',20); % Plotting the model 
                                 %prediction of the y value at that x value
    plot( [xdata xdata], [ydata y2(xdata)], 'r', 'linewidth',2);
    %The above line of code creates a red line between the true value and
    %the model's prediction. This is the error.
end

%% Functions

function error = sumSquaredError(X, Y, mu, sigma2)
    y = @(x) (1/sqrt(2*pi*sigma2)).*exp((-(x-mu).^2)/(2*sigma2));
    error = sum(abs(y(X) - Y).^2);
end

function error = averageError(X, Y, mu, sigma2)
    y = @(x) (1/sqrt(2*pi*sigma2)).*exp((-(x-mu).^2)/(2*sigma2));
    error = sum(abs(y(X) - Y));
end

function error = maxError(X, Y, mu, sigma2)
    y = @(x) (1/sqrt(2*pi*sigma2)).*exp((-(x-mu).^2)/(2*sigma2));
    error = max(abs(y(X) - Y));
end