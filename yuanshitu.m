clear all
clc

gk=load('C:\Users\夏至\Desktop\假期\moxing\sq\jiedianchangshu.dat');
NE1=1648;
gk=gk(:,3);
gk(find(gk==1))=0;%原始介电常数分布,高介电常数置1，低介电常数置0
gk(find(gk~=0))=1;
lmd=load('C:\Users\夏至\Desktop\假期\moxing\jdcs.dat');
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
