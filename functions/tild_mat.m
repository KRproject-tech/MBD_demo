function out = tild_mat( x_vec)

out = [ 0           -x_vec(3)   x_vec(2)    ;
        x_vec(3)    0           -x_vec(1)   ;
        -x_vec(2)   x_vec(1)    0           ];
end