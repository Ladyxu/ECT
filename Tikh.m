%Tikhonov与SIRT重建
clear all
clc

%LBP
c_l1=load('C:\Users\夏至\Desktop\假期\moxing\kong\dianrong.dat'); %加载电容值
c_l=c_l1(:,3:68);
c_h1=load('C:\Users\夏至\Desktop\假期\moxing\man\dianrong.dat');
c_h=c_h1(:,3:68);
c_m1=load('C:\Users\夏至\Desktop\假期\moxing\hexin\dianrong.dat');
c_m=c_m1(:,3:68);
c=(c_m'-c_l')./(c_h'-c_l');
s3=load('C:\Users\夏至\Desktop\假期\moxing\kong\lingmindu.dat');%加载灵敏度
s2=s3(:,3:68);
s1=s2';
NE1=1648;
nt=66;
s=s1./(ones(NE1,1)*sum(s1'))';
st=s1'./(((sum(s1))'*ones(1,nt)));
tic
gk=st*c;   %注意：此处求像素灰度的方法与LBP中用 wp=(sum(s))';和hd=s'*nc./wp;语句求得的像素灰度一样
gk(find(gk<0))=0;
gk(find(gk>1))=1;


%Tikhonov
% B=0.001;
% C=eye(NE1);
% gk=inv(st*s+B*C)*st*c;
% gk(find(gk<0))=0;
% gk(find(gk>1))=1;
% toc

%SIRT,博士论文公式
% a=1;
% C=1./sum(s);
% R=1./sum(s,2);
% for i=1:150
%     gk=gk+a*diag(C)*st*diag(R)*(c-s*gk);
%     gk(find(gk<0))=0;
%     gk(find(gk>1))=1;
% end

%唯一能用的
for i=1:50
    gk=gk-st*diag(diag(s*st))*(s*gk-c);
    gk(find(gk<0))=0;
    gk(find(gk>1))=1;
    
% X=gk;
% x=load('C:\Users\夏至\Desktop\假期\moxing\hexin\jiedianchangshu.dat');
% x=x(:,3);
% x(find(x==1))=0;
% x(find(x~=0))=1;%原始介电常数分布
% RE=norm(X-x,2)/norm(x,2);%图像相对误差
% wucha(i,:)=RE;
end
toc

% plot(wucha,'-*g')
% %SIRT同步代数重建,公式为2000年苏邦良文献中提供，越跑误差越大，不知道哪错
% for t=1:150
%     a=1.5+2/t;%松弛因子
%     b=c-s*gk;
%     for i=1:66
%         d(i,:)=b(i).*s(i,:);
%     end
%     gk=gk+(sum(d)./sum(s))';
%    gk(find(gk<0))=0;
%    gk(find(gk>1))=1;
% end

% gk=gk';
% for t=1:10
%         b=c-s*gk;
%     for i=1:66
%         d(i,:)=b(i).*s(i,:);
%     end
%     gk=gk+((sum(d/sum(s,2)))*s)/66;
%     gk(find(gk<0))=0;
%     gk(find(gk>1))=1;
% end

X=gk;
x=load('C:\Users\夏至\Desktop\假期\moxing\hexin\jiedianchangshu.dat');
x=x(:,3);
x(find(x==1))=0;
x(find(x~=0))=1;%原始介电常数分布
RE=norm(X-x,2)/norm(x,2);%图像相对误差

xxx=mean(x);%原始灰度平均值
XX=mean(X);%重建灰度平均值
CCm=x-xxx;
CCn=X-XX;
CC=sum(CCn.*CCm)/sqrt(sum(CCn.^2)*sum(CCm.^2));%图像相关系数
display(['RE : ', num2str(RE)]);
display(['CC : ', num2str(CC)]);

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

x1=ss(1,:)-1.5;
x2=ss(1,:)+1.5;
y1=ss(2,:)-1.5;
y2=ss(2,:)+1.5;
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
    l=round(1+63*X(e));%round四舍五入取整
    co=hdb(l,:);
    %co=gk(e);
    fill (xx,yy,co,'EdgeColor','none');
end
%colormap(hdb)
%colorbar
%xlabel('Landweber,迭代100，噪声10%))');
