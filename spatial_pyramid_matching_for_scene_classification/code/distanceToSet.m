function histInter = distanceToSet(wordHist, histograms)
% Compute distance between a histogram of visual words with all training image histograms.
% Inputs:
% 	wordHist: visual word histogram - K * (4^(L+1) − 1 / 3) × 1 vector
% 	histograms: matrix containing T features from T training images - K * (4^(L+1) − 1 / 3) × T matrix
% Output:
% 	histInter: histogram intersection similarity between wordHist and each training sample as a 1 × T vector

	% TODO Implement your code here
    histInter=0;
    [x]=size(histograms);

	for i=1:x(1,2)
        r=bsxfun(@min,wordHist(:,1),histograms(:,i));
       % disp(size(r));
        t(1,i)=sum(r);
       % disp(t(1,i));
    end    

        disp(t);
        histInter=t;
end