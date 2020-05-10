function qiuni =INV_GET(a)
N=length(a);
M=eye(N);
%得到上三角矩?
for i=1:N
max=a(i,i);
A=i;
for j=i+1:N
if(abs(a(j,i))>abs(max))%找最大值
max=a(j,i);
A=j;
end
end
for m=1:N
temp1=a(i,m);%交换最大值值所在的行和当前行
a(i,m)=a(A,m);
a(A,m)=temp1;
temp2=M(i,m);
M(i,m)=M(A,m);
M(A,m)=temp2;
end
for k=i+1:N
jiaquan=a(k,i)/a(i,i);%其他行加权得到上三角
for n=1:N
a(k,n)=a(k,n)-jiaquan*a(i,n);
M(k,n)=M(k,n)-jiaquan*M(i,n);
end
end

end
temp3=a;
%得到单位矩阵
for s=N:-1:1
xishu1 =a(s,s);
for p=s:N
a(p,s)=a(p,s)/xishu1;
end
for q=1:N
M(s,q)=M(s,q)/xishu1;
end
for w=s-1:-1:1
xishu=a(w,s);
a(w,s)=0;
for t=1:N
M(w,t)=M(w,t)-xishu*M(s,t);
end
end
end
temp2=a;
qiuni=M;