clear all
clc

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

% load s1.mat%�˲�

NE1=1648;
nt=66;
s=s1./(ones(NE1,1)*sum(s1'))';
st=s1'./(((sum(s1))'*ones(1,nt)));

%��ά
% data = s';%��ά
% data=zscore(data);     %���ݵı�׼��
% r=corrcoef(data);      %�������ϵ������r
% %�����������ϵ������������ɷַ�����vec1�ĵ�һ��Ϊr�ĵ�һ���������������ɷֵ�ϵ��
% [vec1,lamda,rate]=pcacov(r);                 %lamdaΪr������ֵ��rateΪ�������ɷֵĹ�����
% f=repmat(sign(sum(vec1)),size(vec1,1),1);    %������vec1ͬά����Ԫ��Ϊ��1�ľ���,repmat���ƺ�ƽ�̾���sign���ź���
% vec2=vec1.*f;             %�޸����������������ţ�ʹ��ÿ�����������ķ�����Ϊ������Ϊ���յ���������
% num = max(find(lamda>0.01)); %numΪѡȡ�����ɷֵĸ���,����ѡȡ����ֵ����1��
% df=data*vec2(:,1:num);    %����������ɷֵĵ÷�
% tf=df*rate(1:num)/100;    %�����ۺϵ÷�
% [stf,ind]=sort(tf,'descend');  %�ѵ÷ְ��մӸߵ��͵Ĵ�������
% stf=stf'; ind=ind';            %stfΪ�÷ִӸߵ�������indΪ��Ӧ���������
% s=vec2(:,1:num)'*s;
% A=s;
% st1=vec2(:,1:num)'*st';
% st=st1';
% c=vec2(:,1:num)'*c;

gk=st*c;   %ע�⣺�˴������ػҶȵķ�����LBP���� wp=(sum(s))';��hd=s'*nc./wp;�����õ����ػҶ�һ��
gk(find(gk<0))=0;
gk(find(gk>1))=1;
gkmax_LBP=max(gk);
iter_num=50; %��������
ev=eig(st*s); %�����nst*ns��ȫ������ֵ������ev����
a=2/max(ev);%������������
%u=1;
I=eye(1648);
%SIE1=[];AE1=[]; xg1=[];RE1=[]; %Ϊ�˻����ռ�ͼ���������������ı仯���߶���ı���
% beta=1;
% zk=gk;
gk_0=gk;
for i=1:iter_num;
%    alpha=(i-1)/(i+beta);
%    xk=zk+a*st*(c-s*zk);%2017����
%    zk=xk+alpha*(xk-xk_0);
%    xk_0=xk;
alpha=(i-1)/(i+100);%Nesterov����landweber
zk=gk+alpha*(gk-gk_0);
gk_1=zk-a*st*(s*zk-c);
gk_0=gk;
gk=gk_1;
   gk(find(gk<0))=0;
   gk(find(gk>1))=1;
end
gkmax=max(gk);
gk=gk./gkmax;

%��ͼ
X=gk;
x=load('C:\Users\����\Desktop\����\moxing\hexin\jiedianchangshu.dat');
x=x(:,3);
x(find(x==1))=0;
x(find(x~=0))=1;%ԭʼ��糣���ֲ�
%a=x;
%save C:\Users\����\Desktop\����\moxingfuxian\hexin\G.mat a
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
    l=round(1+63*X(e));
    co=hdb(l,:);
    %co=gk(e);
    fill (xx,yy,co,'EdgeColor','none');
end
%colormap(hdb)
%colorbar
%xlabel('Landweber,����100������10%))');