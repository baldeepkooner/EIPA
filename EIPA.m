%Baldeep Kooner 101004107
%ELEC 4700 PA-5: Harmonic Wave Equation in 2D FD and Modes
clear all
close all

nx = 50;
ny = 50;
G = sparse(nx*ny, nx*ny);
delta = 1;
nxm = 0;
nxp = 0;
nym = 0;
nyp = 0;
% Set Boundary Conditions
%{
for m = 1:(nx*ny)
    G(m, :) = 0;
    G(m, m) = 1;
end
%}
% Set Boundary Conditions + Bulk nodes using FD model
for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        nxm = j + (i - 2) * ny;
        nxp = j + (i) * ny;
        nym = (j - 1) + (i - 1) * ny;
        nyp = (j + 1) + (i - 1) * ny;
        if i == 1
            G(n, :) = 0;
            G(n, n) = 1;
        elseif i == nx
            G(n, :) = 0;
            G(n, n) = 1;
        elseif j == ny
            G(n, :) = 0;
            G(n, n) = 1;
        %{
        elseif i > 10 && i < 20 && j > 10 && j < 20
            G(n, n) = -2;
            G(n, nxm) = 1;
            G(n, nxp) = 1;
            G(n, nym) = 1;
            G(n, nyp) = 1;
        %}
        else
            G(n, n) = -4;
            G(n, nxm) = 1;
            G(n, nxp) = 1;
            G(n, nym) = 1; 
            G(n, nyp) = 1;
        end
    end
end

%g1 = G(1:25, 1:50);
%g2 = G(26:50, 1:50);
[E, D] = eigs(G, 9, 'SM');
%{    
figure(1)
spy(G)
title('Sparsity Pattern of G Matrix')
xlabel('nx')
ylabel('ny')
grid on
%}
%{
subplot(2, 2, 2)
plot(1:9, diag(D).')
title('Eigenvalues')
grid on
%}
eigenVectors = zeros(nx, ny);
%Vector remapping to plot eigenvectors
for k = 1:9
    for i = 1:nx
        for j = 1:ny
            n = j + (i - 1) * ny;
            eigenVectors(i, j) = E(n, k);
        end
    end
    figure(2)
    subplot(3, 3, k); 
    surf(eigenVectors);
    grid on
    colormap(parula)
end





