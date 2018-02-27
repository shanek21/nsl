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

    # d theta/dt = omega, d omega/dt = -sin(theta) - 2*g*omega^2
    dxdt = [omega, -math.sin(theta) - 2*g*omega]

    return dxdt


start = 0
stop = 200
samples_per_second = 100
num_samples = (stop - start) * samples_per_second
time = np.linspace(start, stop, num_samples)
x0 = [1, 0] # initial condition [angle, angular velocity]
g = 0.02 # linear viscous damping coefficient
sol = odeint(derivs, x0, time, args=(g,))
angle, angular_velocity = sol.T

plt.plot(time, angle)
plt.plot(time, angular_velocity)
plt.title('Nonlinear Oscillator')
plt.xlabel('Time (unitless)')
plt.legend(['Angle', 'Angular Velocity'])
plt.show()
