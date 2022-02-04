function [decisionclass] = Cal_decision(dataD)
%计算决策类

decisionclass=sparse(bsxfun(@eq,dataD(:,1),rot90(dataD(:,1))));
decisionclass=unique(decisionclass,'rows');
decisionclass=sparse(decisionclass);
clear m dataD
end