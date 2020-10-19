function [ A ]...Complete probability matrix
    = synthetic_probability( n,...Number objects
                             w,...True score
                             k)...Number of instances of a pairwise comparison
                             
%Synthetic probability Summary of this function goes here
%   Detailed explanation goes here
pdenominator=repmat(w,1,n)+repmat(w',n,1); %rep
p=repmat(w,1,n)./pdenominator;
p=p';
a=random('Binomial',k,triu(p))/k;
a=(triu(ones(n))-a)'+a;%upper triangular matrix of a

asum=a+a';
A=a./asum;
A(isnan(A))=0;
A=A-diag(diag(A)); % setting diagonal elements of A to zero
end

