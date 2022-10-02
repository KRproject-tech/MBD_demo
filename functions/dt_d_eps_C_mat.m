function out = dt_d_eps_C_mat( rG_vec, epsG_vec, dt_rG_vec, dt_epsG_vec, s_vec_cell, L_mat, E_mat, A_mat)


r1_vec = rG_vec(1:3);
r2_vec = rG_vec(4:6);
r3_vec = rG_vec(7:9);

eps1_vec = epsG_vec(1:4);
eps2_vec = epsG_vec(5:8);
eps3_vec = epsG_vec(9:12);

dt_r1_vec = dt_rG_vec(1:3);
dt_r2_vec = dt_rG_vec(4:6);
dt_r3_vec = dt_rG_vec(7:9);

dt_eps1_vec = dt_epsG_vec(1:4);
dt_eps2_vec = dt_epsG_vec(5:8);
dt_eps3_vec = dt_epsG_vec(9:12);

s11_vec = s_vec_cell{1};
s12_vec = s_vec_cell{2};
s21_vec = s_vec_cell{3};
s22_vec = s_vec_cell{4};
s31_vec = s_vec_cell{5};
s32_vec = s_vec_cell{6};

dt_E_mat1_v = E_mat( dt_eps1_vec);
L_mat1_v = L_mat( eps1_vec);

dt_E_mat2_v = E_mat( dt_eps2_vec);
L_mat2_v = L_mat( eps2_vec);

dt_E_mat3_v = E_mat( dt_eps3_vec);
L_mat3_v = L_mat( eps3_vec);



dt_d_eps1_C = [	 2*(dt_E_mat1_v*Bm_mat( s11_vec) + s11_vec*dt_eps1_vec.' )               ;
                 2*(dt_E_mat1_v*Bm_mat( s12_vec) + s12_vec*dt_eps1_vec.' )               ;
                 zeros(3,4)                                                              ;
                 zeros(3,4)                                                              ];
                                                                 
dt_d_eps2_C = [	zeros(3,4)                                                               ;
                -2*(dt_E_mat2_v*Bm_mat( s21_vec) + s21_vec*dt_eps2_vec.' )               ;
                2*(dt_E_mat2_v*Bm_mat( s22_vec) + s22_vec*dt_eps2_vec.' )                ;
                zeros(3,4)                                                               ];
   
dt_d_eps3_C = [	zeros(3,4)                                                               ;
               	zeros(3,4)                                                               ;
                -2*(dt_E_mat3_v*Bm_mat( s31_vec) + s31_vec*dt_eps3_vec.' )               ;
                2*(dt_E_mat3_v*Bm_mat( s32_vec) + s32_vec*dt_eps3_vec.' )                ];
                    
                    
            
out = [ dt_d_eps1_C    dt_d_eps2_C    dt_d_eps3_C ];
end