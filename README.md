# IndirectFOCControl
This is a project with the goal of simulate an Indirect Field Oriented Control of an induction motor for the exams of Control of Electrical Drives.
The principal target of the assignment is to implement an indirect Field Oriented Control (Hasse) on an induction motor and simulate a given scenario. The motor is powered by a VSI inverter, which is connected to a DC source of 350V.

![alt text](ProjectTasks.jpg)

The motor parameter have been derived from the plate data (we also have neglected iron losses and mechanical losses), in particular the plate look like:

| Name | Value |
| ----------- | ----------- |
| $P_{n}$ | 150 kW |
| $V_{n}$ | 220 V |
| $f_{n}$ | 300Hz |
| $s_{n}$ | 0.015 |
| $p$ | 6 |
| $J$ | 5 kgm^2 |

So the velocity of the rotating magnetic field is $w_{0} = \frac{2\pi f_{n}}{p} =$ 314.16 rad/s.
Also we need to assume other usefull parameter of the machine in order to obtain a complete description of its mathematicaal model:

| Name | Value | Description | Why |
| ----------- | ----------- | ----------- | ----------- |
| $\eta$ | 0.97 | Efficiency | Based on other similar motors |
| $cos \phi$ | 0.95 | Power Factor | Based on other similar motors |
| $V_{ny}$ | $\frac{V_{n}}{\eta} =$ 127 V | Line Voltage | Formula from Nominal Voltage |
| $P_{a}$ | $\frac{P_{n}}{\eta}$ | Input Power | Formula from Nominal Power |
| $I_{n}$ | $\frac{P_{n}}{3V_{ny}cos\phi} =$ 427.2 A | Nominal Current | Formula from Input Power |
| $T_{n}$ | $\frac{P_{n}}{w_{n}} =$ 484.7 Nm | Nominal Torque | Power formula |
| $T_{k}$ | $2T_{n}$ | Peak Torque | based on other similar motors |
| $I_{mn}$ | $0.35I_{n} =$ 149.5 A | Magnetizing Current | Tipically used formula |
| $w_{n}$ | $w_{0}(1-s_{n}) =$ 307.9 rad/s | Nominal Speed | Formula from Nominal Slip |

After we got the values of the equivalent circuit, to simulate properly the induction motor:

| Name | Value | Description | 
| ----------- | ----------- | ----------- | 
| $L_{\sigma t}$ | $3p\frac{1.73V_n}{2w_{0}^2T_{k}}$ | Total leakage Inductance | 
| $L_{\sigma s}$ | $0.5L_{\sigma t}$ | Stator leakage Inductance | 
| $L_{\sigma r}$ | $0.5L_{\sigma t}$ | Rotor leakage Inductance |
| $R_{r}$ | $\frac{P_{n}S_{n}}{3I_{n}^2(1-s_{n})}$| Rotor Resistance |
| $R_{s}$ | $\frac{P_{js}}{3I_{n}^2}$ | Stator Resistance |
| $L_{\mu}$ | $\frac{1.73V_{n}}{I_{mn}w_{0}}$ | Mutual Inductance |
