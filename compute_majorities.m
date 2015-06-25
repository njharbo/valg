%cd 'C:\Users\nharb\Dropbox\Dokumenter\Blog\val'

clear all

numberparties=9;
koalizationsize=7;
border=89.5;

koalitions=nchoosek([1:1:numberparties], koalizationsize);
koalitionsvektor=zeros(length(koalitions),length(koalitions(1,:)));

S
DF
V
EHL
I
?
B
SF
C


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


for i=1:length(koalitions)
    for k=1:length(koalitions(1,:))
    koalitionsvektor(i, koalitions(i, k))=1;
    end
end
    
summandater=[(1:1:length(koalitions))', koalitionsvektor*mandater];

maj=summandater(summandater(:,2)>border);

nj=koalitionsvektor*mandater;

start=[koalitionsvektor(summandater(summandater(:,2)>border),:), nj(summandater(summandater(:,2)>border),:)]

%check if we can remove one party and still have majority



perm=perms([1:numberparties]);

for n=1:length(perm(:,1))
    hej=start;
for k=1:5
for i=1:length(hej(:,1))
    for j=1:(length(hej(1,:))-1)
        if hej(i,perm(n,j))==1
        if hej(i,length(hej(i,:)))-mandater(perm(n,j))>border
            hej(i,perm(n,j))=0;
            hej(i,length(hej(1,:)))=hej(i,length(hej(1,:)))-mandater(perm(n,j));
        end
        end
    end
end
end
hans(:,:,n)=transpose(hej);
n
end

john=transpose(reshape(hans, length(hans(:,1,1)),length(hans(1,:,1))*length(hans(1,1,:))));

data=unique(john, 'rows')

save data_dk.mat

xlswrite('ft.xls', save, 'flertal', 'B2')
