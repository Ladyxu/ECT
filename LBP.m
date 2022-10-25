%Landweber二维重建,并且进行误差评价
clear all
clc
tic
c_l1=load('C:\Users\SUT\Desktop\moxing\kong\dianrong.dat'); %加载电容值
c_l=c_l1(:,3:68);
c_h1=load('C:\Users\SUT\Desktop\moxing\man\dianrong.dat');
c_h=c_h1(:,3:68)
c_m1=load('C:\Users\SUT\Desktop\moxing\hexin\dianrong.dat');
c_m=c_m1(:,3:68)
c=(c_m'-c_l')./(c_h'-c_l');
s3=load('C:\Users\SUT\Desktop\moxing\hexin\lingmindu.dat');%加载灵敏度
s2=s3(:,3:68);
s1=s2';
NE1=1648;
nt=66;
s=s1./(ones(NE1,1)*sum(s1'))';
st=s1'./(((sum(s1))'*ones(1,nt)));
gk=st*c;   %注意：此处求像素灰度的方法与LBP中用 wp=(sum(s))';和hd=s'*nc./wp;语句求得的像素灰度一样
gk(find(gk<0))=0;
gk(find(gk>1))=1;
gkmax_LBP=max(gk);
y=c;
save C:\Users\SUT\Desktop\moxing\hexin\y.mat y
lmd=load('C:\Users\SUT\Desktop\moxing\jdcs.dat');
sss=[];
ss=[];%坐标文件

for i=1:size(lmd,1)
    if  sqrt(lmd(i,1)^2+lmd(i,2)^2)<=25
        sss=[sss;lmd(i,:)];
    end

 end

ss=sss(:,1:2);%坐标文件
ss=ss';

x1=ss(1,:)-0.8;
x2=ss(1,:)+0.8;
y1=ss(2,:)-0.8;
y2=ss(2,:)+0.8;
DE=[x1;x2;y1;y2];


%画重建图像
%hdb=gray(64);  %64个灰度值 %,黑白图
hdb=jet(64);  %64个灰度值 ，% 彩色图
hdb=flipud(hdb);
wt=figure;
set(wt,'pos',[100,100,300,300])
set (gca,'position',[0.005,0.005,0.99,0.99] );
set(wt,'color','white');
axis('off');
axis('equal');
hold on;
theta=0:2*pi/63:2*pi; % 画结构图
rr=ones(1,64)*25;
kk=polar(theta,rr,'k-');
set(kk,'linewidth',2);%画圆
for e=1:NE1
    xx=[DE(1,e);DE(2,e);DE(2,e);DE(1,e)]; %DE为网格点的横纵坐标,DE(1,e)为网格左边点的横坐标,DE(2,e)为网格右边点的横坐标,DE(3,e)为网格下边点的纵坐标,DE(4,e)为网格上边点的纵坐标
    yy=[DE(3,e);DE(3,e);DE(4,e);DE(4,e)];
    l=round(1+63*gk(e));
    co=hdb(l,:);
    %co=gk(e);
    fill (xx,yy,co,'EdgeColor','none');
end
%colormap(hdb)
%colorbar
%xlabel('Landweber,迭代100，噪声10%))');
toc