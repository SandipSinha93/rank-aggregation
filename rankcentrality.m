function [ wstar, ...Proposed score
           sigma] ...Proposed Ranking
           = rankcentrality( n, ...Number of objects
                             d, ...Probability of a edge being present
                             A) ...Complete probability matrix 
                             
%Rank Centrality Summary of this function goes here
%   Detailed explanation goes here

%Generate a P transition matrix
    
Asparse=random('Binomial',1,d,n,n).*A;
d_row=sum(Asparse~=0,2);
dmax=max(d_row);

%opts.tol=1e-3; % trying this to reduce accuracy

P1=Asparse/dmax; % As per the rank centrality algorithm given in the paper 
P1(isnan(P1))=0;
P1=P1+eye(n)-diag(sum(P1,2));
%disp(sum(P1,2));
%find left eigenvector
[wstar(:,1),~]= eigs(P1',1);%,'lr',opts); %trying with less accuracy

P2=bsxfun(@rdivide,Asparse,d_row); % Using MC3 as given in the paper
P2(isnan(P2))=0;
P2=P2+eye(n)-diag(sum(P2,2));
[wstar(:,2),~]= eigs(P2',1);

a_row=sum(Asparse,2);
P3=Asparse/max(a_row); % Using SSP1
P3(isnan(P3))=0;
P3=P3+eye(n)-diag(sum(P3,2));
[wstar(:,3),~]= eigs(P3',1);

P4=bsxfun(@rdivide,Asparse,a_row); % Using MC2
P4(isnan(P4))=0;
%P4=P4+eye(n)-diag(sum(P4,2));
[wstar(:,4),~]= eigs(P4',1);
wstar=wstar./repmat(sum(wstar,1),n,1); %Normalizing wstar
[~, sigma]=sort(wstar);

end


