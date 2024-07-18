% Assuming IMPelems.Al, IMPelems.Fe, IMPelems.Ti, and IMPelems.Ca are your data vectors

% Step 1: Prepare data for convex hull calculation
X = log10(IMPelems.Al./IMPelems.Si);
Y = log10(IMPelems.Fe./IMPelems.Si);
Z = log10(IMPelems.Ti./IMPelems.Si);
V = [X, Y, Z]; % Combine into a single matrix

% Step 2: Calculate the convex hull
[K, V] = convhull(V, 'SimplifyVertex', true); % Adjust 'SimplifyVertex' as needed

% Step 3: Plot the convex hull as a 3D shape
figure; % Create a new figure for the 3D shape
trisurf(K, V(:,1), V(:,2), V(:,3), 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
hold on;
scatter3(X, Y, Z, 2, log10(IMPelems.Ca./IMPelems.Si), 'filled'); % Overlay the original scatter plot
hold off;

% Adjustments
xlabel('log_{10}(Al/Si)');
ylabel('log_{10}(Fe/Si)');
zlabel('log_{10}(Ti/Si)');
title('3D Shape with Scatter Plot Data');
colormap(jet); % Apply colormap
colorbar; % Add a colorbar