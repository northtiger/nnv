
W1 = [2 0; 1 -1; 1 1];  
b1 = [0.5; -1; -0.5];
L1 = Layer(W1, b1, 'ReLU'); % first layer

W2 = [-1 0 1; 1 -1 0];  
b2 = [-0.5; 0.5];
L2 = Layer(W2, b2, 'ReLU'); % second layer

Layers = [L1 L2]; % construct an array of layers

F = FFNN(Layers); % construct a feedforward neural network

lb = [0; 0];
ub = [2; 2];

% sampled pointed
s1 = [0; 0];
s2 = [1; 1];
s3 = [2; 2];
s4 = [0; 2];
s5 = [2; 0];
S = horzcat(s1, s2, s3, s4, s5);

I = Polyhedron('lb', lb, 'ub', ub);
Y = F.sample(S);

% plot figure of input set and some sampled points of the input set
fig = figure;
subplot(1, 3, 1);
I.plot;
hold on; 
plot(S(1, :), S(2, :), '*');
title('Input Set', 'FontSize', 20);
xlabel('x_1', 'FontSize', 16);
ylabel('x_2', 'FontSize', 16);

[R1, t1] = L1.reach_approx_box_coarse(I, 1, 'single'); % exact reachable set of layer 1
[R2, t2] = L2.reach_approx_box_coarse(R1, 1,'single'); % exact reachable set of layer 2

subplot(1, 3, 2);
R1.plot;
hold on;
plot3(Y{1, 1}(1, :), Y{1, 1}(2, :), Y{1, 1}(3, :), '*');
title('Hidden Layer Reachable Set', 'FontSize', 20);
xlabel('x_1', 'FontSize', 16);
ylabel('x_2', 'FontSize', 16);
zlabel('x_3', 'FontSize', 16);

subplot(1, 3, 3);
R2.plot;
hold on;
plot(Y{1, 2}(1, :), Y{1, 2}(2, :), '*');
title('Output Layer Reachable Set', 'FontSize', 20);
xlabel('y_1', 'FontSize', 16);
ylabel('y_2', 'FontSize', 16);