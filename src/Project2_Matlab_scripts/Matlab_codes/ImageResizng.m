orgimage = imread('grabber005.ppm')
orgimage =imresize(orgimage,0.2)



R = orgimage(:,:,1);
G = orgimage(:,:,2);
B = orgimage(:,:,3);


Rbin=dec2base(R,2);
Gbin=dec2base(G,2);
Bbin=dec2base(B,2);

Rhex=dec2hex(R);
Ghex=dec2hex(G);
Bhex=dec2hex(B);

dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage1.txt',R,'delimiter',' ');
dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage2.txt',G,'delimiter',' ');
dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage3.txt',B,'delimiter',' ');

dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage1bin.txt',Rbin,'delimiter',' ');
dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage2bin.txt',Gbin,'delimiter',' ');
dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage3bin.txt',Bbin,'delimiter',' ');

dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage1hex.txt',Rhex,'delimiter',' ');
dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage2hex.txt',Ghex,'delimiter',' ');
dlmwrite('C:\Users\aleks\Desktop\Diplomski\PSDS\MatlabPrograms\OrgImage3hex.txt',Bhex,'delimiter',' ');




imshow(orgimage)
title('Original size')


Rnew=imresize(R,0.5);
Gnew=imresize(G,0.5);
Bnew=imresize(B,0.5);

newimage(:,:,1)=Rnew;
newimage(:,:,2)=Gnew;
newimage(:,:,3)=Bnew;

imshow(newimage)
title('New Image')