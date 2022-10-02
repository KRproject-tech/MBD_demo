function out = d_eps_C_mat( rG_vec, epsG_vec, s_vec_cell, E_mat, A_mat)


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

E_mat1_v = E_mat( eps1_vec);
E_mat2_v = E_mat( eps2_vec);
E_mat3_v = E_mat( eps3_vec);


d_eps1_C = [	2*E_mat1_v*Bm_mat( s11_vec) + 2*s11_vec*eps1_vec.'                       ; 
                2*E_mat1_v*Bm_mat( s12_vec) + 2*s12_vec*eps1_vec.'                       ;  
                zeros(3,4)                                                               ;
                zeros(3,4)                                                               ];
                                                                 
d_eps2_C = [	zeros(3,4)                                                             	;
                -2*E_mat2_v*Bm_mat( s21_vec) - 2*s21_vec*eps2_vec.'                    	; 
                2*E_mat2_v*Bm_mat( s22_vec) + 2*s22_vec*eps2_vec.'                      ;
                zeros(3,4)                                                             	];
            
d_eps3_C = [	zeros(3,4)                                                              ;
                zeros(3,4)                                                              ;  
                -2*E_mat3_v*Bm_mat( s31_vec) - 2*s31_vec*eps3_vec.'                     ;
                2*E_mat3_v*Bm_mat( s32_vec) + 2*s32_vec*eps3_vec.'                      ];

           
out = [ d_eps1_C    d_eps2_C    d_eps3_C ];
end