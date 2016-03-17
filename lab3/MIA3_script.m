% MIA Lab 3
% Daudt
%  17/03/16

clear all
close all
clc

%% Segmentation evaluation in 2D

display('Part 2');

%% Load images

image_names = cell(1,4);
image_names{1} = 'rdb005ll.tif';
image_names{2} = 'rdb023ll.tif';
image_names{3} = 'rdb025ll.tif';
image_names{4} = 'rdb028rl.tif';

dirs = dir('examples/alg*');
seg_images = cell(size(dirs,1),4);
for i = 1:size(dirs,1)
    for j = 1:4
        cur_path = strcat('examples/',dirs(i).name,'/',image_names{j});
        seg_images{i,j} = im2double(imread(cur_path));
    end
end

ori_images = cell(1,4);
man_images = cell(1,4);
for j = 1:4
    ori_images{j} = im2double(imread(strcat('examples/images/',image_names{j})));
    man_images{j} = im2double(imread(strcat('examples/manual/',image_names{j})));
end

display('Loaded images');

%% ROC

manual = [];
for i = 1:4
    manual = [manual man_images{i}(:)'];
end

for i = 1:6
    images_vec = [];
    for j = 1:4
        images_vec = [images_vec seg_images{i,j}(:)'];
    end
    [tpr,fpr,thresholds] = roc(manual,images_vec);
    figure;
    plot(fpr,tpr);
    axis([0 1 0 1]);
    hold on;
    plot([0 1],[0 1]);
end

















