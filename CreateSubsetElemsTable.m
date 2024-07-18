function subsetTable = CreateSubsetElemsTable(originalTable, filename)
	% Open and read the variable names from the specified file
	fileID = fopen(filename, 'r');
	variableList = textscan(fileID, '%s');
	fclose(fileID);
	variableList = variableList{1}; % Extract the cell array from the cell array wrapper

	% Check which variables in variableList are in the original table
	validVariables = ismember(variableList, originalTable.Properties.VariableNames);

	% Create the subset table with only the valid variables
	subsetTable = originalTable(:, variableList(validVariables));
end