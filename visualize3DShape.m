function visualize3DShape(X, Y, Z, C, xRange, yRange, zRange, cRange, axisLabels)
    % Combine into a single matrix for processing
    V = [X, Y, Z]; % Not used directly in visualization, but useful if extended

    % Create 3D grid
    [xGrid, yGrid, zGrid] = meshgrid(xRange, yRange, zRange);

    % Initialize matrices for counts and color sums
    countMatrix = zeros(size(xGrid));
    colorSumMatrix = zeros(size(xGrid));

    % Iterate over data points to populate countMatrix and colorSumMatrix
    for i = 1:length(X)
        % Find the closest grid cube for the current point
        [~, xIndex] = min(abs(xRange - X(i)));
        [~, yIndex] = min(abs(yRange - Y(i)));
        [~, zIndex] = min(abs(zRange - Z(i)));
        
        % Increment count and add color value
        countMatrix(yIndex, xIndex, zIndex) = countMatrix(yIndex, xIndex, zIndex) + 1;
        colorSumMatrix(yIndex, xIndex, zIndex) = colorSumMatrix(yIndex, xIndex, zIndex) + C(i);
    end

    % Calculate average color
    averageColorMatrix = colorSumMatrix ./ countMatrix;
    averageColorMatrix(isnan(averageColorMatrix)) = 0; % Handle division by zero

    % Visualization setup
    figure;
    hold on;
    axis equal;
    currentColormap = colormap(jet); % Set colormap
    hColorbar = colorbar; % Show color scale

    disp('Starting visualization process...');

    % Calculate total cubes for progress indication
    totalCubes = (length(xRange)-1) * (length(yRange)-1) * (length(zRange)-1);
    processedCubes = 0;
    
    for xIndex = 1:length(xRange)-1
        for yIndex = 1:length(yRange)-1
            for zIndex = 1:length(zRange)-1
                if countMatrix(yIndex, xIndex, zIndex) > 0
                    % Assuming xCenter, yCenter, zCenter represent the center of the cube
                    % and s is the side length of the cube
                    h = s / 2; % Half side length for convenience
        
                    % Define the 8 vertices of the cube
                    cubeVertices = [xCenter-h, yCenter-h, zCenter-h; % Vertex 1
                                    xCenter+h, yCenter-h, zCenter-h; % Vertex 2
                                    xCenter+h, yCenter+h, zCenter-h; % Vertex 3
                                    xCenter-h, yCenter+h, zCenter-h; % Vertex 4
                                    xCenter-h, yCenter-h, zCenter+h; % Vertex 5
                                    xCenter+h, yCenter-h, zCenter+h; % Vertex 6
                                    xCenter+h, yCenter+h, zCenter+h; % Vertex 7
                                    xCenter-h, yCenter+h, zCenter+h];% Vertex 8
        
                    % Calculate alpha based on count
                    alphaValue = min(1, countMatrix(yIndex, xIndex, zIndex) / max(countMatrix(:)));
        
                    % Get average color for the cube - map to colormap using cRange
                    colorValue = averageColorMatrix(yIndex, xIndex, zIndex);
                    colorIndex = round(1 + (size(colormap,1)-1) * (colorValue - cRange(1)) / (cRange(2) - cRange(1)));
                    cubeColor = currentColormap(colorIndex, :);
        
                    % Define cube vertices and faces, then draw cube using patch
                    patch('Vertices', cubeVertices, 'Faces', cubeFaces, 'FaceColor', cubeColor, 'FaceAlpha', alphaValue, 'EdgeAlpha', 0);
                end
                processedCubes = processedCubes + 1;
                if mod(processedCubes, 1000) == 0
                    fprintf('Processed %d out of %d cubes...\n', processedCubes, totalCubes);
                end
            end
        end
    end
    
    disp('Visualization complete.');
    
    % Set axis labels from the provided string array
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
    
    title('3D Shape Visualization with Variable Alpha and Color');
    view(3); % Adjust view for better 3D visualization
    grid on;
    hold off;
end