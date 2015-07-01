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

%Form all possible coalitions on binary form
n=1
for counter1=0:1:1
    for counter2=0:1:1
        for counter3=0:1:1
            for counter4=0:1:1
                for counter5=0:1:1
                    for counter6=0:1:1
                        for counter7=0:1:1
                            for counter8=0:1:1
                                for counter9=0:1:1
                                    for counter10=0:1:1
                                        koalitions(n,:)=[counter1 counter2 counter3 counter4 counter5 counter6 counter7 counter8 counter9 counter10];
                                        n=n+1;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
    
koalitions=koalitions(:,1:numberparties)
koalitions=unique(koalitions,'rows')


%Add seats to each coalition
koalitions(:,numberparties+1)=koalitions*mandater

%Remove coalitions with insufficient seats
koalitions=koalitions(koalitions(:,numberparties+1)>=border,:)

%Check if smallest party can be removed and still have a majority
%if so, remove coalition
for i=1:length(koalitions(:,1))
temp=transpose(koalitions(i,1:numberparties)).*mandater;
smallest=min(temp(temp>0));
koalitions(i,numberparties+2)=koalitions(i,numberparties+1)-smallest;
end
koalitions=koalitions(koalitions(:,numberparties+2)<border,:)

koalitions=koalitions(:,1:numberparties+1);

xlswrite('ft_na.xls', koalitions, 'flertal', 'B2')
