
clc
clear
 load zaosheng1.mat  
%%%%%% 
load y.mat %加载电容值
nc1=y;%(clz-c0')./(c1'-c0'); %%%nc1为未加噪声的电容值
  i=1;
 bc=0;
nc=nc1.*(1+bc*zsh);  %bc为标准差，二师兄的方法
pt=norm(nc-nc1)./norm(nc1);
 while pt<=0.03    %改变此处的数值，即是改变噪声幅度，若是添加8%的噪声，此处应写 ：while pt<=0.08
i=i+1;
j=1+0.01*i;
bc=j*0.01; %%%%标准差方法
nc=nc1.*(1+bc*zsh);  %bc为标准差，二师兄的方法
pt=norm(nc-nc1)./norm(nc1);
 end
j
bc=j*0.01; %%%%标准差方法
nc=nc1.*(1+bc*zsh); %bc为标准差，二师兄的方法，%nc 即为添加噪声后的的电容
pt=norm(nc-nc1)./norm(nc1)
y=nc;
 save y.mat y


% % % % load zaosheng1.mat  
% % %  % load zaosheng12.mat  
% % %  %load zaosheng29.mat     %%%调用均值为0，标准差为1的随机噪声zsh
% % %  load zaosheng31.mat  
% % % %%%%%% 
% % % load qiu2dianrong_1.mat %加载电容值
% % % nc1=(clz-c0')./(c1'-c0'); %%%nc1为未加噪声的电容值
% % %   i=1;
% % %  bc=0;
% % % nc=nc1.*(1+bc*zsh);  %bc为标准差，二师兄的方法
% % % pt=norm(nc-nc1)./norm(nc1);
% % %  while pt<=0.15    %改变此处的数值，即是改变噪声幅度，若是添加8%的噪声，此处应写 ：while pt<=0.08
% % % i=i+1;
% % % j=1+0.01*i;
% % % bc=j*0.01; %%%%标准差方法
% % % nc=nc1.*(1+bc*zsh);  %bc为标准差，二师兄的方法
% % % pt=norm(nc-nc1)./norm(nc1);
% % %  end
% % % j
% % % bc=j*0.01; %%%%标准差方法
% % % nc=nc1.*(1+bc*zsh); %bc为标准差，二师兄的方法，%nc 即为添加噪声后的的电容
% % % pt=norm(nc-nc1)./norm(nc1)
% % % nc_31=nc;
% % % %save zs_guding1.mat nc_1
% % % %save zs_guding12.mat nc_12
% % %  % save zs_guding29.mat nc_29
% % % save zs_guding31.mat nc_31   %%%%nc为含有噪声的电容值


% % % %%%%%雷兢2015年添加噪声的方法，结果表明相同噪声幅度时，雷兢的方法添加的噪声影响小
% % load zaosheng1.mat  
% % load zaosheng12.mat  
%   load zaosheng29.mat  
%  %load zaosheng31.mat  
% %%%%%% 
% load qiu2dianrong_1.mat   %加载电容值
% nc1=(clz-c0')./(c1'-c0');
% norm_zsh=norm(zsh);
% norm_nc1=norm(nc1);
% bc=0.15*norm_nc1/norm_zsh;   %%%%等号右面的系数为添加的噪声幅度，改变此系数即是改变添加的噪声幅度
% nc=nc1+(bc*zsh);  %bc为标准差，雷兢2015年的方法
% pt=norm(nc-nc1)./norm(nc1)   %%%%pt为添加的噪声幅度
% % save zs_guding1.mat nc
% %save zs_guding12.mat nc
%  save zs_guding29.mat nc
% %save zs_guding31.mat nc   %%%%nc为含有噪声的电容值






