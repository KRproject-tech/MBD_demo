function x_new_vec = Fsys( time, x_vec, F_in, nd_vec, var_param)

disp( num2str( time, '%0.3f')) 

N_body = var_param.N_body;

%% ïœêîíäèo

q_vec = x_vec(1:N_body*7);
dt_q_vec = x_vec(N_body*7+1:end);

rG_vec = q_vec(1:N_body*3);
epsG_vec = q_vec(N_body*3+1:end);

dt_rG_vec = dt_q_vec(1:N_body*3);
dt_epsG_vec = dt_q_vec(N_body*3+1:end);



%% parameter

M_mat = var_param.M_mat;
Jd_mat = var_param.Jd_mat;

s_vec_cell = var_param.s_vec_cell;

E_mat = var_param.E_mat;
L_mat = var_param.L_mat;
A_mat = var_param.A_mat;

LG_mat = var_param.LG_mat;



LG_mat_v = LG_mat( epsG_vec);
dt_LG_mat_v = LG_mat( dt_epsG_vec); 

C_mat_v = C_mat( rG_vec, epsG_vec, s_vec_cell, A_mat);
d_r_C_mat_v = d_r_C_mat( rG_vec, epsG_vec, s_vec_cell, A_mat);
d_eps_C_mat_v = d_eps_C_mat( rG_vec, epsG_vec, s_vec_cell, E_mat, A_mat);
dt_d_r_C_mat_v = dt_d_r_C_mat( rG_vec, epsG_vec, dt_rG_vec, dt_epsG_vec, s_vec_cell, L_mat, E_mat, A_mat);
dt_d_eps_C_mat_v = dt_d_eps_C_mat( rG_vec, epsG_vec, dt_rG_vec, dt_epsG_vec, s_vec_cell, L_mat, E_mat, A_mat);

CE_mat_v = CE_mat( epsG_vec);
d_eps_CE_mat_v = d_eps_CE_mat( epsG_vec);
dt_d_eps_CE_mat_v = dt_d_eps_CE_mat( dt_epsG_vec);



%% â¡ë¨ìxï˚íˆéÆ

gamma_vec = -dt_d_r_C_mat_v*dt_rG_vec - dt_d_eps_C_mat_v*dt_epsG_vec;
gammaE_vec = -dt_d_eps_CE_mat_v*dt_epsG_vec;


%% Baumgarte ÇÃçSë©à¿íËâªñ@

alpha_v = 2.7/1e-2;
beta_v = alpha_v;

gamma_vec = gamma_vec - alpha_v*(d_r_C_mat_v*dt_rG_vec + d_eps_C_mat_v*dt_epsG_vec) - beta_v*C_mat_v;
gammaE_vec = gammaE_vec - alpha_v*d_eps_CE_mat_v*dt_epsG_vec - beta_v*CE_mat_v;

%% generate matrix

zero_mat1 = zeros(3*N_body,4*N_body);
zero_mat2 = zero_mat1(:,1:3*N_body);
zero_mat3 = zero_mat1(1:3*N_body,1:3*N_body);

Smat = [    M_mat                           zeros(9,12)                         d_r_C_mat_v.'                   zeros(9,3)         	;
            zeros(12,9)                     4*LG_mat_v.'*Jd_mat*LG_mat_v        d_eps_C_mat_v.'                 d_eps_CE_mat_v.' 	;
            d_r_C_mat_v                     d_eps_C_mat_v                       zeros(12,12)                       zeros(12,3)        	;
            zeros(3,9)                      d_eps_CE_mat_v                      zeros(3,12)                  	     zeros(3,3)              ];

b_vec = [   F_in;
            8*dt_LG_mat_v.'*Jd_mat*dt_LG_mat_v*epsG_vec + 2*LG_mat_v.'*nd_vec;
            gamma_vec;
            gammaE_vec];
        
        
        

dtt_q_lambda_vec = Smat\b_vec;
dtt_q_vec = dtt_q_lambda_vec(1:7*N_body);

x_new_vec = [   dt_q_vec;
                dtt_q_vec];

end