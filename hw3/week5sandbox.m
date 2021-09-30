f = @(x) x^2*log(x) - 3;
step = 0.1;
tol = 1e-9;
x(1) = 18;
for k = 1:100
    if abs( f(x(k)) )<tol
        root = x(k);
        break
    end
    x(k+1) = get_next(f, x(k), step);
end
function next_guess = get_next(f, last_guess, step)
    fp = (f(last_guess + step) - f(last_guess))/step;
    tan_line = @(x) f(last_guess) + fp*(x-last_guess);
    next_guess = fzero(f, last_guess);
end