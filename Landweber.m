%Landweber二维重建,并且进行误差评价
clear all
clc
tic
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
% ep2=load('C:\Users\夏至\Desktop\假期\moxing\sq\jiedianchangshu.dat');
% ep2=ep2(:,3);
% ep2(find(ep2==1))=0;%原始介电常数分布,高介电常数置1，低介电常数置0
% ep2(find(ep2~=0))=1;
% ep2;%原始介电常数分布,其为一个列向量，,高介电常数置1，低介电常数置0
% ms=ep2; 
NE1=1648;
nt=66;
s=s1./(ones(NE1,1)*sum(s1'))';
st=s1'./(((sum(s1))'*ones(1,nt)));
gk=st*c;   %注意：此处求像素灰度的方法与LBP中用 wp=(sum(s))';和hd=s'*nc./wp;语句求得的像素灰度一样
gk(find(gk<0))=0;
gk(find(gk>1))=1;
gkmax_LBP=max(gk);
iter_num=150; %迭代步数
ev=eig(st*s); %求矩阵nst*ns的全部特征值，构成ev向量
a=2/max(ev);%迭代步长因子
% u=1;
I=eye(1648);
SIE1=[];AE1=[]; xg1=[];RE1=[]; %为了画出空间图像误差随迭代次数的变化曲线而设的变量
x=load('C:\Users\夏至\Desktop\假期\moxing\hexin\jiedianchangshu.dat');
x=x(:,3);
x(find(x==1))=0;
x(find(x~=0))=1;%原始介电常数分布
for i=1:iter_num;
    
     %dropout
    A=round(rand(NE1,1));%1矩阵随机置0
    [row,col]=find(A==0);
    [C,D]=size(row);
    B=a*st*(c-s*gk);
    for j=1:C
        B(row(j),:)=0;
    end
    
    gk_1=gk+(a-1)*B;
    %gk_1=gk+B;
    %gk_1=gk+a*st*(c-s*gk);
    %gk_1=u*(gk-a*(2*I-nst*ns)*(nst*(ns*gk-nc)));  %%%%严春满的二阶改进算法：通过同伦摄动方法推导出二阶迭代公式
    gk=gk_1;
    gk(find(gk<0))=0;
    gk(find(gk>1))=1; 
    
     gkmax=max(gk);
    X=gk./gkmax;

RE=norm(X-x)/norm(x);%图像相对误差
xxx=mean(x);%原始灰度平均值
XX=mean(X);%重建灰度平均值
CCm=x-xxx;
CCn=X-XX;
CC=sum(CCn.*CCm)/sqrt(sum(CCn.^2)*sum(CCm.^2));%图像相关系数

%依次分析
wucha(i,:)=RE;
xishu(i,:)=CC;
end
% gkmax=max(gk);
% gk=gk./gkmax;

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

%画各种误差随迭代次数的变化曲线
i=1:iter_num;
% figure (1)
% plot(i,SIE1)%画空间图像误差随迭代次数的变化曲线
% xlabel('SIE1');
% figure (2)
% plot(i,AE1)
% xlabel('AE1');
figure (3)
plot(i,xishu)  %画空间图像误差随迭代次数的变化曲线
xlabel('CC');
figure (4)
plot(i,wucha)
xlabel('RE');
% SIE
% AE
% xg
RE
CC

% %自适应阈值滤波
% gk2=gk;
% c0avg=mean(c_l);
% c1avg=mean(c_h);
% bz=c0avg/c1avg;
% ncavg=mean(c);
% b=gk2(find(gk2~=0));
% bb=sort(b);%将b按升序排列
% cc=median(bb);%取bb的中间值
% aa=[];
% for i=1:length(gk)
%     if gk(i)>cc
%          aa=[aa;gk(i)];
%     end
% end
% gkavg=mean(aa);
% yuzhi=bz*(1-ncavg)*gkavg;   %正则化系数是0.002时，自适应阈值结果yuzhi为0.4864
%                            %正则化系数是0.2时，自适应阈值结果yuzhi为0.4002
% gk(find(gk<=0.5*yuzhi))=0;





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
set(kk,'linewidth',2);
for e=1:NE1
    xx=[DE(1,e);DE(2,e);DE(2,e);DE(1,e)];
    yy=[DE(3,e);DE(3,e);DE(4,e);DE(4,e)];
    l=round(1+63*X(e));
    co=hdb(l,:);
    %co=gk(e);
    fill (xx,yy,co,'EdgeColor','none');
end
%colormap(hdb)
%colorbar
%xlabel('Landweber,迭代100，噪声10%))');
toc