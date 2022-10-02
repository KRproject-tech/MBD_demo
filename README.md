# MBD_demo
Closed-loop Pendulum demo by 3D Multi-Body Dynamics 

## Overview

The Closed-loop Pendulum demo which is modeled by Quaternion based Multi-Body Dynamics.

The following dynamics for multi-bodies are solved.

$$
\left[
\begin{array}{cccc}
{\bf M_G}                       &  {\bf 0}                             & \partial_{{\bf r_G}} {\bf C}^T          & {\bf 0}                                \\
{\bf 0}                         &  4{\bf L}^T_G                        & \partial_{\bf \varepsilon} {\bf C}^T    & \partial_{\bf \varepsilon} {\bf C}^T_E \\
\partial_{{\bf r_G}} {\bf C}    & \partial_{\bf \varepsilon} {\bf C}   & {\bf 0}                                 & {\bf 0}                                \\
{\bf 0}                         & \partial_{\bf \varepsilon} {\bf C}_E & {\bf 0}                                 & {\bf 0}                                \\
\end{array}
\right]
\left[
\begin{array}{c}
\ddot{\bf r}_G\\
\ddot{\bf \varepsilon}\\
{\bf \lambda}\\
{\bf \lambda}_E\\
\end{array}
\right]
=\left[
\begin{array}{c}
{\bf F}_G\\
8d_T {\bf L}^T_G {\bf J}'_G d_T {\bf L}_G {\bf \varepsilon} + 2 {\bf L}^T_G {\bf n}'_G \\
{\bf \gamma}\\
{\bf \gamma}_E\\
\end{array}
\right],
$$

where 

$$
{\bf C} = {\bf 0}
$$

is the geometrical constraint condition, and

$$
{\bf C}_E = {\bf 0}
$$

is constraint condition for Euler parameter.



## Preparation before analysis
__[Step 1] Install the ToolBoxes__

The following ToolBoxes in “./ ToolBoxes/” are required,
*	“mmwrite” by Micah Richert:
https://jp.mathworks.com/matlabcentral/fileexchange/15881-mmwrite

__[Step 1.2] Add path to installed ToolBoxes__

Modify "add_pathes.m".


__[Step 2] Start GUI form__

Open the “GUI.fig” from MATLAB.


__[Step 2.1] Pre-setting__

Push the "Parameters" buttun and edit parameters.

__[Step 3] Start analysis__

Push the “exe” button and wait until the finish of the analysis.

__[Step 4] Plot results__

Push the “plot” button.


## Image

![untitled](https://user-images.githubusercontent.com/114337358/193453166-5903c283-3747-4d03-8900-fad1f063cee9.png)

Time series of energy (conserved)


![untitled](https://user-images.githubusercontent.com/114337358/193453224-2cabca2d-5edd-4cf3-bd9b-feab50875158.png)

Error of constraint conditions


## Movie

https://user-images.githubusercontent.com/114337358/193452979-66b5f130-e993-44fa-aaef-a5bad153d087.mp4

Chaotic behevior is generated because the masses of the left and right rigid bodies are different.


