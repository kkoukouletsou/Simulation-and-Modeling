function[state1, u1] = odefun(mass, k, b)

u = @(t) 15 * sin(3 * t) + 8;

x0(1) = 0;
x0(2) = 0;

tspan = 0: 0.1: 10;

[t, state] = ode45(@(t,state) spring(t, state, mass, b, k, u), tspan, x0);

%y values
state1 = state(:, 1);

%u values
i = 0;
for time = 0: 0.1: 10
    i = i + 1;
    u1(i) = u(time);
end
end
function dx = spring(t, x, mass, b, k, u)

dx(1) = x(2);
dx(2) = 1/mass * (-k*x(1) - b*x(2) + u(t));

dx = dx';

end