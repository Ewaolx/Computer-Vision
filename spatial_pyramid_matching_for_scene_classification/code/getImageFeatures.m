function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
    h=0;
 	[x]=size(wordMap);
     wordMap=reshape(wordMap,x(1,1)*x(1,2),1);
       tb=tabulate(wordMap);
       h=(tb(:,3))./100;
       
       %disp(sum(h));
       s=size(h);
       for i=s+1:dictionarySize
           h(i,1)=0;
       end
       
	assert(numel(h) == dictionarySize);
    
end