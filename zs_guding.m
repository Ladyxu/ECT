
clc
clear
 load zaosheng1.mat  
%%%%%% 
load y.mat %���ص���ֵ
nc1=y;%(clz-c0')./(c1'-c0'); %%%nc1Ϊδ�������ĵ���ֵ
  i=1;
 bc=0;
nc=nc1.*(1+bc*zsh);  %bcΪ��׼���ʦ�ֵķ���
pt=norm(nc-nc1)./norm(nc1);
 while pt<=0.03    %�ı�˴�����ֵ�����Ǹı��������ȣ��������8%���������˴�Ӧд ��while pt<=0.08
i=i+1;
j=1+0.01*i;
bc=j*0.01; %%%%��׼���
nc=nc1.*(1+bc*zsh);  %bcΪ��׼���ʦ�ֵķ���
pt=norm(nc-nc1)./norm(nc1);
 end
j
bc=j*0.01; %%%%��׼���
nc=nc1.*(1+bc*zsh); %bcΪ��׼���ʦ�ֵķ�����%nc ��Ϊ���������ĵĵ���
pt=norm(nc-nc1)./norm(nc1)
y=nc;
 save y.mat y


% % % % load zaosheng1.mat  
% % %  % load zaosheng12.mat  
% % %  %load zaosheng29.mat     %%%���þ�ֵΪ0����׼��Ϊ1���������zsh
% % %  load zaosheng31.mat  
% % % %%%%%% 
% % % load qiu2dianrong_1.mat %���ص���ֵ
% % % nc1=(clz-c0')./(c1'-c0'); %%%nc1Ϊδ�������ĵ���ֵ
% % %   i=1;
% % %  bc=0;
% % % nc=nc1.*(1+bc*zsh);  %bcΪ��׼���ʦ�ֵķ���
% % % pt=norm(nc-nc1)./norm(nc1);
% % %  while pt<=0.15    %�ı�˴�����ֵ�����Ǹı��������ȣ��������8%���������˴�Ӧд ��while pt<=0.08
% % % i=i+1;
% % % j=1+0.01*i;
% % % bc=j*0.01; %%%%��׼���
% % % nc=nc1.*(1+bc*zsh);  %bcΪ��׼���ʦ�ֵķ���
% % % pt=norm(nc-nc1)./norm(nc1);
% % %  end
% % % j
% % % bc=j*0.01; %%%%��׼���
% % % nc=nc1.*(1+bc*zsh); %bcΪ��׼���ʦ�ֵķ�����%nc ��Ϊ���������ĵĵ���
% % % pt=norm(nc-nc1)./norm(nc1)
% % % nc_31=nc;
% % % %save zs_guding1.mat nc_1
% % % %save zs_guding12.mat nc_12
% % %  % save zs_guding29.mat nc_29
% % % save zs_guding31.mat nc_31   %%%%ncΪ���������ĵ���ֵ


% % % %%%%%�׾�2015����������ķ��������������ͬ��������ʱ���׾��ķ�����ӵ�����Ӱ��С
% % load zaosheng1.mat  
% % load zaosheng12.mat  
%   load zaosheng29.mat  
%  %load zaosheng31.mat  
% %%%%%% 
% load qiu2dianrong_1.mat   %���ص���ֵ
% nc1=(clz-c0')./(c1'-c0');
% norm_zsh=norm(zsh);
% norm_nc1=norm(nc1);
% bc=0.15*norm_nc1/norm_zsh;   %%%%�Ⱥ������ϵ��Ϊ��ӵ��������ȣ��ı��ϵ�����Ǹı���ӵ���������
% nc=nc1+(bc*zsh);  %bcΪ��׼��׾�2015��ķ���
% pt=norm(nc-nc1)./norm(nc1)   %%%%ptΪ��ӵ���������
% % save zs_guding1.mat nc
% %save zs_guding12.mat nc
%  save zs_guding29.mat nc
% %save zs_guding31.mat nc   %%%%ncΪ���������ĵ���ֵ






