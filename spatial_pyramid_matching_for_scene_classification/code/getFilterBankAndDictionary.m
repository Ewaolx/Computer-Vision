function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.
    %t=ones(300,60);
    t1=0;
    c=1;
    filterBank  = createFilterBank();
    dictionary=0;
    disp(length(imPaths));
    for i=1:length(imPaths);
        o=imread(imPaths{i});
        [a b cc]=size(o);
        if (cc==1)
           o=cat(3,o,o,o); 
        end    
        t=extractFilterResponses(o,filterBank);
        [x]=size(t);
        %disp(x);
        t=reshape(t,x(1,1)*x(1,2),60);
        [x]=size(t);
        a=150;
        p=randperm(x(1,1),a);
        %disp(p);
        % figure();
        % imshow(t);
        co=1;
       for  j=c:c+149
           for jj=1:60
            t1(j,jj)=t(p(1,co),jj);
           end
         co=co+1;
       end
       [l]=size(t1);
       c=l(1,1)+1;
       disp(size(t1));
    end
    
    %disp(t1);
    K=200;
    [ ~, dictionary] = kmeans(t1, K, 'EmptyAction','drop');  
         
         dictionary=(dictionary)';
         %disp(size(dictionary));
        %disp(dictionary);                  
      
    % TODO Implement your code here

end
