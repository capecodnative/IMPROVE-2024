% Use innerjoin to merge tables based on SiteCode
IMP.SiteCodeStr = cellstr(IMP.SiteCode);
IMPloc = innerjoin(IMP(:, {'SiteCodeStr', 'Date'}), Sites(:, {'Code', 'Latitude', 'Longitude', 'Elevation', 'Pop2020', 'LandArea'}),...
 'LeftKeys', 'SiteCodeStr', 'RightKeys', 'Code');
IMP.SiteCodeStr = [];