%M = importdata('total_cases.csv');
%disp(M); %para imprimir valores num
%disp(M.data); %numerico+
%totalcases(isnan(totalcases))=0;
%disp(totalcases.Argentina);
%totalcases.Properties.RowNames = totalcases.date;
%totalcases.date = [];

tott=rows2vars(totalcases1); %transpuesta de totalcases
%tott.Properties.RowNames = tott.date;
%tott.date = [];
tott([1,2,12,133],:) = [];
size(tott);
%tsort=sort(totalcases);
[~,maxidx] = max(tott);
tott(maxidx,:)

%tott_sorted=tott(
%B = sortrows(tott,Var467);
%tott(isnan(tott)) = 0;
%B = sortrows(totalcases,468);
%z1 = rand(2601,1);
%int_z1 = int8(z1);
%cell2mat(struct2cell(M.data))
%B = sortrows(M,468);