function [enh] = CEHCM(img)
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
%1. STEP STRETCHING
Iout1=MyStretch(img);
% figure, imshow(Iout1);

%2. STEP RGB---HSI
HSI=rgb2hsi(Iout1); 
img1=HSI(:,:,3); 
% figure, imshow(img1);
ORT1=mean(img1(:));

% 3. STEP HEAT CONDUCTION MATRIX
%------------------------------------------------------------------------------------------

h=size(img1,1); 
w=size(img1,2); 


enh=zeros(h+2,w+2);
img1=uint8(img1.*255);
img1 = padarray(img1,[1 1]);
   for i=2: (h);
        for j=2: (w);
        
        maskR=zeros(1,9) ;
                
       
          for b=1:9;
          [x]=ikomsu(b,i);
          [y]=jkomsu(b,j);
         
                       col_R = img1(x,y,1);   maskR (b) =col_R;
                                               
          end
           
                  [newR]=isitrans_color(maskR);
                  
             
                   
enh(i,j)=newR;

     end
   end
   enh=uint8(enh);
% figure, imshow(enh);
%4. STEP HSI----RGB   
%%%%% FUNCTIONS%%%%%%%%
Iout3=im2double(enh);
Iout3 = Iout3(2:end-1, 2:end-1);
 HSI(:,:,3)=Iout3;
 ORT2=mean(Iout3(:))
 enh =im2uint8(hsi2rgb(HSI));
 
 
 
function [Iout1]=MyStretch(img)
I=double(img)/255;
for k=1:size(I,3),
  mi=min(min(I(:,:,k))); I(:,:,k)=I(:,:,k)-mi;
  mx=max(max(I(:,:,k))); I(:,:,k)=I(:,:,k)/mx;
end;
 Iout1=uint8(I*255);
end


function hsi = rgb2hsi(rgb)
%RGB2HSI Converts an RGB image to HSI.
% Extract the individual component images.
rgb = im2double(rgb);
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);
% Implement the conversion equations.
num = 0.5*((r - g) + (r - b));
den = sqrt((r - g).^2 + (r - b).*(g - b));
theta = acos(num./(den + eps));
H = theta;
H(b > g) = 2*pi - H(b > g);
H = H/(2*pi);
num = min(min(r, g), b);
den = r + g + b;
den(den == 0) = eps;
S = 1 - 3.* num./den;
H(S == 0) = 0;
I = (r + g + b)/3;
% Combine all three results into an hsi image.
hsi = cat(3, H, S, I);
end

function rgb = hsi2rgb(hsi)
%HSI2RGB Converts an HSI image to RGB.
% Extract the individual HSI component images.
H = hsi(:, :, 1) * 2 * pi;
S = hsi(:, :, 2);
I = hsi(:, :, 3);
% Implement the conversion equations.
R = zeros(size(hsi, 1), size(hsi, 2));
G = zeros(size(hsi, 1), size(hsi, 2));
B = zeros(size(hsi, 1), size(hsi, 2));
% RG sector (0 <= H < 2*pi/3).
idx = find( (0 <= H) & (H < 2*pi/3));
B(idx) = I(idx) .* (1 - S(idx));
R(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx)) ./ ...
                                          cos(pi/3 - H(idx)));
G(idx) = 3*I(idx) - (R(idx) + B(idx));
% BG sector (2*pi/3 <= H < 4*pi/3).
idx = find( (2*pi/3 <= H) & (H < 4*pi/3) );
R(idx) = I(idx) .* (1 - S(idx));
G(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 2*pi/3) ./ ...
                    cos(pi - H(idx)));
B(idx) = 3*I(idx) - (R(idx) + G(idx));
% BR sector.
idx = find( (4*pi/3 <= H) & (H <= 2*pi));
G(idx) = I(idx) .* (1 - S(idx));
B(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 4*pi/3) ./ ...
                                           cos(5*pi/3 - H(idx)));
R(idx) = 3*I(idx) - (G(idx) + B(idx));
% Combine all three results into an RGB image.  Clip to [0, 1] to
% compensate for floating-point arithmetic rounding effects.
rgb = cat(3, R, G, B);
rgb = max(min(rgb, 1), 0);
end


 function [x] = ikomsu( komsuno, i)
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here

 if(komsuno ==1)
     x=i-1;
 elseif(komsuno ==2)
    x= i;
 elseif(komsuno ==3)
    x= i+1;
 elseif(komsuno ==4)
    x= i-1;
 elseif(komsuno ==5)
    x= i+1;
 elseif(komsuno ==6)
   x= i-1;
 elseif(komsuno ==7)
   x= i;
 elseif(komsuno ==8)
   x= i+1;
 else
    x=i;
 
 end
 end


function [y] = jkomsu( komsuno, j )
%UNTÝTLED3 Summary of this function goes here
%   Detailed explanation goes here
 if(komsuno ==1)
    y= j-1;
 elseif(komsuno ==2)
    y= j-1;
 elseif(komsuno ==3)
   y= j-1;
 elseif(komsuno ==4)
   y= j;
 elseif(komsuno ==5)
   y= j;
 elseif(komsuno ==6)
   y= j+1;
 elseif(komsuno ==7)
   y= j+1;
 elseif(komsuno ==8)
   y= j+1;
 else
    y= j;
 
 end

end


end

