clc
clear all
close all

%% delete
delete( '*.asv')

%% path
add_pathes

%% parameter
param_setting

%% initialize
initializing


%% multi threading
maxNumCompThreads( core_num);

%% load
load ./save/NUM_DATA



%% ã«èäç¿ïWånÉfÅ[É^

for iii=1:N_body %
    
    [ x_body, y_body, z_body] = ellipsoid( 0, 0, 0, Rx(iii), Ry(iii), Rz(iii));
    r_body_T = [ x_body(:) y_body(:) z_body(:)];
    
    h_r_body_T(iii) = { r_body_T };
end


R_G_vec_T = @( rG_vec, eps_vec, r_body_T)( ones(size( r_body_T, 1),1)*rG_vec.' + r_body_T*A_mat( eps_vec).' );

%% plot

i_ax = 1;

q_vec = h_x_vec(1:7*N_body,1);

rG_vec = q_vec(1:3*N_body); 
epsG_vec = q_vec(3*N_body+1:end);

rG1_vec = rG_vec(1:3);
rG2_vec = rG_vec(4:6);
rG3_vec = rG_vec(7:end);%

epsG1_vec = epsG_vec(1:4);
epsG2_vec = epsG_vec(5:8);
epsG3_vec = epsG_vec(9:end);%

%%[*] çÑëÃ1
R_G1_vec_T_v = R_G_vec_T( rG1_vec, epsG1_vec, h_r_body_T{1});
X_G1 = reshape( R_G1_vec_T_v(:,1), size( x_body, 1), []);
Y_G1 = reshape( R_G1_vec_T_v(:,2), size( y_body, 1), []);
Z_G1 = reshape( R_G1_vec_T_v(:,3), size( z_body, 1), []);

%%[*] çÑëÃ2
R_G2_vec_T_v = R_G_vec_T( rG2_vec, epsG2_vec, h_r_body_T{2});
X_G2 = reshape( R_G1_vec_T_v(:,1), size( x_body, 1), []);
Y_G2 = reshape( R_G1_vec_T_v(:,2), size( y_body, 1), []);
Z_G2 = reshape( R_G1_vec_T_v(:,3), size( z_body, 1), []);

%%[*] çÑëÃ3 
R_G3_vec_T_v = R_G_vec_T( rG3_vec, epsG3_vec, h_r_body_T{3});
X_G3 = reshape( R_G1_vec_T_v(:,1), size( x_body, 1), []);
Y_G3 = reshape( R_G1_vec_T_v(:,2), size( y_body, 1), []);
Z_G3 = reshape( R_G1_vec_T_v(:,3), size( z_body, 1), []);

h_fig(1) = figure(1);
set( h_fig(1), 'Position', [100 100 1000 800], 'render', 'zbuffer')
h_ax(i_ax) = axes( 'Parent', h_fig(1), 'FontSize', 15);

h_plot1 = surf( h_ax(i_ax), X_G1, Y_G1, Z_G1, 'FaceColor', 'interp');
hold( h_ax(i_ax), 'on')
h_plot2 = surf( h_ax(i_ax), X_G2, Y_G2, Z_G2, 'FaceColor', 'interp');
light
h_plot3 = surf( h_ax(i_ax), X_G3, Y_G3, Z_G3, 'FaceColor', 'interp'); %
light

view( h_ax(i_ax), [ 1 1 1])
xlabel( h_ax(i_ax), '{\itX} [m]')
ylabel( h_ax(i_ax), '{\itY} [m]')
zlabel( h_ax(i_ax), '{\itZ} [m]')

axis equal
set( h_ax(i_ax), 'FontName', 'Times New Roman')


h_txt(1) = text( -1, -1, 0, [ 'Time = ', num2str( 0, '%0.3f'), ' [s]'],...
                'FontSize', 12, 'FontName', 'Times New Roman', 'BackgroundColor', 'g');


            
            
            
%% animation

movie_data = struct( 'cdata', [], 'colormap', []);
movie_time = time_v;

h_C_mat_v = zeros(4*N_body,length( time_v)); %% èåèéÆêî
h_CE_mat_v = zeros(N_body,length( time_v));
h_Te = zeros(1,length( time_v));
h_Ue = zeros(1,length( time_v));

i_time = 1;
for time = time_v
    
    q_vec = h_x_vec(1:7*N_body,i_time);
    dt_q_vec = h_x_vec(7*N_body+1:end,i_time);

    rG_vec = q_vec(1:3*N_body); 
    epsG_vec = q_vec(3*N_body+1:end);

    rG1_vec = rG_vec(1:3);
    rG2_vec = rG_vec(4:6);
    rG3_vec = rG_vec(7:end);

    epsG1_vec = epsG_vec(1:4);
    epsG2_vec = epsG_vec(5:8);
    epsG3_vec = epsG_vec(9:end);
    
    dt_rG_vec = dt_q_vec(1:3*N_body); 
    dt_epsG_vec = dt_q_vec(3*N_body+1:end);
    

    %%[*] çÑëÃ1
    R_G1_vec_T_v = R_G_vec_T( rG1_vec, epsG1_vec, h_r_body_T{1});
    X_G1 = reshape( R_G1_vec_T_v(:,1), size( x_body, 1), []);
    Y_G1 = reshape( R_G1_vec_T_v(:,2), size( y_body, 1), []);
    Z_G1 = reshape( R_G1_vec_T_v(:,3), size( z_body, 1), []);

    %%[*] çÑëÃ2
    R_G2_vec_T_v = R_G_vec_T( rG2_vec, epsG2_vec, h_r_body_T{2});
    X_G2 = reshape( R_G2_vec_T_v(:,1), size( x_body, 1), []);
    Y_G2 = reshape( R_G2_vec_T_v(:,2), size( y_body, 1), []);
    Z_G2 = reshape( R_G2_vec_T_v(:,3), size( z_body, 1), []);
    
    %%[*] çÑëÃ3 %
    R_G3_vec_T_v = R_G_vec_T( rG3_vec, epsG3_vec, h_r_body_T{3});
    X_G3 = reshape( R_G3_vec_T_v(:,1), size( x_body, 1), []);
    Y_G3 = reshape( R_G3_vec_T_v(:,2), size( y_body, 1), []);
    Z_G3 = reshape( R_G3_vec_T_v(:,3), size( z_body, 1), []);
    
    
    %% êßñÒèåè
    h_C_mat_v(:,i_time) = C_mat( rG_vec, epsG_vec, s_vec_cell, A_mat);
    h_CE_mat_v(:,i_time) = CE_mat( epsG_vec);
    
    %% ÉGÉlÉãÉM
    LG_mat_v = LG_mat( epsG_vec);
    Te = 1/2*dt_rG_vec.'*M_mat*dt_rG_vec + 1/2*4*dt_epsG_vec.'*LG_mat_v.'*Jd_mat*LG_mat_v*dt_epsG_vec;
    Ue = mass(1)*g_acc*(rG1_vec(3) + Rx(1)) + mass(2)*g_acc*(rG2_vec(3) + 2*Rx(1) + Rx(2)) + mass(3)*g_acc*(rG3_vec(3) + 2*Rx(1) + 2*Rx(2) + Rx(3));
    
    h_Te(i_time) = Te;
    h_Ue(i_time) = Ue;
    
    %% plot
    
    set( h_plot1, 'XData', X_G1, 'YData', Y_G1, 'ZData', Z_G1)
    set( h_plot2, 'XData', X_G2, 'YData', Y_G2, 'ZData', Z_G2)
    set( h_plot3, 'XData', X_G3, 'YData', Y_G3, 'ZData', Z_G3)
    
    xlim( h_ax(i_ax), [-2 2])
    ylim( h_ax(i_ax), [-2 1])
    zlim( h_ax(i_ax), [-2 1])
    
    set( h_txt(1), 'String', [ 'Time = ', num2str( time, '%0.3f'), ' [s]']);
    
    movie_data(i_time) = getframe( h_fig(1));   
    
    drawnow
    
    i_time = i_time + 1;
    
end

i_ax = i_ax + 1;



%% ÉGÉlÉãÉMÅ[ï]âø


h_fig(2) = figure(2);
set( h_fig(2), 'Position', [100 100 1000 800])
h_ax(i_ax) = axes( 'Parent', h_fig(2), 'FontSize', 15);

h_plot3 = area( time_v, [h_Te; h_Ue].', 'Parent', h_ax(i_ax));
xlabel( h_ax(i_ax), 'Time [s]')
ylabel( h_ax(i_ax), 'Energy [J]')

set( h_plot3(1), 'FaceColor', 'r')
set( h_plot3(2), 'FaceColor', 'b')

legend( h_ax(i_ax), 'Kinetic Energy', 'Total Energy')



i_ax = i_ax + 1;




%% çSë©èåèï]âø


h_fig(3) = figure(3);
set( h_fig(3), 'Position', [100 100 1000 800])
h_ax(i_ax) = axes( 'Parent', h_fig(3), 'FontSize', 15);

plot( h_ax(i_ax), time_v, h_C_mat_v, '-', time_v, h_CE_mat_v, '--');
xlabel( h_ax(i_ax), 'Time [s]')
ylabel( h_ax(i_ax), 'Error of constraint condition [a.u.]')


legend( h_ax(i_ax), 'Geometrical constraint (body 1)', 'Geometrical constraint (body 2)', 'Euler parameter (body 1)', 'Euler parameter (body 2)')



i_ax = i_ax + 1;





%% save

fig_name = { 'behavior', 'energy', 'error_of_constraint_condition'};

for iii = 1:length( h_fig)
   saveas( h_fig(iii), [ './save/fig/', fig_name{iii}, '.fig']) 
end

%% create movie


video.frames = movie_data;
video.width=size( video.frames(1).cdata, 2);
video.height=size( video.frames(1).cdata, 1);
video.times = movie_time;

mmwrite( './save/data.wmv', video)



%% Finish
warndlg( 'Finish!')



