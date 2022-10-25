clear all
clc

gk=load('C:\Users\����\Desktop\����\moxing\sq\jiedianchangshu.dat');
NE1=1648;
gk=gk(:,3);
gk(find(gk==1))=0;%ԭʼ��糣���ֲ�,�߽�糣����1���ͽ�糣����0
gk(find(gk~=0))=1;
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
