% Problem 1: Image Alignment


%% 1. Load images (all 3 channels)
load('../data/red.mat');
load('../data/green.mat');
load('../data/blue.mat');
figure();
X=cat(3,green,blue,red);
image(X);
%red = [];  % Red channel
%green = [];  % Green channel
%blue = [];  % Blue channel

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);
figure();
image(rgbResult);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
saveas(gcf,'../results/rgb_output.jpg');