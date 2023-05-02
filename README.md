![図1](https://user-images.githubusercontent.com/114337358/220136197-51255e96-66a8-4526-bcf6-f5539878bc44.png)

# <p align=center>MBD_demo</p>

**Communication**

<a style="text-decoration: none" href="https://twitter.com/hogelungfish" target="_blank">
    <img src="https://img.shields.io/badge/twitter-%40hogelungfish-1da1f2.svg" alt="Twitter">
</a>
<p>

**Language**
<p>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/matlab/matlab-original.svg" width="60"/>
<p>


__Closed-loop Pendulum smaple code by 3D Multi-Body Dynamics__ 

## Overview

The Closed-loop Pendulum demo which is modeled by Quaternion based Multi-Body Dynamics.

The following dynamics for multi-bodies are solved [^2].

$$
\left[
\begin{array}{cccc}
{\bf M_G}                       &  {\bf 0}                             & \partial_{{\bf r_G}} {\bf C}^T          & {\bf 0}                                \\
{\bf 0}                         & 4{\bf L_G}^T {\bf J_G}' {\bf L_G}    & \partial_{\bf \varepsilon} {\bf C}^T    & \partial_{\bf \varepsilon} {\bf C}^T_E \\
\partial_{{\bf r_G}} {\bf C}    & \partial_{\bf \varepsilon} {\bf C}   & {\bf 0}                                 & {\bf 0}                                \\
{\bf 0}                         & \partial_{\bf \varepsilon} {\bf C}_E & {\bf 0}                                 & {\bf 0}                                \\
\end{array}
\right]
\left[
\begin{array}{c}
\ddot{\bf r}_G          \\
\ddot{\bf \varepsilon}  \\
{\bf \lambda}           \\
{\bf \lambda}_E         \\
\end{array}
\right]
=\left[
\begin{array}{c}
{\bf F}_G                                                                               \\
8d_T {\bf L}^T_G {\bf J}'_G d_T {\bf L}_G {\bf \varepsilon} + 2 {\bf L}^T_G {\bf n}'_G  \\
{\bf \gamma}                                                                            \\
{\bf \gamma}_E                                                                          \\
\end{array}
\right],
$$
    
where 

$$
{\bf C} ({\bf r_G}, {\bf \varepsilon}) = {\bf 0},
$$

is the geometrical constraint condition, and

$$
{\bf C}_E ({\bf \varepsilon}) := 
\left[
\begin{array}{c}
{\bf \varepsilon}^T_1 {\bf \varepsilon}_1 - 1  \\
\vdots \\
{\bf \varepsilon}^T_N {\bf \varepsilon}_N - 1  \\
\end{array}
\right] = {\bf 0},
$$

is constraint condition for Euler parameter.

Baumgarte constraint stabilization method [^1] is employed to above Differential-algebraic system of equations (DAE).

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

### References
[^1]: J. Baumgarte，“Stabilization of Constraints and Integrals of Motion in Dynamical Systems”，Computer Methods in Applied Mechanics and Engineering，pp.1–16，1972.

[^2]: 日本機械学会編，マルチボディダイナミクス〈1〉基礎理論，コロナ社．
