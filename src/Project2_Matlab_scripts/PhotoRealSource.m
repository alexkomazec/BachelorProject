delete 'F:\Questa\examples\Diplomski\vc\FirstDim.txt'
delete 'F:\Questa\examples\Diplomski\vc\SecondDim.txt'
delete 'F:\Questa\examples\Diplomski\vc\ThirdDim.txt'

delete 'F:\Questa\examples\Diplomski\vc\MatlabFirstDim.txt'
delete 'F:\Questa\examples\Diplomski\vc\MatlabSecondDim.txt'
delete 'F:\Questa\examples\Diplomski\vc\MatlabThirdDim.txt'

N=150;
M=150;

row=N;
col=M;

orgimage = imread('ARMcap.jpg')
 x = imresize(orgimage,[N M])

% R =uint8 (255*rand(row,col))
% G =uint8 (255*rand(row,col))
% B =uint8 (255*rand(row,col))

 R = x(:,:,1);
 G = x(:,:,2);
 B = x(:,:,3);
 
Rbin=dec2base(R,2);
Gbin=dec2base(G,2);
Bbin=dec2base(B,2);

imshow(x);

 dlmwrite('F:\Questa\examples\Diplomski\vc\MatlabFirstDim.txt',R(),'delimiter',' ')
 dlmwrite('F:\Questa\examples\Diplomski\vc\MatlabSecondDim.txt',G(),'delimiter',' ')
 dlmwrite('F:\Questa\examples\Diplomski\vc\MatlabThirdDim.txt',B(),'delimiter',' ')
 

 dlmwrite('F:\Questa\examples\Diplomski\Simulation\FirstDim.txt',Rbin(),'-append','delimiter','','newline','pc')
 dlmwrite('F:\Questa\examples\Diplomski\Simulation\SecondDim.txt',Gbin(),'-append','delimiter','','newline','pc')
 dlmwrite('F:\Questa\examples\Diplomski\Simulation\ThirdDim.txt',Bbin(),'-append','delimiter','','newline','pc')
  