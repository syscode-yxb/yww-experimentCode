function [decisionclass] = Cal_decision(dataD)
%���������

decisionclass=sparse(bsxfun(@eq,dataD(:,1),rot90(dataD(:,1))));
decisionclass=unique(decisionclass,'rows');
decisionclass=sparse(decisionclass);
clear m dataD
end