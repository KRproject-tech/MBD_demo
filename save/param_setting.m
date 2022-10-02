%% parameters


%% ‰ğÍğŒ
End_Time = 10;                                                                              %% ‰ğÍŠÔ [s]
d_T = 1e-2;                                                                                 %% ‚İŠÔ [s]
core_num = 6;                                                                               %% CPU” [-]



%% parameter

%
Rx = [ 0.5 0.5 0.5 ];                                                                          	%% x²Ø•Ğ [m]
Ry = [ 0.1 0.1 0.1 ];                                                                        	%% y²Ø•Ğ [m]
Rz = [ 0.1 0.1 0.1 ];                                                                          	%% z²Ø•Ğ [m]
mass = [ 2.0 5.0 1.0 ];                                                                          %% [kg]

Ix = 1/5*mass.*(Ry.^2+Rz.^2);                                                                %% [kgm^2]
Iy = 1/5*mass.*(Rz.^2+Rx.^2);
Iz = 1/5*mass.*(Rx.^2+Ry.^2);

N_body = length( mass); 

M_mat = [];
Jd_mat = [];
for iii = 1:N_body %
    
    M_mat = blkdiag( M_mat, mass(iii)*eye(3));            
    Jd_mat = blkdiag( Jd_mat, diag( [ Ix(iii) Iy(iii) Iz(iii)]));
end

s11_vec = [ -Rx(1) 0 0].';
s12_vec = [ Rx(1) 0 0].';
s21_vec = [ -Rx(2) 0 0].';
s22_vec = [ Rx(2) 0 0].'; 
s31_vec = [ -Rx(3) 0 0].';
s32_vec = [ Rx(3) 0 0].'; 

s_vec_cell = { s11_vec, s12_vec, s21_vec, s22_vec, s31_vec, s32_vec};



L_mat = @( eps_vec)( [ -eps_vec(2:4) eps_vec(1)*eye(3)-tild_mat( eps_vec(2:4))] ); 
E_mat = @( eps_vec)( [ -eps_vec(2:4) eps_vec(1)*eye(3)+tild_mat( eps_vec(2:4))] ); 

LG_mat = @( epsG_vec)( blkdiag( L_mat( epsG_vec(1:4)), L_mat( epsG_vec(5:8)), L_mat( epsG_vec(9:12))));

A_mat = @( eps_vec)( E_mat( eps_vec)*L_mat(eps_vec).' );                                    %% ‰ñ“]Šî–{s—ñ



%% ‰ğÍ‰ŠúğŒ


g_acc = 9.807;                                                                          %% d—Í‰Á‘¬“x [m/s^2]


%%[*] „‘Ì1
u0_vec = [ 1 0 0].';                                                                    %% ‰ñ“]² [-]
Theta = pi/4;                                                                           %% ‰ñ“]Šp [rad]
dt_Theta = 0*pi;                                                                        %% ‰ñ“]Šp‘¬“x [rad/s]

r1_0_vec = [ Rx(1) 0 0].';                                                     %% dS‰ŠúˆÊ’u [m]
eps1_0_vec = [ cos(Theta/2) sin(Theta/2)*u0_vec.'].';

dt_eps1_0_vec = [ -dt_Theta/2*sin(Theta/2) dt_Theta/2*cos(Theta/2)*u0_vec.'].';

%%[*] „‘Ì2            
            
u0_vec = [ 0 0 1 ].';                                                                    %% ‰ñ“]² [-]
Theta = -pi/2;                                                                           %% ‰ñ“]Šp [rad]
dt_Theta = 0*pi;                                                                        %% ‰ñ“]Šp‘¬“x [rad/s]

r2_0_vec = [ 2*Rx(1) -Rx(2) 0].';                                                    	%% dS‰ŠúˆÊ’u [m]
eps2_0_vec = [ cos(Theta/2) sin(Theta/2)*u0_vec.'].';

dt_eps2_0_vec = [ -dt_Theta/2*sin(Theta/2) dt_Theta/2*cos(Theta/2)*u0_vec.'].';

%%[*] „‘Ì3 %            
            
u0_vec = [ 0 1 0].';                                                                    %% ‰ñ“]² [-]
Theta = pi;                                                                           %% ‰ñ“]Šp [rad]
dt_Theta = 0*pi;                                                                        %% ‰ñ“]Šp‘¬“x [rad/s]

r3_0_vec = [ Rx(3) -2*Rx(2)  0].';                                                    	%% dS‰ŠúˆÊ’u [m]
eps3_0_vec = [ cos(Theta/2) sin(Theta/2)*u0_vec.'].';

dt_eps3_0_vec = [ -dt_Theta/2*sin(Theta/2) dt_Theta/2*cos(Theta/2)*u0_vec.'].';

%%[*] •Ï”‘g‚İ—§‚Ä
rG0_vec = [ r1_0_vec; %
            r2_0_vec;
            r3_0_vec];
        
epsG0_vec = [   eps1_0_vec; %
                eps2_0_vec;
                eps3_0_vec];

dt_epsG0_vec = [ dt_eps1_0_vec %
                 dt_eps2_0_vec
                 dt_eps3_0_vec];

dt_rG0_vec = -d_r_C_mat( rG0_vec, epsG0_vec, s_vec_cell, A_mat)\d_eps_C_mat( rG0_vec, epsG0_vec, s_vec_cell, E_mat, A_mat)*dt_epsG0_vec; %%

     
            
x0_vec = [  rG0_vec;
            epsG0_vec;
            dt_rG0_vec;
            dt_epsG0_vec];

F_in_time = @( time)-g_acc*kron( mass.', ones(3,1)).*[ 0 0 1 0 0 1 0 0 1].'; %
nd_vec_time = @( time)[ 0 0 0 0 0 0 0 0 0].';  %




%% global •Ï”

var_param.N_body = N_body;

var_param.M_mat = M_mat;
var_param.Jd_mat = Jd_mat;

var_param.s_vec_cell = s_vec_cell;

var_param.E_mat = E_mat;
var_param.L_mat = L_mat;
var_param.A_mat = A_mat;

var_param.LG_mat = LG_mat;







