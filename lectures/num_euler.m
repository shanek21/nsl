% Written by Brian Storey

clear; figure(1); clf;

A = [0 1; -1 0];  %%% mass-spring equations
I = eye(2);       %%% Identity matrix
dt = 0.02;         %%% dt 

x = [1;0];        %%% initial conditions
t = 0;

%M = (I + dt*A);  %%% Matrix to iterate - backward euler
M = inv(I - dt*A);  %%% Matrix to iterate - backward euler
for i = 1:10/dt
    t = t + dt;
    x = M*x;
    plot(t,x,'.')
    hold on
end
