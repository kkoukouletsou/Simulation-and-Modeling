function vector = odefun(t, x, y, n, m, den, maxTime, step)
%rate of memory loss
b = 0.0001;
N = maxTime/step + 1;
filter = [1, den];
u = 0.6*sin(5*t)+sin(10*t)+0.6*sin(25*t)+0.6*sin(3*t)+0.6*sin(8*t); %na allaxteiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
u = sin(5 * t) + sin(12 * t) + sin(0.5 * t); %*******************na allaxtei

y_ = y(N);
phiOut = zeros(n, n);
phiNum = zeros(1, n);
cy = zeros(n, n);
dy = zeros(1, n);
cu = zeros(n, m + 1); 
du = zeros(1, m + 1);
phiIn = zeros(1, m + 1); 
phiDotIn = zeros(n, m + 1);
P = zeros(n + m + 1, n + m + 1);

for i = 1: 1: n
    phiNum(i) = 1;    
    [ay, by, cy(:, i), dy(i)] = tf2ss(phiNum, filter);    
    phiOut(:,i) = ay * x((i - 1) * n + 1:(i - 1) * n + n) + by * y_;
    phiNum(i) = 0;
end
for i = 1: 1: m + 1
    phiIn(i) = 1;    
    [a2, b2, cu(:, i), du(i)] = tf2ss(phiIn, filter);
    phiDotIn(:, i) = a2 * x(n * n + (i - 1) * n + 1:n * n +(i - 1) * n + n) + b2 * u;  
    phiIn(i) = 0;
end

phiDot = reshape([phiOut, phiDotIn], [], 1); 

for i = 1: 1: n
    phi1__(i) = cy(:, i).' * x((i - 1) * n + 1:(i - 1) * n + n) + dy(i) * y_;
end    

for i = 1: 1: m + 1
    phi2__(i) = cu(:, i).' * x(n * n + (i - 1) * n + 1:n * n + (i - 1) * n + n)+ du(i) * u;
end 
phi = [phi1__.'; phi2__.']; 
for k = 1: 1: n + m + 1
    for j = 1: 1: n + m + 1
       P(j, k) = x(n * (n + m + 1) + (k - 1) * (n + m + 1) + j); 
    end    
end
pDot = b * P - P * (phi * phi.') * P; 
pDot = reshape(pDot, [], 1);
thetaDot = P * phi * (y_ - phi.' * x(n * (n + m + 1)+(n + m + 1)^2 + 1:n * (n + m + 1) + (n + m + 1)^2 + n + m + 1));
vector = [phiDot; pDot; thetaDot];
end