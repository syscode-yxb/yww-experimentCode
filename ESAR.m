function [overalltime,red ] = Cal_red_app_es( data,parameter,threshold)
%��ͳ����ѡ��
overall_time_start=tic;
[m,n]=size(data);
[decisionclass] = Cal_decision(data(:,end));
[ relation ] = Cal_condition( data(:,1:end-1),parameter);
[Low] = Cal_low(relation,decisionclass);
rawpos=sum(max(Low))/m; %����Ľ�������ֵ

%% ��data����ֳ����
nump=size(decisionclass,1);
indices=decisionclass;

%[p,~] = size(decisionclass);
%% Լ����������ĳ�ʼ��
red=zeros(1,n-1);%��¼Լ��

k=1;

tmppos=-1000;

%% Լ�����������ӵĹ���
while k<=n-1
    if tmppos>=threshold*rawpos
        break
    else
        u =1;     
        
        tmpSig=-1000*ones(nump,n-1);
        for j=1:n-1
            if  red(1,j)==0
                red(1,j)=1;
                tmpdata=data(:,red==1);
                [ relation ] = Cal_condition(tmpdata,parameter);
                clear tmpdata
                [Low] = Cal_low(relation,decisionclass);
                 for i = 1:nump
                    tmpSig(i,j)=sum(max(Low(:,indices(i,:))))/sum(indices(i,:));
                 end
                red(1,j)=0;
            end
        end
        [~,x] = sort(tmpSig,2,'descend');
        tmpx=x(:,1:u);
          
        t = tmpx(:);
        red(1,mode(t)) = 1;
        tmpdata=data(:,red==1);
        [relation] = Cal_condition( tmpdata,parameter);
        clear tmpdata tmpx t x
        [Low] = Cal_low(relation,decisionclass);
        tmppos=sum(max(Low))/m;
        k=k+1;
    end
end
overalltime=toc(overall_time_start);

end

