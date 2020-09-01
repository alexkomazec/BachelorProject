N=2;
M=2;

row=N;
col=M;
figure;
orgimage = imread('parrot.jpg')
% !!!prvo idu redovi, pa kolone!!!
x = imresize(orgimage,[N M])

 R = x(:,:,1);
 G = x(:,:,2);
 B = x(:,:,3);
 
 HorisontalOffsetLow=0;
 HorisontalOffsetHigh=1;
 VerticalOffsetLow=0;
 VerticalOffsetHigh=1;
  
 for r = 1:row
    for c = 1:col      
               Rnew(r+VerticalOffsetLow,c+HorisontalOffsetLow,1)= R(r,c,1);
               Rnew(r+VerticalOffsetLow,c+HorisontalOffsetHigh,1)= R(r,c,1);
               Rnew(r+VerticalOffsetHigh,c+HorisontalOffsetLow,1)= R(r,c,1);
               Rnew(r+VerticalOffsetHigh,c+HorisontalOffsetHigh,1)= R(r,c,1);
               HorisontalOffsetLow=HorisontalOffsetLow+1;
           	   HorisontalOffsetHigh=HorisontalOffsetHigh+1;

               if c==col
                  HorisontalOffsetLow=0;
                  HorisontalOffsetHigh=1;
                end
    end
               VerticalOffsetLow=VerticalOffsetLow+1;
               VerticalOffsetHigh=VerticalOffsetHigh+1;
               if r==row
                  VerticalOffsetLow=0;
                  VerticalOffsetHigh=1;
                end
 end 


 






% Rbin=dec2base(R,2);
% Gbin=dec2base(G,2);
% Bbin=dec2base(B,2);
% 
% Rhex=dec2hex(R);
% Ghex=dec2hex(G);
% Bhex=dec2hex(B);
% 
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage1.txt',R,'delimiter',' ');
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage2.txt',G,'delimiter',' ');
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage3.txt',B,'delimiter',' ');
% 
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage1bin.txt',Rbin,'delimiter',' ');
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage2bin.txt',Gbin,'delimiter',' ');
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage3bin.txt',Bbin,'delimiter',' ');
% 
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage1hex.txt',Rhex,'delimiter',' ');
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage2hex.txt',Ghex,'delimiter',' ');
% dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage3hex.txt',Bhex,'delimiter',' ');
% 
 imshow(x)
 title('Original size')
% 
% 
  RnewFormula=imresize(R,2);
  GnewFormula=imresize(G,2);
  BnewFormula=imresize(B,2);
% 
 newimage(:,:,1)=Rnew;
 newimage(:,:,2)=Gnew;
 newimage(:,:,3)=Bnew;
% 
   
figure;
 imshow(newimage)
 title('New Image')
 


