function [ A, ...Complete probability matrix
           n] ... Number of objects
    = real_probability(raw_data_filename)...Filename of pairwise data from the source - http://www.preflib.org
                       
%Real Probability - Computes the probability matrix for real data sets
%taken from the mentioned source
%   Detailed explanation goes here
raw_data=importfile(raw_data_filename);
n=raw_data(1,1);
    
    pruned_data=raw_data(n+3:end,:);
    a=zeros(n);

    for i=1:length(pruned_data)
        a(pruned_data(i,3),pruned_data(i,2))=pruned_data(i,1);
    end
    asum=a+a';
    A=a./asum;
    A(isnan(A))=0;
    
end    

