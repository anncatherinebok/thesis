clear all;

r1=10;
r2=20;
r3=30;

RT=zeros(length(r1),length(r2),length(r3)); %for a given i,j,k zeros is goign to tell you that its not optimal and 1 is going to tell you that it is optimal

alpha=r3.^2;
beta=r2.^2;
gamma=r1.^2;

theta12=.5*acos((r2.^4*r1.^4-r3.^4*r1.^4-r3.^4*r2.^4)./(2*r3.^4*r2.^2*r1.^2));
theta13=.5*acos((r3.^4*r1.^4-r3.^4*r2.^4-r2.^4*r1.^4)./(2*r3.^2*r2.^4*r1.^2));
theta23=3.1415-theta12-theta13;

theta12D=theta12*(180/pi);
theta13D=theta13*(180/pi);
theta23D=theta23*(180/pi);

theta12_R=180-theta12D
theta13_R=180-theta13D
theta23_R=180-theta23D

A=theta12_R*(pi/180);
B=theta13_R*(pi/180);

Arg=abs((r2.^4*r1.^4-r3.^4*r1.^4-r3.^4*r2.^4)./(2*r3.^4*r2.^2*r1.^2)) 

if Arg<1
    disp('NOT right angle geometry')
    RT=1
else
    disp('right angle geometry')
end

F=alpha.*sin(A).^2+beta.*sin(B).^2+gamma.*sin(B-A).^2;
 
% P=abs((beta.^2*gamma.^2-alpha.^2*gamma.^2-alpha.^2*beta.^2)/(2*alpha.^2*beta*gamma));
% Q=abs((alpha.^2*gamma.^2-alpha.^2*beta.^2-beta.^2*gamma.^2)/(2*alpha*beta.^2*gamma));
