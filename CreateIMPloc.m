Sites.Properties.VariableNames(2) = "SiteCode";
IMPloc = innerjoin(IMP(:, 'SiteCode'), Sites(:, {'SiteCode', 'Latitude', 'Longitude', 'Elevation'}), 'Keys', 'SiteCode');
Sites.Properties.VariableNames(2) = "Code";