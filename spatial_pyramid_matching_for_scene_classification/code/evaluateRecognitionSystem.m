function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
    cellfind = @(string)(@(cell_contents)(strcmp(string,cell_contents)));
   for i=1:160
    t=test_imagenames(i);
    t=char(t);
    idy(i)=test_labels(i);
    g=guessImage(t);
    idx=cellfun(cellfind(g),mapping);
    idx=find(idx==1);
    idxx(i)=idx;
    disp(idx);
   end
   [C,order] = confusionmat(idy,idxx);
     accuracy=trace(C)/sum(C(:));
     %disp(C);
     %disp(accuracy);
     conf=C;
end