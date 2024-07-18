% Assuming IMPelems.Al, IMPelems.Fe, IMPelems.Ti, and IMPelems.Ca are your data vectors

% User-specified shrink factor
shrinkFactor = .5; % Adjust this value to change the tightness of the boundary around the data points

% Step 1: Prepare data for surface calculation
X = log10(IMPelems.Al./IMPelems.Si);
Y = log10(IMPelems.Fe./IMPelems.Si);
Z = log10(IMPelems.Ti./IMPelems.Si);
Ca_Si_Ratio = log10(IMPelems.Ca./IMPelems.Si); % For coloring
V = [X, Y, Z]; % Combine into a single matrix

% Filter out rows with any NaN values in V and corresponding Ca/Si ratio
validIdx = ~any(isnan(V), 2) & ~isnan(Ca_Si_Ratio);
V_filtered = V(validIdx, :);
Ca_Si_Ratio_filtered = Ca_Si_Ratio(validIdx);

% Step 2: Calculate the boundary
[B, ~] = boundary(V_filtered(:,1), V_filtered(:,2), V_filtered(:,3), shrinkFactor);

% Step 3: Calculate mean color for each vertex in the boundary more efficiently
% Utilize knnsearch for finding nearest neighbors
numVertices = size(V_filtered, 1);
meanColors = zeros(numVertices, 1);
k = 5; % Number of nearest neighbors

% Create a KD-tree for nearest neighbor search
Mdl = createns(V_filtered, 'NSMethod','kdtree');

fprintf('Calculating mean colors for each vertex...\n');
for i = 1:numVertices
    % Find the k-nearest neighbors, including the point itself
    [nearestIdxTemp, ~] = knnsearch(Mdl, V_filtered(i,:), 'K', k+1); % Request one more neighbor to ensure we have k neighbors after excluding the point itself
    
    % Exclude the point itself from the nearest neighbors
    nearestIdx = nearestIdxTemp(nearestIdxTemp ~= i); % Corrected line
    
    % Calculate the mean color
    meanColors(i) = mean(Ca_Si_Ratio_filtered(nearestIdx));
    
    % Progress update
    if mod(i, 100) == 0
        fprintf('Processed %d of %d vertices\n', i, numVertices);
    end
end
fprintf('Mean color calculation completed.\n');

% Step 4: Plot the boundary as a 3D shape with colored faces
figure; % Create a new figure for the 3D shape
trisurf(B, V_filtered(:,1), V_filtered(:,2), V_filtered(:,3), meanColors, 'FaceAlpha', 0.5);
hold on;

% Overlay the original scatter plot
scatter3(X(validIdx), Y(validIdx), Z(validIdx), 2, Ca_Si_Ratio(validIdx), 'filled');
hold off;

% Adjustments
xlabel('log_{10}(Al/Si)');
ylabel('log_{10}(Fe/Si)');
zlabel('log_{10}(Ti/Si)');
title('Dynamic 3D Surface with Color Mean of Nearby Scatter Points');
colormap(jet); % Apply colormap
colorbar; % Add a colorbar

clear X Y Z V V_filtered validIdx B meanColors Ca_Si_Ratio Ca_Si_Ratio_filtered; % Clean up variables