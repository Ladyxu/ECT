%Landweber��ά�ؽ�,���ҽ����������
clear all
clc
tic
c_l1=load('C:\Users\SUT\Desktop\moxing\kong\dianrong.dat'); %���ص���ֵ
c_l=c_l1(:,3:68);
c_h1=load('C:\Users\SUT\Desktop\moxing\man\dianrong.dat');
c_h=c_h1(:,3:68)
c_m1=load('C:\Users\SUT\Desktop\moxing\hexin\dianrong.dat');
c_m=c_m1(:,3:68)
c=(c_m'-c_l')./(c_h'-c_l');
s3=load('C:\Users\SUT\Desktop\moxing\hexin\lingmindu.dat');%����������
s2=s3(:,3:68);
s1=s2';
NE1=1648;
nt=66;
s=s1./(ones(NE1,1)*sum(s1'))';
st=s1'./(((sum(s1))'*ones(1,nt)));
gk=st*c;   %ע�⣺�˴������ػҶȵķ�����LBP���� wp=(sum(s))';��hd=s'*nc./wp;�����õ����ػҶ�һ��
gk(find(gk<0))=0;
gk(find(gk>1))=1;
gkmax_LBP=max(gk);
y=c;
save C:\Users\SUT\Desktop\moxing\hexin\y.mat y
lmd=load('C:\Users\SUT\Desktop\moxing\jdcs.dat');
sss=[];
ss=[];%�����ļ�

for i=1:size(lmd,1)
    if  sqrt(lmd(i,1)^2+lmd(i,2)^2)<=25
        sss=[sss;lmd(i,:)];
    end

 end

ss=sss(:,1:2);%�����ļ�
ss=ss';

x1=ss(1,:)-0.8;
x2=ss(1,:)+0.8;
y1=ss(2,:)-0.8;
y2=ss(2,:)+0.8;
DE=[x1;x2;y1;y2];


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
set(kk,'linewidth',2);%��Բ
for e=1:NE1
    xx=[DE(1,e);DE(2,e);DE(2,e);DE(1,e)]; %DEΪ�����ĺ�������,DE(1,e)Ϊ������ߵ�ĺ�����,DE(2,e)Ϊ�����ұߵ�ĺ�����,DE(3,e)Ϊ�����±ߵ��������,DE(4,e)Ϊ�����ϱߵ��������
    yy=[DE(3,e);DE(3,e);DE(4,e);DE(4,e)];
    l=round(1+63*gk(e));
    co=hdb(l,:);
    %co=gk(e);
    fill (xx,yy,co,'EdgeColor','none');
end
%colormap(hdb)
%colorbar
%xlabel('Landweber,����100������10%))');
toc