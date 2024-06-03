clear;
clc;

%% initialisation
L = 500;
T = 100000;

p_total = 0.75;    % total density
p_R = p_total/3;    
p_S = p_total/3;
p_P = p_total/3;
N_R = p_R*L;        % Number of each species
N_S = p_S*L;
N_P = p_P*L;

A = randperm(L);   % random distribution     
A(find(A<=N_R)) = 1;       % 1 denotes species R (rock)      
A(find(N_R+1<=A & A<=N_R+N_S)) = 2;        % 2 denotes species S (scissors)
A(find(N_R+N_S+1<=A & A<=N_R+N_S+N_P)) = 3;  % 3 denotes species P (paper)   1 eats 2, 2 eats 3, 3 eats 1.
A(find(A>N_R+N_S+N_P+1)) = 0;        % 0 indicates a space

spacetime = zeros(T+1,L);     %记录
spacetime(T+1,:) = A;
p1 = 0.0001; p2 = 0.001; p3 = 0.001; % predation rate AB1 BC2 CA3
q1 = 0.1; q2 = 0.1; q3 = 0.1;  % reproduction rate  AO1 BO2 CO3
y1 = 0.1; y2 = 0.1; y3 = 0.1; % mobility rate
alpha1 = p1/(p1+q1+y1); alpha2 = p2/(p2+q2+y2); alpha3 = p3/(p3+q3+y3); % predation probability
beta1 = q1/(p1+q1+y1); beta2 = q2/(p2+q2+y2); beta3 = q3/(p3+q3+y3); % reproduction probability
omega1 = y1/(p1+q1+y1); omega2 = y2/(p2+q2+y2); omega3 = y3/(p3+q3+y3); % mobility probability

%% 循环
for t=0:1:T-1
   for i=1:1:L
       if i<=L-1
           if A(1,i)==1
               if A(1,i+1)==0 
                   a=randsrc(1,1,[1 11 0;beta1 omega1 1-beta1-omega1]);     %x0 繁殖、流动、不动 
                   if  a==11
                       A(1,i:i+1)=[0 1];
                   else 
                       A(1,i+1)=a;
                   end
               elseif A(1,i+1)==1
                   A(1,i+1)=1;
               elseif A(1,i+1)==2     
                   a=randsrc(1,1,[0 1 2;alpha1 omega1 1-alpha1-omega1]); %xy 捕食、流动、不动
                   if a==1   %流动
                       A(1,i:i+1)=[2 1];
                   else
                       A(1,i+1)=a;  
                   end
               else  %A(1,i+1)==3
                   a=randsrc(1,1,[1 3;omega1 1-omega1]); %xy 流动、不动
                   if a==1   %流动
                       A(1,i:i+1)=[3 1];
                   else
                       A(1,i+1)=a;
                   end         
               end
           elseif A(1,i)==2
               if A(1,i+1)==0 
                   a=randsrc(1,1,[2 22 0;beta2 omega2 1-beta2-omega2]);     %20 繁殖、流动、不动 
                   if a==22
                       A(1,i:i+1)=[0 2];
                   else 
                       A(1,i+1)=a;
                   end
               elseif A(1,i+1)==1
                   a=randsrc(1,1,[2 1;omega2 1-omega2]); %21 流动、不动
                   if a==2   %流动
                       A(1,i:i+1)=[1 2];
                   else
                       A(1,i+1)=a;
                   end  
               elseif A(1,i+1)==2     
                   A(1,i+1)=2;
               else %A(1,i+1)==3
                   a=randsrc(1,1,[0 2 3;alpha2 omega2 1-alpha2-omega2]);  %xy 捕食、流动、不动
                   if a==2 %流动
                       A(1,i:i+1)=[3 2];
                   else 
                       A(1,i+1)=a;
                   end         
               end
           elseif A(1,i)==3
               if A(1,i+1)==0 
                   a=randsrc(1,1,[3 33 0;beta3 omega3 1-beta3-omega3]);     %30 繁殖、流动、不动 
                   if a==33
                       A(1,i:i+1)=[0 3];
                   else 
                       A(1,i+1)=a;
                   end
               elseif A(1,i+1)==1
                   a=randsrc(1,1,[0 3 1;alpha3 omega3 1-alpha3-omega3]); %31 捕食、流动、不动
                   if a==3   %流动
                       A(1,i:i+1)=[1 3];
                   else
                       A(1,i+1)=a;
                   end  
               elseif A(1,i+1)==2     
                   a=randsrc(1,1,[3 2;omega3 1-omega3]); %32 流动、不动
                   if a==3   %流动
                       A(1,i:i+1)=[2 3];
                   else
                       A(1,i+1)=a;
                   end
               else %A(1,i+1)==3
                   A(1,i+1)=3;        
               end    
           else %A(1,i)==0
               A(1,i)=0;
           end
           
       else  %i=L时
           if A(1,i)==1
               if A(1,1)==0 
                   a=randsrc(1,1,[1 11 0;beta1 omega1 1-beta1-omega1]);     %x0 繁殖、流动、不动 
                   if a==11
                       A(1,i)=0;   
                       A(1,1)=1;
                   else 
                       A(1,1)=a;
                   end
               elseif A(1,1)==1
                   A(1,1)=1;
               elseif A(1,1)==2     
                   a=randsrc(1,1,[0 1 2;alpha1 omega1 1-alpha1-omega1]); %xy 捕食、流动、不动
                   if a==1   %流动
                       A(1,i)=2;   
                       A(1,1)=1;
                   else
                       A(1,1)=a;  
                   end
               else  %A(1,1)==3
                   a=randsrc(1,1,[1 3;omega1 1-omega1]); %xy 流动、不动
                   if a==1   %流动
                       A(1,i)=3;   
                       A(1,1)=1;
                   else
                       A(1,1)=a;
                   end         
               end
           elseif A(1,i)==2
               if A(1,1)==0 
                   a=randsrc(1,1,[2 22 0;beta2 omega2 1-beta2-omega2]);     %20 繁殖、流动、不动 
                   if a==22
                       A(1,i)=0;   
                       A(1,1)=2;
                   else 
                       A(1,1)=a;
                   end
               elseif A(1,1)==1
                   a=randsrc(1,1,[2 1;omega2 1-omega2]); %21 流动、不动
                   if a==2   %流动
                       A(1,i)=1;   
                       A(1,1)=2;
                   else
                       A(1,1)=a;
                   end  
               elseif A(1,1)==2     
                   A(1,1)=2;
               else %A(1,1)==3
                   a=randsrc(1,1,[0 2 3;alpha2 omega2 1-alpha2-omega2]);  %xy 捕食、流动、不动
                   if a==2 %流动
                       A(1,i)=3;   
                       A(1,1)=2;
                   else 
                       A(1,1)=a;
                   end         
               end
           elseif A(1,i)==3
               if A(1,1)==0 
                   a=randsrc(1,1,[3 33 0;beta3 omega3 1-beta3-omega3]);     %30 繁殖、流动、不动 
                   if a==33
                       A(1,i)=0;   
                       A(1,1)=3;
                   else 
                       A(1,1)=a;
                   end
               elseif A(1,1)==1
                   a=randsrc(1,1,[0 3 1;alpha3 omega3 1-alpha3-omega3]); %31 捕食、流动、不动
                   if a==3   %流动
                       A(1,i)=1;   
                       A(1,1)=3;
                   else
                       A(1,1)=a;
                   end  
               elseif A(1,1)==2     
                   a=randsrc(1,1,[3 2;omega3 1-omega3]); %32 流动、不动
                   if a==3   %流动
                       A(1,i)=2;   
                       A(1,1)=3;
                   else
                       A(1,1)=a;
                   end
               else %A(1,1)==3
                   A(1,1)=3;        
               end    
           else %A(1,i)==0
                A(1,i)=0;
           end
       end
              
   end
   spacetime(T-t,:) = A;
