function[var] = GradientDescent(t, x, a, b, am, g, number)
x_ = x(1);
phi1 = x(2);
phi2 = x(3);
theta1hat = x(4);
theta2hat = x(5);
if number == 1
    u = 10;
elseif number == 2
    u = 10 * sin(3 * t);
end

xhat = theta1hat * phi1 + theta2hat * phi2;
e = x_ - xhat;

var(1) = - a * x_ + b * u;
var(2) = - am * phi1 + x_;
var(3) = - am * phi2 + u;
var(4) = g * e * phi1;
var(5) = g * e * phi2;
var = var';
end