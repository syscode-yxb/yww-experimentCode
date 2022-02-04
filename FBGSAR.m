function [overalltime,red ] = Cal_red_app_fgs( data,parameter,threshold)
overall_time_start=tic;
[m,n]=size(data);
[decisionclass] = Cal_decision(data(:,end));
[ relation ] = Cal_condition( data(:,1:end-1),parameter);
[Low] = Cal_low(relation,decisionclass);
rawpos=sum(max(Low))/m; %����Ľ�������ֵ

% [p,~] = size(decisionclass);
%% Լ����������ĳ�ʼ��
red=zeros(1,n-1);%��¼Լ��

k=1;

tmppos=-1000;

%% Լ�����������ӵĹ���
while k<=n-1
    if tmppos>=threshold*rawpos
        break
    else
        tmpSig=-9000.*ones(1,n-1);
        for j=1:n-1
            if  red(1,j)==0
                red(1,j)=1;
                tmpdata=data(:,red==1);
                [ relation ] = Cal_condition( tmpdata,parameter);
                clear tmpdata
                [Low] = Cal_low(relation,decisionclass);
                tmpSig(1,j)=sum(max(Low))/m;
                red(1,j)=0;
            end
        end
%         t = flag(:);
        %tt=mode(t)
        [~,index]=max(tmpSig);
        red(1,index) = 1;
        tmpdata=data(:,red==1);
        [relation] = Cal_condition( tmpdata,parameter);
        clear tmpdata
        [Low] = Cal_low(relation,decisionclass);
        tmppos=sum(max(Low))/m;
        k=k+1;
    end
end
overalltime=toc(overall_time_start);

end

