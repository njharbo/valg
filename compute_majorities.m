%Parameters
clear all

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

numberparties=length(mandater);
border=90;

%Form all possible coalitions
nj=zeros(1,numberparties)
n=1
nj(1:9,1)=nchoosek([1:1:numberparties], n)
for n=2:1:numberparties-1
dim1=length(nj(:,1))+1;
dim2=length(nchoosek([1:1:numberparties], n))+dim1-1;
nj(dim1:dim2,1:n)=nchoosek([1:1:numberparties], n)
end
%Put all coaltions on binary form
koalitionsvektor=zeros(length(nj),length(nj(1,:)));
for i=1:length(nj)
    for k=1:length(nj(1,:))
        if nj(i, k)>0
        koalitionsvektor(i, nj(i, k))=1;
        end
    end
end

%Add seats to each coalition
koalitionsvektor(:,10)=koalitionsvektor*mandater

%Remove coalitions with insufficient seats
koalitionsvektor=koalitionsvektor(koalitionsvektor(:,10)>=border,:)

%Check if smallest party can be removed and still have a majority
%if so, remove coalition
for i=1:length(koalitionsvektor(:,1))
temp=transpose(koalitionsvektor(i,1:9)).*mandater;
smallest=min(temp(temp>0));
koalitionsvektor(i,11)=koalitionsvektor(i,10)-smallest;
end
koalitionsvektor=koalitionsvektor(koalitionsvektor(:,11)<=border,:)

koalitionsvektor=koalitionsvektor(:,1:10);

xlswrite('ft_na.xls', koalitionsvektor, 'flertal', 'B2')
