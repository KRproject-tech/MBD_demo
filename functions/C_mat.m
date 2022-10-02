function out = C_mat( rG_vec, epsG_vec, s_vec_cell, A_mat)


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

r32 = [ 0 -1 0 ].';

out = [     r1_vec + A_mat1_v*s11_vec                                                         ;       %% r1_vec+s11_vec
            (r1_vec - r2_vec) + A_mat1_v*s12_vec - A_mat2_v * s21_vec                         ;       %% ((r1_vec - r2_vec)+(s12_vec-s21_vec))
            (r2_vec - r3_vec) + A_mat2_v*s22_vec - A_mat3_v * s31_vec                         ;      %% ((r2_vec - r3_vec)+(s22_vec-s31_vec))
            r3_vec + A_mat3_v*s32_vec - r32                                                   ];
                                                                 
                                 
end                  