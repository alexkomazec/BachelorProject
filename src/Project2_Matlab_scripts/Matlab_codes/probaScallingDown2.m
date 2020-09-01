N=500;
M=500;

% DRUGI POKUŠAJ

row=N;
col=M;
figure;
orgimage = imread('dota2image.jpg')
% !!!prvo idu redovi, pa kolone!!!
x = imresize(orgimage,[N M])

 R = x(:,:,1);
 G = x(:,:,2);
 B = x(:,:,3);
 
 HorisontalOffsetLow=0;
 HorisontalOffsetHigh=1;
 VerticalOffsetLow=0;
 VerticalOffsetHigh=1;
 
 for r = 1:row/2
    for c = 1:col/2      
               First= R(r+VerticalOffsetLow,c+HorisontalOffsetLow,1);
               Second= R(r+VerticalOffsetLow,c+HorisontalOffsetHigh,1);
			   Average=(First+Second)/2.0;
			   RnewResized(r,c,1)=Average;
               HorisontalOffsetLow=HorisontalOffsetLow+1;
           	   HorisontalOffsetHigh=HorisontalOffsetHigh+1;

               if c==col/2
                  HorisontalOffsetLow=0;
                  HorisontalOffsetHigh=1;
                end
    end
               VerticalOffsetLow=VerticalOffsetLow+1;
               VerticalOffsetHigh=VerticalOffsetHigh+1;
               if r==row/2
                  VerticalOffsetLow=0;
                  VerticalOffsetHigh=1;
                end
 end
 
 
 
 for r = 1:row/2
    for c = 1:col/2      
               First= G(r+VerticalOffsetLow,c+HorisontalOffsetLow,1);
               Second= G(r+VerticalOffsetLow,c+HorisontalOffsetHigh,1);
			   Average=(First+Second)/2.0;
			   GnewResized(r,c,1)=Average;
               HorisontalOffsetLow=HorisontalOffsetLow+1;
           	   HorisontalOffsetHigh=HorisontalOffsetHigh+1;

               if c==col/2
                  HorisontalOffsetLow=0;
                  HorisontalOffsetHigh=1;
                end
    end
               VerticalOffsetLow=VerticalOffsetLow+1;
               VerticalOffsetHigh=VerticalOffsetHigh+1;
               if r==row/2
                  VerticalOffsetLow=0;
                  VerticalOffsetHigh=1;
                end
 end
 
  for r = 1:row/2
    for c = 1:col/2      
               First= B(r+VerticalOffsetLow,c+HorisontalOffsetLow,1);
               Second= B(r+VerticalOffsetLow,c+HorisontalOffsetHigh,1);
			   Average=(First+Second)/2.0;
			   BnewResized(r,c,1)=Average;
               HorisontalOffsetLow=HorisontalOffsetLow+1;
           	   HorisontalOffsetHigh=HorisontalOffsetHigh+1;

               if c==col/2
                  HorisontalOffsetLow=0;
                  HorisontalOffsetHigh=1;
                end
    end
               VerticalOffsetLow=VerticalOffsetLow+1;
               VerticalOffsetHigh=VerticalOffsetHigh+1;
               if r==row/2
                  VerticalOffsetLow=0;
                  VerticalOffsetHigh=1;
                end
 end
 
 
 imshow(x)
 title('Original size')
 
  newimage(:,:,1)=RnewResized;
  newimage(:,:,2)=GnewResized;
  newimage(:,:,3)=BnewResized;
 
 figure;
 imshow(newimage)
 title('New Image')