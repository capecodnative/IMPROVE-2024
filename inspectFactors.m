%FactLoading=nan(height(IMP),5); %Create factor loadings for import from JMP, or create in matlab

% Create a logical variable for when each factor is uniquely high (>2) 
% while the others are low (<2)
tcFact = false(height(FactLoading), 5); % Preallocate tcFact
for i=1:5
    tcFact(:,i)=FactLoading(:,i)>=2 & all(FactLoading(:,[1:i-1 i+1:5])<2,2);
end

% Report the top 20 sites for each factor determined by counting how many exclusively high samples are in each
% The site for each row is in IMP.SiteCodeStr (same height as FactLoading)
% Unique site names are in Sites.Site (one row for each site). Site codes to match IMP with Sites are in Sites.Code

%Create a single table to store all 20 sites and counts for each factor
topSites=table('Size',[20 10],'VariableTypes',{'string','double','string','double','string','double','string','double','string','double'},...
    'VariableNames',{'Factor1','Count1','Factor2','Count2','Factor3','Count3','Factor4','Count4','Factor5','Count5'});
for i=1:5
    % Count how many high samples there are for each site
    siteCounts=accumarray(double(IMP.SiteCode),tcFact(:,i),[],@sum);
    % Find the top 20 sites
    [topCounts,siteIdx]=sort(siteCounts,'descend');
    topCounts=topCounts(1:20);
    siteIdx=siteIdx(1:20);
    % Add the site names and counts to the table
    topSites{1:20,2*i-1}=Sites.Site(siteIdx);
    topSites{1:20,2*i}=topCounts;
end

% Show top 20 sites for each factor, pausing between each factor
for i=1:5
    disp(['Factor ' num2str(i)]);
    disp(topSites(:,2*i-1:2*i));
    if 1<4
        pause;
    end
end

% Clear all variables created except for topSites
clear tcFact siteCounts topCounts siteIdx i FactLoading