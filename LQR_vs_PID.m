%% State Space representation
A = [-0.38 0.60 -3.36 -9.80; -0.98 -7.81 15.32 -0.21; 0.18 -8.31 -35.21 0; 0 0 1 0];
B = [-0.36; -3.62; -106.32; 0];
C = [0 0 1 0];
D = [0];
state_space = ss(A,B,C,D);

%% Open Loop Transfer Function and Analysis
[num,den] = ss2tf(A,B,C,D,1);
open_loop_tf = tf(num,den);
t = [0:0.01:15];
figure(1);
subplot(2,1,1);
impulse(open_loop_tf,t);
xlabel('Time (s)');
ylabel('Pitch angle (rad)');
title('Open Loop Impulse Response');
subplot(2,1,2);
step(open_loop_tf,t);
xlabel('Time (s)');
ylabel('Pitch angle (rad)');
title('Open Loop Step Response');

%% LQR method
Q = 1/28*C'*C;
R = 1;
[K1,S1,P1] = lqr(A,B,Q,R);
sys1 = ss(A-B*K1,B,C,D);
figure(3);
step(sys1);
xlabel('Time (s)');
ylabel('Pitch angle (rad)');
title('Step Response of LQR Controller for 6-DOF Fixed Wing');
