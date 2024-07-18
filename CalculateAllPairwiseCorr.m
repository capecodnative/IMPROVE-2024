function corrMatrix = CalculateAllPairwiseCorr(inputData)
    % Check if inputData is a table and convert to array if true
    if istable(inputData)
        inputData = table2array(inputData);
    end
    
    % Extract the number of variables (columns) in the input data
    numVariables = size(inputData, 2);
    
    % Initialize the correlation matrix
    corrMatrix = zeros(numVariables, numVariables);
    
    % Start timing the operation
    startTime = tic;
    lastUpdateTime = tic; % Initialize last update time
    combinationsChecked = 0; % Initialize the number of combinations checked
    
    % Calculate the total number of combinations
    totalCombinations = nchoosek(numVariables, 2);
    
    % Iterate over all pairs of variables
    for i = 1:numVariables
        for j = i+1:numVariables % Start from i+1 to avoid redundant calculations and self-comparison
            % Extract the data for the two variables
            data1 = inputData(:, i);
            data2 = inputData(:, j);
            
            % Calculate the correlation coefficient, ignoring NaN values
            [R, ~] = corrcoef(data1, data2, 'Rows', 'pairwise');
            
            % Store the correlation coefficient in the matrix
            corrMatrix(i, j) = R(1, 2);
            corrMatrix(j, i) = R(1, 2); % Symmetric entry
            
            % Update the number of combinations checked
            combinationsChecked = combinationsChecked + 1;
            
            % Check elapsed time and conditionally display progress
            elapsedTime = toc(startTime);
            if elapsedTime > 5 && (toc(lastUpdateTime) > 2)
                combinationsRemaining = totalCombinations - combinationsChecked;
                fprintf('\rCalculated %d combinations, %d remaining...    ', combinationsChecked, combinationsRemaining);
                lastUpdateTime = tic; % Update the last update time
            end
        end
    end