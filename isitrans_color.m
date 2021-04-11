function  [newR]=isitrans_color(maskR);
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
A=9;
katR=0;
oranR=0;

masR(1,1)=maskR(1);
masR(1,2)=maskR(2);
masR(1,3)=maskR(3);
masR(2,1)=maskR(4);
masR(2,2)=maskR(9);
masR(2,3)=maskR(5);
masR(3,1)=maskR(6);
masR(3,2)=maskR(7);
masR(3,3)=maskR(8);

%-----------------------------------------
ortR=mean(maskR); oranR=maskR(9)-ortR;

%------------------------------------------
%R
[max_ustR1 siraR11]=max(masR(1,:));
[max_ustR2 siraR12]=max(masR(3,:));
if(max_ustR1>max_ustR2);
    max_ustR=max_ustR1;
    siraR1=siraR11;
else
    max_ustR=max_ustR2;
    siraR1=siraR12;
end
[min_altR1 siraR21]=min(masR(1,:));
[min_altR2 siraR22]=min(masR(3,:));
if(min_altR1<min_altR2);
    min_altR=min_altR1;
    siraR2=siraR21;
else
    min_altR=min_altR2;
    siraR2=siraR22;
end

%----------------------------------------------------------
katR1=(max_ustR-maskR(9));katR2=(min_altR-maskR(9)); katR=(katR1+katR2)/(32);
katR1=(katR)/12; 
% contrastR=1-katR1;

%----------------------------
isi_avR=0;


newR=0;

%  Determining the L value in heat transfer
%-------------
%R
if (siraR1==2)
    LR1=1;
else
    LR1=1.4142;
end
if (siraR2==2 )
    LR2=1;
else
    LR2=1.4142;
end
LR=LR1+LR2;




%  //Calculation of heat in the mask according to the center pixel

 isi_avR=katR*A*[(max_ustR-min_altR)]/ LR;
  


 
%EHNANCEMENT process

            if(isi_avR >=0 & isi_avR<100)
            newR=(maskR(9)-abs(1*oranR));
            elseif( isi_avR <0 & isi_avR>-100)
            newR=(maskR(9)+abs(1*oranR));
            else
            newR=maskR(9);
            end
            
  
 end

