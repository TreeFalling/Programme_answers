clc
clear
close all

global k1 k2 k3

k1 = 100; %units: 1/μM/min
k2 = 600; %units:1/min
k3 = 150; %units:1/min

% initial conditions
S0 = 10;   % units:μM
P0 = 0;     % units:μM
E0 = 1;     % units:μM
ES0 = 0;    % units:μM
y0 = [S0;P0;E0;ES0];  % set of init conditions
f = @(t,y) myfunc(t,y);
tf = 0.5;    %units:min
[t,y] = ode45(f,[0,tf],y0);
S = y(:,1);
P = y(:,2);
E = y(:,3);
ES = y(:,4);
% ANSWER FOR 8.2
plot(t,S,t,P,t,E,t,ES)
legend({'S','P','E','ES'},'NumColumns',2)
xlabel('Time(min)')
grid on

% ANSWER FOR 8.3
figure
S0 = 500;   % units:μM
P0 = 0;     % units:μM
E0 = 1;     % units:μM
ES0 = 0;    % units:μM
y0 = [S0;P0;E0;ES0];  % set of init conditions
f = @(t,y) myfunc(t,y);
tf = 10;
[t,y] = ode45(f,[0,tf],y0);
S = y(:,1);
P = y(:,2);
E = y(:,3);
ES = y(:,4);
v = k3 * ES;
plot(S,v)
ylabel('Velocity')
xlabel('S')
txt = 'As shown in the plot, Vm = 150';
text(5,5,txt)
grid on

% ANSWER FOR 8.1
function dydt=myfunc(t,y)
global k1 k2 k3
S = y(1);
P = y(2);
E = y(3);
ES = y(4);
dydt = zeros(4,1);
dydt(1) = -k1 * S * E + k2 * ES;
dydt(2) = k3 * ES;
dydt(3) = -k1 * S * E + (k2 + k3) * ES;
dydt(4) = k1 * S * E - (k2 + k3) * ES;
end