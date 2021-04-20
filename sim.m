% hub measurements
L_hub = 0.185; %H
R_hub = 2.18; %Ohm
Vamp = 0.159; %Volts*s/rad measured at 0 current

C = 0.033; %F
R = 3.9; %Ohm

% R = 3.2;

rpm = 60/2/pi; %wheel speed


omega_wheel = rpm*2*pi/60; % wheel speed rad/s
omega_wheel = 250/14;
num_coils = 14;

tf = 2*2*pi/(num_coils*omega_wheel);
t = linspace(0,tf,500)';
dt = mean(diff(t));

V_rect = Vamp*num_coils*omega_wheel*cos(2*num_coils*omega_wheel*t)/2 + Vamp*num_coils*omega_wheel/2;
dV_rect = gradient(V_rect,t);

V_ideal = Vamp*num_coils*omega_wheel*cos(num_coils*omega_wheel*t);
X = zeros(numel(t),1);
% X(1,1) = V_rect(1)/R;


for i = 2:numel(t)
	I = X(i-1,1);
	dI = (V_ideal(i-1,1) - I*R_hub)/L_hub;
	dX = dI;
	
	X(i,:) = X(i-1,:) + dt*dX;
end

I_hub = X(:,1);

plot(t,V_ideal,t,I_hub);
grid on;
legend('V rect','I hub');
