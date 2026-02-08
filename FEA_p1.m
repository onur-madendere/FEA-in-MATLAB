%{
%2 elemanli SEY
syms x
%u= (x>=0);
%v=u(x-a)-u(x-b);

phi1=(1-2*x)*(heaviside(x)-heaviside(x-0.5));
phi2=2*x*(heaviside(x)-heaviside(x-0.5))+(2-2*x)*(heaviside(x-0.5)-heaviside(x-1));
phi3=(2*x-1)*(heaviside(x-0.5)-heaviside(x-1));
phi={phi1,phi2,phi3};

dphi1=diff(phi1);
dphi2=diff(phi2);
dphi3=diff(phi3);
dphi={dphi1,dphi2,dphi3};

%phi{1:3}=matlabFunction(phi{1:3});
%dphi{1:3}=matlabFunction(dphi{1:3});

K=zeros(3,3);


for i=1:3
    for j=1:3
        K(i,j)=int(phi{i}*phi{j}+dphi{i}*dphi{j}, 0, 1);
    end
end

x1=linspace(0,1,51);

u=@(x) x-sinh(x)/sinh(1);
%elle cozulen problemden uh(x)=3/52*phi2 bulundu
u1=u(x1);
numphi=matlabFunction(dphi2);
uh1=3/52*numphi(x1);


plot(x1,u1,'b-', x1, uh1, 'r-');
%}

u=@(x) x-sinh(x)/sinh(1);
uh1=@(x) 3/26*(x.*(x>=0 & x<0.5)+(1-x).*(x>=0.5 & x<=1));
uh2=@(x) 0.0448*3*x.*(x>=0 & x<1/3) + ...
    (0.0448*(-3*x+2)+0.0569*(3*x-1)).*(x>=1/3 & x<2/3) + ...
    0.0569*(-3*x+3).*(x>=2/3 & x<=1);

uh3=@(x) 0.1412*x.*(x>=0 & x<0.25) +...
    (0.0864*x+0.0137).*(x>=0.25 & x<0.5)+...
    (-0.0256*x+0.0697).*(x>=0.5 & x<0.75)+...
    (-0.202*x+0.202).*(x>=0.75 & x<=1);


x=linspace(0,1,101);

plot(x,u(x), 'b-', x, uh1(x), 'r-', x, uh2(x), 'g-', x,uh3(x));
