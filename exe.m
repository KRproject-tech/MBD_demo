clc
clear all
close all

%% delete
delete( '*.asv')

%% path
add_pathes

%% parameter
param_setting

%% multi threading
maxNumCompThreads( core_num);


%% ŠÔ”­“W


[ time_vec, h_x_vec] = ode45( @( time, x_vec)Fsys( time, x_vec, F_in_time( time), nd_vec_time( time), var_param), [ 0 End_Time], x0_vec);

time_vec = time_vec.';
h_x_vec = h_x_vec.';


%% “™ŠÔŠÔŠu‚ÉC³ [s]

[ N_x, N_time] = size( h_x_vec);

time_v = 0:d_T:End_Time;

h_x_vec = interp2( ones(N_x,1)*time_vec, (1:N_x).'*ones(1,N_time), h_x_vec, ones(N_x,1)*time_v, (1:N_x).'*ones(1,length( time_v)));





%% save 

save ./save/NUM_DATA


%% Finish
warndlg( 'Finish!')