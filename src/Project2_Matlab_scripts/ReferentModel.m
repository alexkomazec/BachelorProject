N=150;
M=150;

row=N;
col=M;


delete 'F:\Questa\examples\Diplomski\vc\NewFirstDim.txt'
delete 'F:\Questa\examples\Diplomski\vc\NewSecondDim.txt'
delete 'F:\Questa\examples\Diplomski\vc\NewThirdDim.txt'

filename1 = 'F:\Questa\examples\Diplomski\vc\MatlabFirstDim.txt';
filename2 = 'F:\Questa\examples\Diplomski\vc\MatlabSecondDim.txt';
filename3 = 'F:\Questa\examples\Diplomski\vc\MatlabThirdDim.txt';

delimiterIn1 = ' ';
delimiterIn2 = ' ';
delimiterIn3 = ' ';
headerlinesIn1 = 0;
headerlinesIn2 = 0;
headerlinesIn3 = 0;
FD_new= importdata(filename1,delimiterIn1,headerlinesIn1)
SD_new= importdata(filename2,delimiterIn2,headerlinesIn2)
TD_new= importdata(filename3,delimiterIn3,headerlinesIn3)


R = uint8(FD_new)
G = uint8(SD_new)
B = uint8(TD_new)

 x(:,:,1) = R;
 x(:,:,2) = G;
 x(:,:,3) = B;
 
 

J = imresize(x, 2);

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

for r = 1:row
    for c = 1:col      
               Gnew(r+VerticalOffsetLow,c+HorisontalOffsetLow,1)= G(r,c,1);
               Gnew(r+VerticalOffsetLow,c+HorisontalOffsetHigh,1)= G(r,c,1);
               Gnew(r+VerticalOffsetHigh,c+HorisontalOffsetLow,1)= G(r,c,1);
               Gnew(r+VerticalOffsetHigh,c+HorisontalOffsetHigh,1)= G(r,c,1);
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
 
 

for r = 1:row
    for c = 1:col      
               Bnew(r+VerticalOffsetLow,c+HorisontalOffsetLow,1)= B(r,c,1);
               Bnew(r+VerticalOffsetLow,c+HorisontalOffsetHigh,1)= B(r,c,1);
               Bnew(r+VerticalOffsetHigh,c+HorisontalOffsetLow,1)= B(r,c,1);
               Bnew(r+VerticalOffsetHigh,c+HorisontalOffsetHigh,1)= B(r,c,1);
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



 newimage(:,:,1)=Rnew;
 newimage(:,:,2)=Gnew;
 newimage(:,:,3)=Bnew;
 
figure
imshow(x);
title('Original Picture')
figure
imshow(newimage);
title('Resized Picture')

 
Rbin=dec2base(Rnew,2);
Gbin=dec2base(Gnew,2);
Bbin=dec2base(Bnew,2);

 dlmwrite('F:\Questa\examples\Diplomski\Simulation\NewFirstDim.txt',Rbin(),'-append','delimiter','','newline','pc')
 dlmwrite('F:\Questa\examples\Diplomski\Simulation\NewSecondDim.txt',Gbin(),'-append','delimiter','','newline','pc')
 dlmwrite('F:\Questa\examples\Diplomski\Simulation\NewThirdDim.txt',Bbin(),'-append','delimiter','','newline','pc')

 
 
 