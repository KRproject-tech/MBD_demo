function out = CE_mat( epsG_vec)


eps1_vec = epsG_vec(1:4);
eps2_vec = epsG_vec(5:8);
eps3_vec = epsG_vec(9:12); %



out = [	eps1_vec.'*eps1_vec - 1;
       	eps2_vec.'*eps2_vec - 1;
     	eps3_vec.'*eps3_vec - 1]; %
                                                                 
                                 
end