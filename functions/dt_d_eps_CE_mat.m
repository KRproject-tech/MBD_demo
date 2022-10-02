function out = dt_d_eps_CE_mat( dt_epsG_vec)


dt_eps1_vec = dt_epsG_vec(1:4);
dt_eps2_vec = dt_epsG_vec(5:8);
dt_eps3_vec = dt_epsG_vec(9:12);



out = [	2*dt_eps1_vec.'     zeros(1,4)         zeros(1,4);
     	zeros(1,4)          2*dt_eps2_vec.'    zeros(1,4);
        zeros(1,4)          zeros(1,4)         2*dt_eps3_vec.'];                                              
                                 
end