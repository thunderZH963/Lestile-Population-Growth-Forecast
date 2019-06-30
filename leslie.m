clear
%t = 2010

%各年龄组人口
%来自国家统计局
n_0 = [75532610, 70881549, 74908462, 99889114, 127412518, 101013852, 97138203, 118025959,124753964,105594553, 78753171, 81312474, 58667282, 41113282, 32972397, 23852133, 13373198, 5631928, 1578307, 369979, 35934];
n_women_0 = [47984284, 63403945, 50176814, 47616381,  57634855, 61145286,51818135];
%分年龄生育率
%15-19 20-24 25-29 30-34 35-39 40-44 45-49
%来自国家统计局
b_city = [1.94, 33.43, 71.66, 40.68, 16.70, 7.16, 4.85];
b_town = [4.31, 73.58, 82.82, 41.31, 17.58, 6.85, 4.23];
b_country = [9.38, 96.66, 95.60, 52.48, 20.66, 7.98, 4.75];

%性别比例
%%
c = categorical({'15-19','20-24','25-29','30-34','35-39','240-44','45-49'});
subplot(1,3,1);
bar(c,b_city);
xlabel('年龄（岁）');
ylabel('生育率（%）');
title('2010年城市育龄妇女生育率');
axis square
subplot(1,3,2);
bar(c,b_town);
xlabel('年龄（岁）');
ylabel('生育率（%）');
title('2010年镇育龄妇女生育率');
axis square
subplot(1,3,3);
bar(c,b_country);
xlabel('年龄（岁）');
ylabel('生育率（%）');
title('2010年农村育龄妇女生育率');
axis square
%%
% fid=fopen('women (1).txt','r');
% i=1;
women_city = [];
women_town = [];
women_country = [];
women= [];
filename={'women (1).txt','women (2).txt','women (3).txt'};
for n=1:3
    i=1;
    fid=fopen(filename{n},'r');
    while ~feof(fid)
        if  mod(i,3)==0 && n == 1
            women_city = [women_city;fscanf(fid,'%d',1)];
        elseif  mod(i,3)==0 && n == 2
            women_town = [women_town;fscanf(fid,'%d',1)];
            
        elseif  mod(i,3)==0 && n == 3
            women_country = [women_country;fscanf(fid,'%d',1)];
        else
            fscanf(fid,'%d',1);
        end
        i=i+1;
    end
    fclose(fid);
end
    
%%
women = [women_city, women_town, women_country];
women=[women,sum(women,2)];
women_rate=[];
for i=1:length(women_city)
    for j=1:3
        women_rate(i,j)=women(i,j)/women(i,4);
    end
end
%%
%%出生率加权平均
b_weight = [];
b = [b_city;b_town;b_country];
temp = women_rate * b;
for i = 1:7
    b_weight = [b_weight, temp(i,i)];
end
a = b_weight
b_weight = b_weight/1000;

%%
%%死亡率
d = [5.58, 0.3, 0.3, 0.39, 0.5, 0.61, 0.81, 1.16, 1.76, 2.61, 4.18, 6.19, 10.31, 17.21, 30.64, 49.52, 84.81, 127.43, 190.78, 217.10, 454.35];
d = d /1000;    
s = 1 - d;

%%
%出生人数
new_people = n_women_0 * b_weight';



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    