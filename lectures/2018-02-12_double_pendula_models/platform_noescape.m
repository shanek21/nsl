function platform_noescape()
figure(1); clf;

% create the solution from ODE45
x0 = [1;0;0.8;0.1;0;0];   %% initial condition theta1, omega1, theta2, omega2, Y, dY/dt
[T,X] = ode45(@derivs,[0 150],x0);
plot(T,X(:,5),'r')
hold on
plot(T,X(:,3)+X(:,1),'b')

% create the analytical solution from eigens
[T,X] = analytical_soln(150,x0);
plot(T,real(X(1,:)+ X(3,:)),'b.'); 
plot(T,real(X(5,:)),'r.')

end

% function to compute right hand side of ode system
function dxdt = derivs(t,x)        
    A = linear_matrix();
    dxdt= A*x;
end

% Create the matrix to get the linear problem as dX/dt = A x 
function A = linear_matrix()
    % dimensionless parameters
    mu = 0.1;    %% mass ratio
    g = 0.001;   %% pendulum damping
    G = 0.1;     %% Cart damping
    % note I am leaving out cart spring since we arent using it
    
    % left side of equation matrix, it is not the 
    % identity since there are 2 second derivs in one eqn
    A = [1  0  0  0  0  0; 
         0  1  0  0  0  1; 
         0  0  1  0  0  0; 
         0  0  0  1  0  1; 
         0  0  0  0  1  0; 
         0 mu  0 mu  0  1];
     
    % right side of the equation matrix 
    B = [ 0    1  0    0  0    0 ;
         -1 -2*g  0    0  0    0 ;
          0    0  0    1  0    0 ;
          0    0 -1 -2*g  0    0 ;
          0    0  0    0  0    1 ; 
          0    0  0    0  0 -2*G];
      
    % to get in form dX/dt = AX
    A = inv(A)*B;
end

% Compose the analytical solution to the linear problem
function [t,x] = analytical_soln(Tspan,x0)

    A = linear_matrix(); % same matrix as in numerical solution 
    [P,D] = eig(A);      % get the eignevalues and vectors
    c = inv(P)*x0;       % get constants from initial condition

    t = linspace(0,Tspan,1000);
    x  = zeros(size(t));
    % sum over six eigenvalues
    for i = 1:6
        x = x  + c(i)*P(:,i)*exp(D(i,i)*t);  %% compose the solution as sum of eigens
    end
end