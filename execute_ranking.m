%Execution of rankcentrality
clear all
real=0;     %Whether the data is real
m=5;        %Number of synthetic data sets
n=30;        %Number of objects for synthetic dataset
nk=7;       %Number of values of k
nd=16;      %Number of values of d
nfl=0;      %Whether data is from NFL
curr_folder = pwd;  %Current directory

if real
    dir_info=dir('P:/Current projects/Ranking problem/Dataset/Preflib/*.pwg');
    %dir_info=dir('P:/Current projects/Ranking problem/Dataset/NFL/*.mat');
    filename=cell(length(dir_info),1);
    nreal=length(dir_info); % Number of real datasets
    for i=1:nreal
        filename{i}=dir_info(i).name;
    end
    Error=ones(nreal,nd,4,3);
    %3 is the number of values from different error functions
            %4 =size(wstar,1) ... number of diff. approaches to get the
            %transition probability matrix
    for i=1:nreal
        if nfl
            dataset=load(filename{i});
            a=dataset.wins;
            asum=a+a';
            A=a./asum;
            A(isnan(A))=0;
            n=length(A);
        else
            [A,n]=real_probability(filename{i});
        end    
        [pathstr,fname,ext] = fileparts(filename{i});
        if(n>2)
            %disp(filename{i});
            %disp(i);
            w=rankcentrality(n,1,A); %Hopefully the true score in real data
            
            di=1;
            for d=linspace(0.1,1,nd);%logspace(-2,0,nd)
                [wstar, sigma]=rankcentrality(n,d,A); 
                for l=1:4 % Number of different rank aggregation models
                    Error(i,di,l,:)=err(n,w(:,l),wstar(:,l)); %w(:,l) is a column wstar(:,l) is a column
                end    
                di=di+1;
                %disp(di);
            end
        else
            disp('Less than 2');
        end
        figure
        plot(linspace(0.1,1,nd),...Array of values of d
            Error(i,... Number of the dataset
            :,... Array of values of d
            1,... Type of algorithm used (1=Rank centrality, 2=
            2),... Error type as given in the paper(1=As per paper, 2=Inner product)
            '-o');
        hold on
        plot(linspace(0.1,1,nd),...Array of values of d
            Error(i,... Number of the dataset
            :,... Array of values of d
            2,... Type of algorithm used (1=Rank centrality, 2=
            2),... Error type as given in the paper(1=As per paper, 2=Inner product)
            '-s');
        hold on
        plot(linspace(0.1,1,nd),...Array of values of d
            Error(i,... Number of the dataset
            :,... Array of values of d
            3,... Type of algorithm used (1=Rank centrality, 2=
            2),... Error type as given in the paper(1=As per paper, 2=Inner product)
            '-*');
        hold on
        plot(linspace(0.1,1,nd),...Array of values of d
            Error(i,... Number of the dataset
            :,... Array of values of d
            4,... Type of algorithm used (1=Rank centrality, 2=
            2),... Error type as given in the paper(1=As per paper, 2=Inner product)
            '-d');


        ylabel('D_L_1');
        xlabel ('d');
        legend(sprintf('Rank centrality n=%d',n),'MC3','SSP1','MC2');
        strprint=sprintf('-f%d',i);
        strtitle=sprintf('%s.png',fname);
        print(strprint,strtitle,'-dpng');
        movefile(strtitle,strcat(curr_folder,'\Figures\Preflib'));
        %movefile(strtitle,'P:/Current projects/Ranking problem/Figures/NFL');    
    end
else
    for i=1:m
        w=rand(n,1);
        w=w/sum(w);
        Error=ones(nk,nd,4,3); 
            %3 is the number of values from different error functions
            %4 =size(wstar,1) ... number of diff. approaches to get the
            %transition probability matrix
        ki=1;    
        for k=pow2(0:nk-1)
            A=synthetic_probability(n,w,k);

            di=1; %To provide index for Error
            
            for d = logspace(-2,0,nd)
                [wstar, sigma]=rankcentrality(n,d,A); 
                for l=1:4
                    Error(ki,di,l,:)=err(n,w,wstar(:,l));%wstar(:,l) is a column
                end    
                di=di+1;
            end
            ki=ki+1;
        end 
        %d dependence
        figure
        semilogx(logspace(-2,0,nd),...Array of values of d
            Error(end,... Max value of k
            :,... Array of values of d
            1,... Type of algorithm used (1=Rank centrality, 2=
            1),... Error type as given in the paper
            '-o',...
            logspace(-2,0,nd),...Array of values of d
            Error(end,... Max value of k
            :,... Array of values of d
            2,... Type of algorithm used (1=Rank centrality, 2=
            1),... Error type as given in the paper
            '-s',...
            logspace(-2,0,nd),...Array of values of d
            Error(end,... Max value of k
            :,... Array of values of d
            3,... Type of algorithm used (1=Rank centrality, 2=
            1),... Error type as given in the paper
            '-*',...
            logspace(-2,0,nd),...Array of values of d
            Error(end,... Max value of k
            :,... Array of values of d
            4,... Type of algorithm used (1=Rank centrality, 2=
            1),... Error type as given in the paper
            '-d');
        ylabel('D\omega');
        xlabel ('d');
        legend(sprintf('Rank centrality n=%d',n),'MC3','SSP1','MC2');
        strprint=sprintf('-f%d',2*i-1);
        strtitle=sprintf('Synthetic Trial%d-d-dependence.png',i);
        title(strtitle);
        print(strprint,strtitle,'-dpng');
        %curr_folder = pwd;
        movefile(strtitle,strcat(curr_folder,'\Figures\Synthetic'));
        %movefile(strtitle,'P:/Current projects/Ranking problem/Figures/Synthetic');
        %k dependence
        figure
        semilogx(pow2(0:nk-1),...Array of values of k
            Error(:,... Array of values of k
            end,... Max value of d
            1,... Type of algorithm used (1=Rank centrality, 2=
            1),... Error type as given in the paper
            '-o',...
            pow2(0:nk-1),...Array of values of k
            Error(:,... Array of values of k
            end,... Max value of d
            2,... Type of algorithm used (1=Rank centrality, 2=
            1),... Error type as given in the paper
            '-s',...
            pow2(0:nk-1),...Array of values of k
            Error(:,... Array of values of k
            end,... Max value of d
            3,... Type of algorithm used (1=Rank centrality, 2=
            1),... Error type as given in the paper
            '-*',...
            pow2(0:nk-1),...Array of values of k
            Error(:,... Array of values of k
            end,... Max value of d
            4,... Type of algorithm used (1=Rank centrality, 2=
            1),... Error type as given in the paper
            '-d');
        ylabel('D\omega');
        xlabel ('k');
        strprint=sprintf('-f%d',2*i);
        strtitle=sprintf('Synthetic Trial%d-k-dependence.png',i);
        title(strtitle);
        legend(sprintf('Rank centrality n=%d',n),'MC3','SSP1','MC2');
        print(strprint,strtitle,'-dpng');
        %movefile(strtitle,'P:/Current projects/Ranking problem/Figures/Synthetic');
        %curr_folder = pwd;
        movefile(strtitle,strcat(curr_folder,'\Figures\Synthetic'));
    end
end    