% Define the paths for the data files and the settings file
PrimaryFilepath = './SourceData/GEOTRACES_IDP2021_Aerosol_Data_v2.csv';
PrimarySettingsPath = './Settings/GEOTRACES_IDP2021_Aerosol_Data_v2_settings.csv';
FilterReportPath = './Settings/GEOTRACES_IDP2021_Aerosol_Data_v2_report.txt';

% Import Parameters and Sites with settings and store the returned tables
GTAer = importTableWithSettings(PrimaryFilepath, PrimarySettingsPath,'TreatAsMissing', '-999');
GTAer = filterTableBasedOnSettings(GTAer,PrimarySettingsPath,FilterReportPath);

clear PrimarySettingsPath PrimaryFilepath ElemsSubsetPath FilterReportPath