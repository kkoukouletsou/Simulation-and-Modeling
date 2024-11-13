function [var] = LyapunovMixed(t, x, a, b, g1, g2, thetam, number, n0, f)

x_ = x(1);
theta1hat = x(2);
theta2hat = x(3);
xhat = x(4);

n = n0 * sin(2 * 3.14 * f * t);

if number == 1
    e = x_ - xhat;
elseif number == 2
    e = x_ + n - xhat;
end

u = 10 * sin(3 * t);

var(1) = - a * x_ + b * u;
var(2) = - g1 * e * x_;
var(3) =  g2 * e * u;
var(4) = - theta1hat * x_ + theta2hat * u + thetam * (x_ - xhat);

var = var';
end
                           

