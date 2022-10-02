function out = d_r_C_mat( rG_vec, epsG_vec, s_vec_cell, A_mat)


r1_vec = rG_vec(1:3);
r2_vec = rG_vec(4:6);
r3_vec = rG_vec(7:9);

eps1_vec = epsG_vec(1:4);
eps2_vec = epsG_vec(5:8);
eps3_vec = epsG_vec(9:12);

s11_vec = s_vec_cell{1};
s12_vec = s_vec_cell{2};
s21_vec = s_vec_cell{3};
s22_vec = s_vec_cell{4};
s31_vec = s_vec_cell{5};
s32_vec = s_vec_cell{6};

A_mat1_v = A_mat( eps1_vec);
A_mat2_v = A_mat( eps2_vec);
A_mat3_v = A_mat( eps3_vec);



out = [     eye(3)                                zeros(3,3)                               zeros(3,3)        ;
            eye(3)                                -eye(3)                                  zeros(3,3)        ;
            zeros(3,3)                              eye(3)                                  -eye(3)          ;
            zeros(3,3)                              zeros(3,3)                              eye(3)           ];
           
            
end