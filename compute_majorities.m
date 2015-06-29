%cd 'C:\Users\nharb\Dropbox\Dokumenter\Blog\val'

clear all

numberparties=9;
koalizationsize=7;
border=89.5;

%S
%DF
%V
%EHL
%I
%?
%B
%SF
%C

mandater=[47
37
34
14
13
9
8
7
6
]

%Forms all possible coalitions
koalitions=nchoosek([1:1:numberparties], koalizationsize);
koalitionsvektor=zeros(length(koalitions),length(koalitions(1,:)));
for i=1:length(koalitions)
    for k=1:length(koalitions(1,:))
    koalitionsvektor(i, koalitions(i, k))=1;
    end
end

%Number of seats in each koalition
summandater=[(1:1:length(koalitions))', koalitionsvektor*mandater];
temp=koalitionsvektor*mandater;
%maj=summandater(summandater(:,2)>border);

%Matrix with coalition and number of seats in each, if the coalition is
%large enough
start=[koalitionsvektor(summandater(summandater(:,2)>border),:), temp(summandater(summandater(:,2)>border),:)]

% For each of other found coaltions check if we can remove one or more
% parti and still have majority
% Conduct this check in all possible orders of parties
check if we can remove one party and still have majority
perm=perms([1:numberparties]);
for n=1:length(perm(:,1))
    temp2=start;
for k=1:koalizationsize
for i=1:length(temp2(:,1))
    for j=1:(length(temp2(1,:))-1)
        if temp2(i,perm(n,j))==1
            if temp2(i,length(temp2(i,:)))-mandater(perm(n,j))>border
                temp2(i,perm(n,j))=0;
                temp2(i,length(temp2(1,:)))=temp2(i,length(temp2(1,:)))-mandater(perm(n,j));
            end
        end
    end
end
end
cleaned_coaltion(:,:,n)=transpose(temp2);
n
end

%Put found coaltions on right form
%And clean for duplets
temp3=transpose(reshape(cleaned_coaltion, length(cleaned_coaltion(:,1,1)),length(cleaned_coaltion(1,:,1))*length(cleaned_coaltion(1,1,:))));
data=unique(temp3, 'rows')

save data_dk_na.mat

xlswrite('ft_na.xls', data, 'flertal', 'B2')
