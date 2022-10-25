clear
clc
close all

lmd=load('C:\Users\SUT\Desktop\00\jdcs.dat');
sss=[];
ss=[];%坐标文件

for i=1:size(lmd,1)
    if  sqrt(lmd(i,1)^2+lmd(i,2)^2)<=45
        sss=[sss;lmd(i,:)];
    end

 end

ss=sss(:,1:2);%坐标文件


    
save C:\Users\SUT\Desktop\00\xy.txt -ascii ss %保存设定的坐标