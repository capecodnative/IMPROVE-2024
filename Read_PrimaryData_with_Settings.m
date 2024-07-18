% Define the paths for the data files and the settings file
PrimaryFilepath = './SourceData/AllSites_AllData_1988to2023.txt';
PrimarySettingsPath = './Settings/PrimaryData.csv';
FilterReportPath = './Settings/PrimaryDataImportReport.txt';

% Import Parameters and Sites with settings and store the returned tables
IMP = importTableWithSettings(PrimaryFilepath, PrimarySettingsPath,'TreatAsMissing', '-999');
IMP = filterTableBasedOnSettings(IMP,PrimarySettingsPath,FilterReportPath);

clear PrimarySettingsPath PrimaryFilepath ElemsSubsetPath FilterReportPath