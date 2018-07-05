close all;clear all;

%Creating data for error ellipse
rng(1)
Q=[1,1]; 
d_rand=randn(50,1);
Xd_rand=normrnd(Q(1).*d_rand,1); %generates a 50x1 matrix with random distributed numbers (means/averages) 
... and a standared deviation of 1. Need to multiply d_rand by Q(1) in order to get different values in each column
Yd_rand=normrnd(Q(2).*d_rand,1);
data=[Xd_rand,Yd_rand];
mean=mean(data);

%Sensor
rng(2)
r_sen=-10+(10+10)*rand(3,2); %generates a 2x3 matrix that represents coordinates for 3 sensors
xsen=r_sen(:,1); %right column is x coordinate
ysen=r_sen(:,2); %left column is y coordinate

% Target
% rng(2)
% r_targ=-10+(10+10)*rand(1,2); %generates a 2x1 matrix that is the target's coordinates
% xtarg=r_targ(:,1);
% ytarg=r_targ(:,2);
xtarg=mean(1);
ytarg=mean(2);

minValueX=min([xsen;xtarg]); %computes the min x value from both sensor's and target's x coordinates
maxValueX=max([xsen;xtarg]);
minValueY=min([ysen;ytarg]);
maxValueY=max([ysen;ytarg]);

s1=([xsen(1:1), ysen(1:1)]); %sensor coordinates
s2=[xsen(2:2), ysen(2:2)];
s3=[xsen(3:3), ysen(3:3)];
T=([xtarg, ytarg]); %target coordinate

ang12=atan2(abs(det([s2-T;s1-T])),dot(s2-T,s1-T))*180/pi %angle between sensors 1 and 2
ang13=atan2(abs(det([s3-T;s1-T])),dot(s3-T,s1-T))*180/pi %angle between sensors 1 and 3
ang23=atan2(abs(det([s2-T;s3-T])),dot(s2-T,s3-T))*180/pi %angle between sensors 2 and 3

range_Ts1=sqrt((ytarg-ysen(1)).^2+(xtarg-xsen(1)).^2)
range_Ts2=sqrt((ytarg-ysen(2)).^2+(xtarg-xsen(2)).^2)
range_Ts3=sqrt((ytarg-ysen(3)).^2+(xtarg-xsen(3)).^2)

%%

%calculating eigenvectors and eigenvalues
cov=cov(data);
[eigvec,eigval]=eig(cov); %returns diagonal matrix of eigenvalues and cooresponding eignenvector matrix

