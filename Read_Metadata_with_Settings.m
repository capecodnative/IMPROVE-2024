% Define the paths for the data files and the settings file
parametersFilePath = './ExtractedData/Parameters.csv';
sitesFilePath = './ExtractedData/Sites.csv';
statusFilePath = './ExtractedData/Status_Flags.csv';
parametersSettingsPath = './Settings/ParametersSettings.csv';
sitesSettingsPath = './Settings/SitesSettings.csv';
statusSettingsPath = './Settings/Status_Flags.csv';

% Import Parameters and Sites with settings and store the returned tables
Parameters = importTableWithSettings(parametersFilePath, parametersSettingsPath,'TreatAsMissing', '-999');
Sites = importTableWithSettings(sitesFilePath, sitesSettingsPath,'TreatAsMissing', '-999');
StatusFlags = importTableWithSettings(statusFilePath, statusSettingsPath,'TreatAsMissing', '-999');

clear parametersFilePath sitesFilePath parametersSettingsPath sitesSettingsPath statusFilePath statusSettingsPath