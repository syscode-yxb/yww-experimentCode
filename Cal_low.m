function [Low] = Cal_low(Fuzzymatrix,Decisionclass)
%¼ÆËãÏÂ½üËÆ

%[~,n]=size(Fuzzymatrix);
[D,~]=size(Decisionclass);


for d=1:D  

         tmp=bsxfun(@min,Fuzzymatrix,Decisionclass(d,:));%min(Fuzzymatrix,repmat(Decisionclass(d,:),n,1));
         
         Low(d,:)=(sum(tmp,2)==sum(Fuzzymatrix,2))';
         
%          tmp=tmp==Fuzzymatrix;    
%          Low(d,:)=min(tmp,[],2);
%          clear tmp
%          Low(d,:)=sparse(Low(d,:));

end
% Low=full(Low);
end

