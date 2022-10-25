%Tikhonov��SIRT�ؽ�
clear all
clc

%LBP
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
NE1=1648;
nt=66;
s=s1./(ones(NE1,1)*sum(s1'))';
st=s1'./(((sum(s1))'*ones(1,nt)));
tic
gk=st*c;   %ע�⣺�˴������ػҶȵķ�����LBP���� wp=(sum(s))';��hd=s'*nc./wp;�����õ����ػҶ�һ��
gk(find(gk<0))=0;
gk(find(gk>1))=1;


%Tikhonov
% B=0.001;
% C=eye(NE1);
% gk=inv(st*s+B*C)*st*c;
% gk(find(gk<0))=0;
% gk(find(gk>1))=1;
% toc

%SIRT,��ʿ���Ĺ�ʽ
% a=1;
% C=1./sum(s);
% R=1./sum(s,2);
% for i=1:150
%     gk=gk+a*diag(C)*st*diag(R)*(c-s*gk);
%     gk(find(gk<0))=0;
%     gk(find(gk>1))=1;
% end

%Ψһ���õ�
for i=1:50
    gk=gk-st*diag(diag(s*st))*(s*gk-c);
    gk(find(gk<0))=0;
    gk(find(gk>1))=1;
    
% X=gk;
% x=load('C:\Users\����\Desktop\����\moxing\hexin\jiedianchangshu.dat');
% x=x(:,3);
% x(find(x==1))=0;
% x(find(x~=0))=1;%ԭʼ��糣���ֲ�
% RE=norm(X-x,2)/norm(x,2);%ͼ��������
% wucha(i,:)=RE;
end
toc

% plot(wucha,'-*g')
% %SIRTͬ�������ؽ�,��ʽΪ2000���հ����������ṩ��Խ�����Խ�󣬲�֪���Ĵ�
% for t=1:150
%     a=1.5+2/t;%�ɳ�����
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
x=load('C:\Users\����\Desktop\����\moxing\hexin\jiedianchangshu.dat');
x=x(:,3);
x(find(x==1))=0;
x(find(x~=0))=1;%ԭʼ��糣���ֲ�
RE=norm(X-x,2)/norm(x,2);%ͼ��������

xxx=mean(x);%ԭʼ�Ҷ�ƽ��ֵ
XX=mean(X);%�ؽ��Ҷ�ƽ��ֵ
CCm=x-xxx;
CCn=X-XX;
CC=sum(CCn.*CCm)/sqrt(sum(CCn.^2)*sum(CCm.^2));%ͼ�����ϵ��
display(['RE : ', num2str(RE)]);
display(['CC : ', num2str(CC)]);

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
    l=round(1+63*X(e));%round��������ȡ��
    co=hdb(l,:);
    %co=gk(e);
    fill (xx,yy,co,'EdgeColor','none');
end
%colormap(hdb)
%colorbar
%xlabel('Landweber,����100������10%))');
