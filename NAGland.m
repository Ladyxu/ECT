clear all
clc

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

% load s1.mat%滤波

NE1=1648;
nt=66;
s=s1./(ones(NE1,1)*sum(s1'))';
st=s1'./(((sum(s1))'*ones(1,nt)));

%降维
% data = s';%降维
% data=zscore(data);     %数据的标准化
% r=corrcoef(data);      %计算相关系数矩阵r
% %下面利用相关系数矩阵进行主成分分析，vec1的第一列为r的第一特征向量，即主成分的系数
% [vec1,lamda,rate]=pcacov(r);                 %lamda为r的特征值，rate为各个主成分的贡献率
% f=repmat(sign(sum(vec1)),size(vec1,1),1);    %构造与vec1同维数的元素为±1的矩阵,repmat复制和平铺矩阵，sign符号函数
% vec2=vec1.*f;             %修改特征向量的正负号，使得每个特征向量的分量和为正，即为最终的特征向量
% num = max(find(lamda>0.01)); %num为选取的主成分的个数,这里选取特征值大于1的
% df=data*vec2(:,1:num);    %计算各个主成分的得分
% tf=df*rate(1:num)/100;    %计算综合得分
% [stf,ind]=sort(tf,'descend');  %把得分按照从高到低的次序排列
% stf=stf'; ind=ind';            %stf为得分从高到低排序，ind为对应的样本编号
% s=vec2(:,1:num)'*s;
% A=s;
% st1=vec2(:,1:num)'*st';
% st=st1';
% c=vec2(:,1:num)'*c;

gk=st*c;   %注意：此处求像素灰度的方法与LBP中用 wp=(sum(s))';和hd=s'*nc./wp;语句求得的像素灰度一样
gk(find(gk<0))=0;
gk(find(gk>1))=1;
gkmax_LBP=max(gk);
iter_num=50; %迭代步数
ev=eig(st*s); %求矩阵nst*ns的全部特征值，构成ev向量
a=2/max(ev);%迭代步长因子
%u=1;
I=eye(1648);
%SIE1=[];AE1=[]; xg1=[];RE1=[]; %为了画出空间图像误差随迭代次数的变化曲线而设的变量
% beta=1;
% zk=gk;
gk_0=gk;
for i=1:iter_num;
%    alpha=(i-1)/(i+beta);
%    xk=zk+a*st*(c-s*zk);%2017论文
%    zk=xk+alpha*(xk-xk_0);
%    xk_0=xk;
alpha=(i-1)/(i+100);%Nesterov加速landweber
zk=gk+alpha*(gk-gk_0);
gk_1=zk-a*st*(s*zk-c);
gk_0=gk;
gk=gk_1;
   gk(find(gk<0))=0;
   gk(find(gk>1))=1;
end
gkmax=max(gk);
gk=gk./gkmax;

%画图
X=gk;
x=load('C:\Users\夏至\Desktop\假期\moxing\hexin\jiedianchangshu.dat');
x=x(:,3);
x(find(x==1))=0;
x(find(x~=0))=1;%原始介电常数分布
%a=x;
%save C:\Users\夏至\Desktop\假期\moxingfuxian\hexin\G.mat a
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
    l=round(1+63*X(e));
    co=hdb(l,:);
    %co=gk(e);
    fill (xx,yy,co,'EdgeColor','none');
end
%colormap(hdb)
%colorbar
%xlabel('Landweber,迭代100，噪声10%))');