% %Finding largest eigenvector
% [max_eigvec_c,max_eigvec_r]=find(eigval==max(max(eigval))); % find(__) finds where the max eigenvalue is located which is the fourth element (the subscript) so the max eigenvec is located in column 2 row 2
% max_eigvec=eigvec(:,max_eigvec_c); %max eigenvec is located at whatever column max_eigenvec_C cooresponds to (in this case the second colum)
% 
% %Finding largest eigenvalue
% max_eigval=max(max(eigval)); %max(matrix) returns a row vector containing the maximum value of each column in matrix so
%                           ...max(max() gives the max eigenvalue of that row vector which is the max of the entire matrix
% 
% %finding min eigenvector and eigenvalue
% if(max_eigvec_c == 1) % if max_eigvec_c equals 1 instead of 2 then...
%     min_eigval = max(eigval(:,2)); % the min_eigval is the maximum eigenvalue in the second column 
%     min_eigvec = eigvec(:,2); %the min eigenvec is the 2nd column of eigenvectors
% else
%     min_eigval = max(eigval(:,1)); %the min eigenvalue is the max eigenvalue in the first column
%     min_eigvec = eigvec(1,:); %the min eigenvec is the first column of eigvectors 
% end

%Computing max eigenvector and max eigenvalue and min eigenvector and min eigenvalue
[max_eigvec,max_eigval]=eigs(cov,1,'lm');
[min_eigvec,min_eigval]=eigs(cov,1,'sm');

%95% confidence 
theta_grid=linspace(0,2*pi); %50 points around the ellipse
chisquare_val=2.4477; %measurement of how expected values compare to results
theta=atan2(eigvec(2,2), eigvec(2,1)); %angle between x-axis and largest eigenvector
if (theta<0)
    theta=theta+2*pi;
end
%standard deviation
a=chisquare_val*sqrt(max_eigval); %major axis axis (sigma_u) (max error)     a = sqrt(eigenval(2, 2));
b=chisquare_val*sqrt(min_eigval); %sigma_V                                   b = sqrt(eigenval(1, 1));

%ellipse
ellipse_x=a*cos(theta_grid); %axis alligned ellipse in x and y coordinates
ellipse_y=b*sin(theta_grid);
R = [cos(theta) sin(theta); -sin(theta) cos(theta)]; % rotation matrix
ellipse = [ ellipse_x ; ellipse_y ]'* R; % rotated ellipse
ellipse_area=polyarea(ellipse_x,ellipse_y);

%rotated error ellipse
plot(ellipse(:,1)+mean(1),ellipse(:,2)+mean(2),'-'); 
hold on;

% Plot the eigenvectors
% quiver(mean(1), mean(2), max_eigvec(1)*sqrt(max_eigval), max_eigvec(2)*sqrt(max_eigval), '-m', 'LineWidth',1); %quiver plot displays velocity vectors as arrows with componets (u,v) at points (x,y)
% quiver(mean(1), mean(2), min_eigvec(1)*sqrt(min_eigval), min_eigvec(2)*sqrt(min_eigval), '-g', 'LineWidth',1);

plot(xsen,ysen, 'bo');
text(xsen(1),ysen(1),'  s1')
text(xsen(2),ysen(2),'  s2')
text(xsen(3),ysen(3),'  s3')
plot(xtarg,ytarg,'rx','MarkerFaceColor',[1,0,0])
text(xtarg,ytarg,'   T')
plot([xtarg,xsen(1)],[ytarg,ysen(1)],'--k')
plot([xtarg,xsen(2)],[ytarg,ysen(2)],'--k')
plot([xtarg,xsen(3)],[ytarg,ysen(3)],'--k')
perp_pt=[s1(1) s1(2)+2];
% plot(s1(1), s1(2)+2,'ko')
plot([s1(1),xsen(1)],[s1(2)+2,ysen(1)],'LineStyle', ':')
alpha1=atan2(abs(det([T-s2;perp_pt-s1])),dot(T-s1,perp_pt-s1))*180/pi
% xlabel('x')
% ylabel('y')


A=ellipse(10,:);
B=ellipse(45,:);
C=ellipse(75,:);
m=[A;B;C];
mx=m(:,1);
my=m(:,2);
% plot(mx,my,'go')
% text(mx(1),my(1),'  A')
% text(mx(2),my(2),'  B')
% text(mx(3),my(3),'  C')
       
M1=[A(1) A(2) A(1).^2+A(2).^2 1; B(1) B(2) B(1).^2+B(2).^2 1;C(1) C(2) C(1).^2+C(2).^2 1; xsen(1) ysen(1) xsen(1).^2+ysen(1).^2 1];
    if det(M1)>0
            disp('Sensor 1 lies inside ellipse')
    end
M2=[A(1) A(2) A(1).^2+A(2).^2 1; B(1) B(2) B(1).^2+B(2).^2 1;C(1) C(2) C(1).^2+C(2).^2 1; xsen(2) ysen(2) xsen(2).^2+ysen(2).^2 1];
    if det(M2)>0
            disp('Sensor 2 lies inside ellipse')
    end
M3=[A(1) A(2) A(1).^2+A(2).^2 1; B(1) B(2) B(1).^2+B(2).^2 1;C(1) C(2) C(1).^2+C(2).^2 1; xsen(3) ysen(3) xsen(3).^2+ysen(3).^2 1];
    if det(M3)>0
            disp('Sensor 3 lies inside ellipse')
    end
det_M1=det(M1);
det_M2=det(M2);
det_M3=det(M3);