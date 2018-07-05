clear; 
close all;

theta12=(0:pi/50:pi)*180/pi;
theta13=(0:pi/50:pi)*180/pi;

% theta12=(0:pi/50:pi);
% theta13=(0:pi/50:pi);

r1=10;
r2=20;
r3=32;

alpha=r3.^2;
beta=r2.^2;
gamma=r1.^2; 

[THETA12,THETA13]=ndgrid(theta12,theta13);
F=(alpha.*sind(THETA12).^2+beta.*sind(THETA13).^2+gamma.*sind(THETA13-THETA12).^2);
figure(1)
surf(THETA12,THETA13,F);
view(90,90);
title('Surface Plot')
xlabel('theta12')
ylabel('theta13')
colorbar
colormap jet

F(:)>=(F(:)*0.8)& F(:)<=max(F(:));
F_max=max(max(F));        
FF=F;
for i=1:length(theta12)
    for j=1:length(theta13)
       if FF(i,j)<=F_max*0.8 % 80% of x and y values in FF will be 0 so you can see the most optimal region in surface plot
           FF(i,j)=0;
       end
    end
end
figure(2)
surf(THETA12, THETA13,FF);
view(90,90);
title('optimal surface plot')
xlabel('theta12')
ylabel('theta13')
colorbar
colormap jet

figure(3)
contour(THETA12,THETA13,FF);
[C,h]=contour(THETA12,THETA13,FF,'LineColor','flat');
[THETA12,THETA13,FF]=C2xyz(C); %using function from C2xyz.m

Lvls=h.LevelList;

if length(Lvls)~=length(FF)
   Angle12=[THETA12{end-2} THETA12{end-1}] %THETA12{end}]; %will include the top most optimal levels which will include the 90,90 when it has 180 degree geometry
   Angle13=[THETA13{end-2} THETA13{end-1}] %THETA13{end}];
   Angle12=Angle12';
   Angle13=Angle13';
   AngleMatrix=[Angle12,Angle13];
    
else
   Angle12=THETA12{end};
   Angle13=THETA13{end};
   Angle12=Angle12';
   Angle13=Angle13';
   AngleMatrix=[Angle12,Angle13];
end 
figure(4)
plot(Angle12,Angle13)
xlabel('Theta12')
ylabel('Theta13')

% figure(5) 
%  if length(Lvls)~=length(FF) %if right angle geometry
%     shp=alphaShape(Angle12(2:end-5),Angle13(2:end-5)); %deletes the repeating 90's and first x and y point of AngleMatrix
%     plot(shp)
%     grid
%     tf=inShape(shp,90,90); %returns 1 if points are in optimal shape
% 
%  else
%      shp=alphaShape(Angle12(1:end-1),Angle13(1:end-1));
%      plot(shp)
%      grid
%      tf=inShape(shp,90,90);
%  end 

