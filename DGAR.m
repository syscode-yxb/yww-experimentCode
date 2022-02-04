function [overtime,red_app]=DGAR(data,R,threshold)
%DGAR
start=tic;
AT=data(:,1:end-1);
[M,N]=size(AT);
[decisionclass] = Cal_decision(data(:,end));
[radius]=cal_find_radius(AT,R);
num_radius=size(radius,2);

tmpdata=AT;
[ relation ] = Cal_condition(tmpdata,R);
clear tmpdata

AT_app=sum(max(Cal_low(relation,decisionclass)))/M;
current_app=-1;
red_app=zeros(1,N);
k=1;
while k<=N
    if current_app>=AT_app*threshold
        break;
    else
        tmp_red_app=zeros(num_radius,N);
        for i=1:num_radius
            app=(-1)*ones(1,N);
            for n=1:N
                if red_app(1,n)==0
                    red_app(1,n)=1;
                    tmpdata=data(:,red_app==1);
                    [ relation ] = Cal_condition(tmpdata,radius(1,i));
                    clear tmpdata
                    app(1,n)=sum(max(Cal_low(relation,decisionclass)))/M;
                    red_app(1,n)=0;
                end
            end
            [~,index]=max(app);
            tmp_red_app(i,index)=1;
        end
        tmp_red_app=sum(tmp_red_app);
        [~,index]=max(tmp_red_app);
        red_app(1,index)=1;
        
        tmpdata=data(:,red_app==1);
        [ relation ] = Cal_condition(tmpdata,R);
        clear tmpdata
        
        current_app=sum(max(Cal_low(relation,decisionclass)))/M;
        k=k+1;
    end
end
% ensemble_red_app=red_app;
overtime=toc(start);
end
