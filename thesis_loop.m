%Gives optimal angles and optimization value for every r1,2,3 combination
clear all; close all;
r1=1:.5:5;
r2=1:.5:5;
r3=1:.5:5;

RT=zeros(length(r1),length(r2),length(r3)); %for a given i,j,k zeros is goign to tell you that its not optimal and 1 is going to tell you that it is optimal


for i=1:length(r1)
    for j=1:length(r2)
        for k=1:length(r3)

alpha=r3.^2;
beta=r2.^2;
gamma=r1.^2; 

theta12(i,j,k)=.5.*acos((r2(j).^4.*r1(i).^4-r3(k).^4.*r1(i).^4-r3(k).^4.*r2(j).^4)./(2.*r3(k).^4.*r2(j).^2.*r1(i).^2));
theta13(i,j,k)=.5.*acos((r3(k).^4.*r1(i).^4-r3(k).^4.*r2(j).^4-r2(j).^4.*r1(i).^4)./(2.*r3(k).^2.*r2(j).^4.*r1(i).^2));
theta23=3.1415-theta12-theta13;

theta12D=theta12*(180/pi);
theta13D=theta13*(180/pi);
theta23D=theta23*(180/pi);

theta12_R=(180-theta12D);
theta13_R=(180-theta13D);
theta23_R=(180-theta23D);

A=theta12_R*(pi/180);
B=theta13_R*(pi/180);

F(i,j,k)=(alpha(k).*sin(A(i,j,k)).^2+beta(j).*sin(B(i,j,k)).^2+gamma(i).*sin(B(i,j,k)-A(i,j,k)).^2);

Arg(i,j,k)=abs((r2(j).^4.*r1(i).^4-r3(k).^4.*r1(i).^4-r3(k).^4.*r2(j).^4)./(2.*r3(k).^4.*r2(j).^2.*r1(i).^2)); 

% P(i,j,k)=abs((beta(j).^2.*gamma(i).^2-alpha(k).^2.*gamma(i).^2-alpha(k).^2.*beta(j).^2)./(2.*alpha(k).^2.*beta(j).*gamma(i)));
% % Q(i,j,k)=abs((alpha(k).^2.*gamma(i).^2-alpha(k).^2.*beta(j).^2-beta(j).^2.*gamma(i).^2)./(2.*alpha(k).*beta(j).^2.*gamma(i)));

if Arg(i,j,k)<1
    RT(i,j,k)=1;
%     disp('not right angle geometry')
end      
        
        end

    end
end
[M]=max(F);
% for i=1:length(r3)
%     
% [R1,R2]=ndgrid(r1,r2);
% figure
% surf(R1,R2,RT(:,:,i)); %1 cooresponds to first r3 value
% view(90,90)
% xlabel(r1)
% ylabel(r2)
% colorbar
% end