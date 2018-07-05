clear all
%%%vary angles with set ranges because thesis loop is finding max A&B for each range pair
 %for a given set of ranges what is the angle that maximizes the optimizatin equation 

A_ivals=0:pi/80:pi;
B_ivals=0:pi/80:pi;

for n=1:length(A_ivals)
    for m=1:length(B_ivals)

r1=28;
r2=30;
r3=35;

alpha=r3.^2;
beta=r2.^2;
gamma=r1.^2; 

A(n)=A_ivals(n);
B(m)=B_ivals(m);

F(n,m)=alpha.*sin(A(n)).^2+beta.*sin(B(m)).^2+gamma.*sin(B(m)-A(n)).^2; %optimization equation
    end
end
Arg=abs((r2.^4.*r1.^4-r3.^4.*r1.^4-r3.^4.*r2.^4)./(2.*r3.^4.*r2.^2.*r1.^2))
if Arg<1
    disp('right angle geometry')
end
M=max(F); %max value gives most optimal geometry
[maxNum, maxIndex] = max(F(:))
[row,col]=ind2sub(size(F),maxIndex)