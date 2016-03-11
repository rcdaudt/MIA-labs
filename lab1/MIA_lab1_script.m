% MIA lab 1

clear all
close all
clc

%% Open images and get information 2.1 and 2.2

% Ultrasound
us = dicomread('ultrasound.DCM');
us_info = dicominfo('ultrasound.DCM');
us_rows = us_info.Rows
us_cols = us_info.Columns
us_name = us_info.PatientName.FamilyName

% Mammography raw
mmg_raw = dicomread('MAMMOGRAPHY_RAW.dcm');
mmg_raw_info = dicominfo('MAMMOGRAPHY_RAW.dcm');
mmg_raw_rows = mmg_raw_info.Height
mmg_raw_cols = mmg_raw_info.Width
mmg_raw_spacing = mmg_raw_info.ImagerPixelSpacing
mmg_raw_name = mmg_raw_info.PatientName.FamilyName

% Mammography presentation
mmg_pre = dicomread('MAMMOGRAPHY_PRESENTATION.dcm');
mmg_pre_info = dicominfo('MAMMOGRAPHY_PRESENTATION.dcm');
mmg_pre_rows = mmg_pre_info.Height
mmg_pre_cols = mmg_pre_info.Width
mmg_pre_spacing = mmg_pre_info.ImagerPixelSpacing
mmg_pre_name = mmg_pre_info.PatientName.FamilyName

% MRI
for i = 1:22
    name = ['MRI/MRI',num2str(i,'%.2u'),'.dcm'];
    mri(:,:,i) = dicomread(name);
end
mri_info = dicominfo(name);
mri_rows = mri_info.Height
mri_cols = mri_info.Width
mri_spacing_xy = mri_info.PixelSpacing
mri_spacing_z = mri_info.SpacingBetweenSlices


%% MRI histogram - 2.3

% histogram(mri);
clear hist;
clear hist_centers;
[hist,hist_centers] = hist(double(mri(:)),256);
plot(hist_centers,hist);

%% MRI slices - 2.4

figure;
imshow(mri(:,:,11),[]);

figure;
imshow(mri(:,:,12),[]);


ratio = mri_spacing_z/mri_spacing_xy(1);

figure;
I = permute(mri(:,255,:),[1 3 2]);
s = size(I);
new_s = [s(1) round(ratio*s(2))];
I_r = imresize(I,new_s);
imshow(I_r,[]);

figure;
I = permute(mri(:,256,:),[1 3 2]);
s = size(I);
new_s = [s(1) round(ratio*s(2))];
I_r = imresize(I,new_s);
imshow(I_r,[]);


figure;
I = permute(mri(255,:,:),[3 2 1]);
s = size(I);
new_s = [round(ratio*s(1)) s(2)];
I_r = imresize(I,new_s);
imshow(I_r,[]);

figure;
I = permute(mri(256,:,:),[3 2 1]);
s = size(I);
new_s = [round(ratio*s(1)) s(2)];
I_r = imresize(I,new_s);
imshow(I_r,[]);

%% Visualising mammography

figure;
imshow(mmg_raw,[]);
figure;
imshow(mmg_pre,[]);

%% Processing mammograpy

T = 2000;
mmg_cut = double(max(0,T - mmg_raw))/T;
mmg_pow = mmg_cut.^(5);
mmg_sh = imsharpen(mmg_pow);
mmg_eq = adapthisteq(mmg_sh);
imshow(mmg_eq,[]);



























