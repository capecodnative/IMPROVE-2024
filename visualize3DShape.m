function visualize3DShape(X, Y, Z, C, xRange, yRange, zRange, cRange, alphaCount, axisLabels)
    % Initialize matrices for counts and color sums
    countMatrix = zeros(length(yRange)-1, length(xRange)-1, length(zRange)-1);
    colorSumMatrix = zeros(length(yRange)-1, length(xRange)-1, length(zRange)-1);

    % Discretize data points into the specified ranges
    xBins = discretize(X, xRange);
    yBins = discretize(Y, yRange);
    zBins = discretize(Z, zRange);

    % Iterate over data points to populate countMatrix and colorSumMatrix
    for i = 1:length(X)
        if ~isnan(xBins(i)) && ~isnan(yBins(i)) && ~isnan(zBins(i))
            % Increment count and add color value
            countMatrix(yBins(i), xBins(i), zBins(i)) = countMatrix(yBins(i), xBins(i), zBins(i)) + 1;
            colorSumMatrix(yBins(i), xBins(i), zBins(i)) = colorSumMatrix(yBins(i), xBins(i), zBins(i)) + C(i);
        end
    end

    % Calculate average color
    averageColorMatrix = colorSumMatrix ./ countMatrix;
    averageColorMatrix(isnan(averageColorMatrix)) = 0; % Handle division by zero

    % Calculate alpha values based on count
    alphaValues = log1p(countMatrix) / log1p(max(countMatrix(:)));

    % Extract the values greater than the specified alphaCount
    highCountAlphaValues = alphaValues(countMatrix > alphaCount);

    % Rescale these values to the range [0.1, 1]
    rescaledHighCountAlphaValues = rescale(highCountAlphaValues, 0.05, .1);

    % Assign the rescaled values back to the alphaValues matrix
    alphaValues(countMatrix > alphaCount) = rescaledHighCountAlphaValues;

    % Set alpha to 0 for counts below the specified alphaCount
    alphaValues(countMatrix <= alphaCount) = 0;

    % Visualization setup
    figure;
    hold on;
    axis equal;
    currentColormap = colormap(jet); % Set colormap
    hColorbar = colorbar; % Show color scale

    % Set the limits for the color scale
    caxis(cRange);

    disp('Starting visualization process...');

    % Define the faces of the cube (only needs to be defined once)
    cubeFaces = [1, 2, 6, 5; % Face 1
                 2, 3, 7, 6; % Face 2
                 3, 4, 8, 7; % Face 3
                 4, 1, 5, 8; % Face 4
                 1, 2, 3, 4; % Bottom face
                 5, 6, 7, 8]; % Top face

    % Calculate total cubes for progress indication
    totalCubes = (length(xRange)-1) * (length(yRange)-1) * (length(zRange)-1);
    processedCubes = 0;
    timerStart = tic; % Initialize timer before the loop starts

    for xIndex = 1:length(xRange)-1
        for yIndex = 1:length(yRange)-1
            for zIndex = 1:length(zRange)-1
                if countMatrix(yIndex, xIndex, zIndex) >= alphaCount
                    % Calculate the edges of the current grid cell
                    xMin = xRange(xIndex);
                    xMax = xRange(xIndex + 1);
                    yMin = yRange(yIndex);
                    yMax = yRange(yIndex + 1);
                    zMin = zRange(zIndex);
                    zMax = zRange(zIndex + 1);
                    
                    % Define the 8 vertices of the cube
                    cubeVertices = [xMin, yMin, zMin; % Vertex 1
                                    xMax, yMin, zMin; % Vertex 2
                                    xMax, yMax, zMin; % Vertex 3
                                    xMin, yMax, zMin; % Vertex 4
                                    xMin, yMin, zMax; % Vertex 5
                                    xMax, yMin, zMax; % Vertex 6
                                    xMax, yMax, zMax; % Vertex 7
                                    xMin, yMax, zMax];% Vertex 8

                    % Get the alpha value for the current grid cell
                    alphaValue = alphaValues(yIndex, xIndex, zIndex);
        
                    % Get average color for the cube - map to colormap using cRange
                    colorValue = averageColorMatrix(yIndex, xIndex, zIndex);
                    colorIndex = round(1 + (size(currentColormap,1)-1) * (colorValue - cRange(1)) / (cRange(2) - cRange(1)));
                    colorIndex = max(1, min(colorIndex, size(currentColormap, 1))); % Ensure within colormap bounds
                    cubeColor = currentColormap(colorIndex, :);

                    % Draw the cube using patch with adjusted alpha
                    patch('Vertices', cubeVertices, 'Faces', cubeFaces, 'FaceColor', cubeColor, 'FaceAlpha', alphaValue, 'EdgeAlpha', 0);
                end
                processedCubes = processedCubes + 1;
                if toc(timerStart) >= 2
                    fprintf('Processed %d out of %d cubes...\n', processedCubes, totalCubes);
                    timerStart = tic; % Reset the timer
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
