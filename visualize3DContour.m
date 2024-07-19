function [patchHandles, scatterHandle] = visualize3DContour(X, Y, Z, C,...
    xRange, yRange, zRange, cRange, densityLevels, axisLabels)
    % Create 3D grid
    [xGrid, yGrid, zGrid] = meshgrid(xRange, yRange, zRange);

    % Initialize density matrix
    densityMatrix = zeros(size(xGrid));

    % Discretize data points into the specified ranges
    xBins = discretize(X, xRange);
    yBins = discretize(Y, yRange);
    zBins = discretize(Z, zRange);

    % Iterate over data points to populate densityMatrix
    for i = 1:length(X)
        if ~isnan(xBins(i)) && ~isnan(yBins(i)) && ~isnan(zBins(i))
            densityMatrix(yBins(i), xBins(i), zBins(i)) = densityMatrix(yBins(i), xBins(i), zBins(i)) + 1;
        end
    end

    % Visualization setup
    figure('position',[3062.6 146.6 1102.4 858]);
    hold on;
    axis equal;
    colormap jet; % Set colormap
    hColorbar = colorbar; % Show color scale

    % Define colors for each density level as grey through black
    colorThresholder = linspace(0.1, 1, length(densityLevels) + 1);
    colors = zeros(length(densityLevels), 3);
    for i = 1:length(densityLevels)
        colors(i, :) = colorThresholder(i) * [1, 1, 1];
    end

    % Initialize array to store patch handles
    patchHandles = gobjects(length(densityLevels), 1);

    % Plot isosurfaces for each density level
    for i = 1:length(densityLevels)
        % Extract isosurface at the specified density level
        isoValue = densityLevels(i);
        [faces, verts] = isosurface(xGrid, yGrid, zGrid, densityMatrix, isoValue);
        % Plot the isosurface and use the colors defined earlier
        patchHandles(i) = patch('Vertices', verts, 'Faces', faces, 'FaceColor', colors(i, :),...
            'FaceAlpha', 0.05, 'EdgeColor', 'none');
    end

    % Customize the plot
    if length(axisLabels) == 3
        xlabel(axisLabels(1));
        ylabel(axisLabels(2));
        zlabel(axisLabels(3));
    
    elseif length(axisLabels) == 4
        xlabel(axisLabels(1));
        ylabel(axisLabels(2));
        zlabel(axisLabels(3));
        ylabel(hColorbar, axisLabels(4));
    else
        disp('Warning: Axis labels array does not contain exactly 3 elements. Default labels will be used.');
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Z-axis');
    end
    
    % Scatter plot of data points and set axis limits
    scatterHandle = scatter3(X, Y, Z, 4, C, 'filled','MarkerFaceAlpha',0.1);
    xlim([min(xRange), max(xRange)]);ylim([min(yRange), max(yRange)]);zlim([min(zRange), max(zRange)]);
    clim([min(cRange), max(cRange)]);
    grid on;
    view(3);
end
