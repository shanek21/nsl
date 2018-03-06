import math
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint


def derivs(x, t, g):
    """
    @param x - a vector of current state [angle, angular velocity]
    @param t - current time in seconds
    @param g - linear viscous damping coefficient
    @return derivatives of angle and angular velocity [change in angle, change in angular velocity]
    """

    theta, omega = x # angle, angular velocity

    dxdt = []
    dxdt.append(omega) # d theta/dt = omega
    dxdt.append(-math.sin(theta) - 2*g*omega*abs(omega)) # d omega/dt = -sin(theta) - 2*g*omega^2

    return dxdt


# Calculate solution
start = 0
stop = 350
samples_per_second = 100
num_samples = (stop - start) * samples_per_second
time = np.linspace(start, stop, num_samples)
x0 = [0.75, 0] # initial condition [angle, angular velocity]
g = 0.000858 # linear viscous damping coefficient
sol = odeint(derivs, x0, time, args=(g,))
angle, angular_velocity = sol.T

# Plot
plt.plot(time, angle)
plt.plot(time, angular_velocity)
plt.title('Nonlinear Oscillator')
plt.xlabel('Time (unitless)')
plt.legend(['Angle', 'Angular Velocity'])
plt.show()
