function [overalltime,red] = AGAR( data,parameter,threshold)

%�������Դ�

%��������Լ��
overall_time_start=tic;
[m,n]=size(data);
[decisionclass] = Cal_decision(data(:,end));
[ relation ] = Cal_condition(data(:,1:end-1),parameter);
[Low]= Cal_low(relation,decisionclass);
rawpos= sum(max(Low))/m;

for i=1:3
    label(:,i)=litekmeans(data(:,1:end-1)', floor((n-1)/3));
end
label=mode(label,2);

%% Լ����������ĳ�ʼ��
red=zeros(1,n-1);%��¼Լ��
k=1;
tmppos=-1000;

%% Լ�����������ӵĹ���
% tmp_start=tic;
tmplabel=label;
while k<=n-1
    if tmppos>=threshold*rawpos
        break
    else
        tmpSig=-9000.*ones(1,n-1);
        if sum(tmplabel)==0
            tmplabel=label;
            tmplabel(red==1)=0;
        end
        for j=1:n-1
            if  red(1,j)==0 & tmplabel(j,1)~=0
                red(1,j)=1;
                tmpdata=data(:,red==1);
                [ relation ] = Cal_condition( tmpdata,parameter );
                clear tmpdata
                [Low] = Cal_low(relation,decisionclass);
                tmpSig(1,j)=sum(max(Low))/m;
                red(1,j)=0;
            end
        end
        [~,x]=max(tmpSig);
        red(1,x)=1;
        cc=find(tmplabel==tmplabel(x));
        tmplabel(cc,1)=0;
        k=k+1;
        tmpdata=data(:,red==1);
        [ relation ] = Cal_condition( tmpdata,parameter );
        clear tmpdata
        [Low] = Cal_low(relation,decisionclass);
        tmppos=sum(max(Low))/m;
    end
end
% toc(tmp_start)
overalltime=toc(overall_time_start);

end

