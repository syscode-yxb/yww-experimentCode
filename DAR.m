function [ overalltime, red ] = DAR( data, parameter, threshold )
%计算不相似度
overall_time_start=tic;
[m,n]=size(data);
relation = cell(1,n-1);
for i = 1:n-1
    relation{1, i} = Cal_condition(data(:,i), parameter);
end

%% 产生差异性矩阵
time1 = tic;
similarity = zeros(n-1, n-1);
for i = 1:n-2
    for j = i+1:n-1
        similarity(i, j) = sum(sum(min(relation{1, i}, relation{1, j}), 2))/(m^2);
    end
end
similarity = similarity + similarity';
similarity(1:n:end) = 1;
time = toc(time1);


[decisionclass] = Cal_decision(data(:,end));
[ relation ] = Cal_condition( data(:,1:end-1),parameter);
[Low] = Cal_low(relation,decisionclass);
rawpos=sum(max(Low))/m;

%% 约简及属性排序的初始化
red=zeros(1,n-1);%记录约简

k=1;

s=1;%选取不相似度属性个数

tmppos=-1000;

%% 约简中属性增加的过程
while k<=n-1
    if tmppos>=threshold*rawpos
        break
    else
    tmpSig=-9000.*ones(1,n-1);
    for j = 1:n-1 
        if  red(1,j)==0
            tmp = similarity(j,:);
            [~, index] = sort(tmp);
            tmpindex = index(1, s);
            T(1, j) = tmpindex;
            new_index = [j tmpindex];
            red(1, new_index) = 1;
            tmpdata=data(:,red==1); 
            [ relation ] = Cal_condition( tmpdata,parameter);
            clear tmpdata
            [Low] = Cal_low(relation,decisionclass);
            tmpSig(1,j)=sum(max(Low))/m;
            red(1,new_index)=0;
        end  
    end
        [~,x]=max(tmpSig);
        new_index = [x T(1,x)];
        similarity(:,new_index) = 1;
        red(1,new_index)=1; 
        tmpdata=data(:,red==1); 
        [ relation ] = Cal_condition( tmpdata,parameter);
        clear tmpdata
        [Low] = Cal_low(relation,decisionclass);
        tmppos=sum(max(Low))/m;
        k=k+1; 
    end
end
overalltime=toc(overall_time_start)-time ;

end

