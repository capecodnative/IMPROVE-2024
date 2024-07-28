%This script tests whether double conversion of the categoricals in IMP.SiteCode matches the double conversion in Sites.Code
%Sites.Code has one row for every site. IMP.SiteCode has many rows for each site.

for i=1:height(Sites)
    %Find the rows in IMP that match the current site
    siteRows=IMP.SiteCode==Sites.Code(i);
    %Convert the site code to double
    siteCodeDouble=double(Sites.Code(i));
    %Convert the site code to double for the rows in IMP that match the current site
    siteCodeDoubleRows=double(IMP.SiteCode(siteRows));
    %Check that the site code is the same for all rows in IMP that match the current site
    assert(all(siteCodeDoubleRows==siteCodeDouble), 'Site code double conversion failed');
end

clear i siteCodeDouble siteCodeDoubleRows siteRows
disp('Site code double conversion test passed');