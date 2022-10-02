function out = d_eps_CE_mat( epsG_vec)


eps1_vec = epsG_vec(1:4);
eps2_vec = epsG_vec(5:8);
eps3_vec = epsG_vec(9:12);




out = [	2*eps1_vec.'     zeros(1,4)       zeros(1,4);
     	zeros(1,4)       2*eps2_vec.'     zeros(1,4);
        zeros(1,4)       zeros(1,4)       2*eps3_vec.'];                                                       
                                 
end