end

%% 画图
N1=zeros(1,T+1);
N2=zeros(1,T+1);
N3=zeros(1,T+1);
N4=zeros(1,T+1);
for i=1:1:T+1
     N1(1,i)=sum(spacetime(T+2-i,:)==1);
     N2(1,i)=sum(spacetime(T+2-i,:)==2);
     N3(1,i)=sum(spacetime(T+2-i,:)==3);
     N4(1,i)=sum(spacetime(T+2-i,:)==0);
end
p1=N1/L;
p2=N2/L;
p3=N3/L;
p4=N4/L;

figure(1)
t=0:1:T;
plot(t,p1,'r',t,p2,'b',t,p3,'g',t,p4,'k','LineWidth',2);   %红1 蓝2 绿3 黑0
hold on;
legend({'\rho_R','\rho_S','\rho_P','\rho_0'},'Location','northeast','FontWeight','bold','FontSize',14,'LineWidth',1.5);
%图例的字体和大小
box on
xlim([0 T]);
ylim([0 1]);
ylabel({'\rho'},'FontWeight','bold','FontSize',20);  %x轴名称及字体和大小
xlabel({'Time'},'FontWeight','bold','FontSize',14);  %y轴名称及字体和大小 
set(gca,'FontWeight','bold','FontSize',14,'LineWidth',1.5);  %坐标轴的字体和大小

figure(2)
clims = [0 3];
imagesc(spacetime,clims);
cc=[0 0 0;1 0 0;0 0 1;0 1 0];     %黑 红蓝绿
colormap(cc);
colorbar;
y = 0.5:10000:T+0.5;
set(gca,'Ytick',y);
% set(gca,'yticklabel',{'1000''800','600','400','200','0'});  %2000
% set(gca,'yticklabel',{'10×10^3','9×10^3','8×10^3','7×10^3','6×10^3','5×10^3','4×10^3','3×10^3','2×10^3','1×10^3','0'});  %10000
% set(gca,'yticklabel',{'5×10^4','4×10^4','3×10^4','2×10^4','1×10^4','0'});  %50000
set(gca,'yticklabel',{'10×10^4','9×10^4','8×10^4','7×10^4','6×10^4','5×10^4','4×10^4','3×10^4','2×10^4','1×10^4','0'});
xlabel({'Space'},'FontWeight','bold','FontSize',14); 
ylabel({'Time'},'FontWeight','bold','FontSize',14);
set(gca,'FontWeight','bold','FontSize',14,'LineWidth',1.5);
