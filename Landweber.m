%Landweber��ά�ؽ�,���ҽ����������
clear all
clc
tic
c_l1=load('C:\Users\����\Desktop\����\moxing\kong\dianrong.dat'); %���ص���ֵ
c_l=c_l1(:,3:68);
c_h1=load('C:\Users\����\Desktop\����\moxing\man\dianrong.dat');
c_h=c_h1(:,3:68);
c_m1=load('C:\Users\����\Desktop\����\moxing\hexin\dianrong.dat');
c_m=c_m1(:,3:68);
c=(c_m'-c_l')./(c_h'-c_l');
s3=load('C:\Users\����\Desktop\����\moxing\kong\lingmindu.dat');%����������
s2=s3(:,3:68);
s1=s2';
% ep2=load('C:\Users\����\Desktop\����\moxing\sq\jiedianchangshu.dat');
% ep2=ep2(:,3);
% ep2(find(ep2==1))=0;%ԭʼ��糣���ֲ�,�߽�糣����1���ͽ�糣����0
% ep2(find(ep2~=0))=1;
% ep2;%ԭʼ��糣���ֲ�,��Ϊһ����������,�߽�糣����1���ͽ�糣����0
% ms=ep2; 
NE1=1648;
nt=66;
s=s1./(ones(NE1,1)*sum(s1'))';
st=s1'./(((sum(s1))'*ones(1,nt)));
gk=st*c;   %ע�⣺�˴������ػҶȵķ�����LBP���� wp=(sum(s))';��hd=s'*nc./wp;�����õ����ػҶ�һ��
gk(find(gk<0))=0;
gk(find(gk>1))=1;
gkmax_LBP=max(gk);
iter_num=150; %��������
ev=eig(st*s); %�����nst*ns��ȫ������ֵ������ev����
a=2/max(ev);%������������
% u=1;
I=eye(1648);
SIE1=[];AE1=[]; xg1=[];RE1=[]; %Ϊ�˻����ռ�ͼ���������������ı仯���߶���ı���
x=load('C:\Users\����\Desktop\����\moxing\hexin\jiedianchangshu.dat');
x=x(:,3);
x(find(x==1))=0;
x(find(x~=0))=1;%ԭʼ��糣���ֲ�
for i=1:iter_num;
    
     %dropout
    A=round(rand(NE1,1));%1���������0
    [row,col]=find(A==0);
    [C,D]=size(row);
    B=a*st*(c-s*gk);
    for j=1:C
        B(row(j),:)=0;
    end
    
    gk_1=gk+(a-1)*B;
    %gk_1=gk+B;
    %gk_1=gk+a*st*(c-s*gk);
    %gk_1=u*(gk-a*(2*I-nst*ns)*(nst*(ns*gk-nc)));  %%%%�ϴ����Ķ��׸Ľ��㷨��ͨ��ͬ���㶯�����Ƶ������׵�����ʽ
    gk=gk_1;
    gk(find(gk<0))=0;
    gk(find(gk>1))=1; 
    
     gkmax=max(gk);
    X=gk./gkmax;

RE=norm(X-x)/norm(x);%ͼ��������
xxx=mean(x);%ԭʼ�Ҷ�ƽ��ֵ
XX=mean(X);%�ؽ��Ҷ�ƽ��ֵ
CCm=x-xxx;
CCn=X-XX;
CC=sum(CCn.*CCm)/sqrt(sum(CCn.^2)*sum(CCm.^2));%ͼ�����ϵ��

%���η���
wucha(i,:)=RE;
xishu(i,:)=CC;
end
% gkmax=max(gk);
% gk=gk./gkmax;

lmd=load('C:\Users\����\Desktop\����\moxing\jdcs.dat');
sss=[];
ss=[];%�����ļ�

for i=1:size(lmd,1)
    if  sqrt(lmd(i,1)^2+lmd(i,2)^2)<=25
        sss=[sss;lmd(i,:)];
    end

 end

ss=sss(:,1:2);%�����ļ�
ss=ss';

x1=ss(1,:)-1.5;
x2=ss(1,:)+1.5;
y1=ss(2,:)-1.5;
y2=ss(2,:)+1.5;
DE=[x1;x2;y1;y2];

%�������������������ı仯����
i=1:iter_num;
% figure (1)
% plot(i,SIE1)%���ռ�ͼ���������������ı仯����
% xlabel('SIE1');
% figure (2)
% plot(i,AE1)
% xlabel('AE1');
figure (3)
plot(i,xishu)  %���ռ�ͼ���������������ı仯����
xlabel('CC');
figure (4)
plot(i,wucha)
xlabel('RE');
% SIE
% AE
% xg
RE
CC

% %����Ӧ��ֵ�˲�
% gk2=gk;
% c0avg=mean(c_l);
% c1avg=mean(c_h);
% bz=c0avg/c1avg;
% ncavg=mean(c);
% b=gk2(find(gk2~=0));
% bb=sort(b);%��b����������
% cc=median(bb);%ȡbb���м�ֵ
% aa=[];
% for i=1:length(gk)
%     if gk(i)>cc
%          aa=[aa;gk(i)];
%     end
% end
% gkavg=mean(aa);
% yuzhi=bz*(1-ncavg)*gkavg;   %����ϵ����0.002ʱ������Ӧ��ֵ���yuzhiΪ0.4864
%                            %����ϵ����0.2ʱ������Ӧ��ֵ���yuzhiΪ0.4002
% gk(find(gk<=0.5*yuzhi))=0;





%���ؽ�ͼ��
%hdb=gray(64);  %64���Ҷ�ֵ %,�ڰ�ͼ
hdb=jet(64);  %64���Ҷ�ֵ ��% ��ɫͼ
hdb=flipud(hdb);
wt=figure;
set(wt,'pos',[100,100,300,300])
set (gca,'position',[0.005,0.005,0.99,0.99] );
set(wt,'color','white');
axis('off');
axis('equal');
hold on;
theta=0:2*pi/63:2*pi; % ���ṹͼ
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
%xlabel('Landweber,����100������10%))');
toc