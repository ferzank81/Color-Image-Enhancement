% %08.01.2020
% All rights reserved.
% This work should only be used for nonprofit purposes.
% Please cite the paper when you use this code:
% Katýrcýoðlu, F. (2020). Colour image enhancement with brightness preservation and edge sharpening using a heat conduction matrix. 
% IET Image Processing, Volume 14 Issue 13, pp 3202-3214.% 
%DOI:  10.1049/iet-ipr.2020.0393

%
% AUTHOR:
%     Ferzan Katýrcýoðlu,Duzce University, TURKEY.
%     email:katirciogluferzan@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; 
clear all; 
close all;


% [dirnames, pathname, filterindex] = uigetfile2( ...
% {  '*'}, ...
%    'Pick a file', ...
%    'MultiSelect', 'on');
% 
% 
%      filename = dirnames;
%      img = imread(fullfile(pathname,filename));
img=imread('test2.png');
figure, imshow(img);
%%%10. METHODS---------PROPOSED-------
enh=CEHCM(img);
figure, imshow(enh);



