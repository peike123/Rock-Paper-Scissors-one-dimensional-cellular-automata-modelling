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

spacetime = zeros(T+1,L);     %record spatio-temporal matrix
spacetime(T+1,:) = A;
p = 0.01;  % predation rate
q = 1;  % reproduction rate
y = 1;  % mobility rate
alpha = p/(p+q+y); % predation probability
beta = q/(p+q+y); % reproduction probability
omega = y/(p+q+y); % mobility probability

%% 循环
for t=0:1:T-1
   for i=1:1:L
       if i<=L-1
           if A(1,i)==1
               if A(1,i+1)==0 
                   a=randsrc(1,1,[1 11 0;beta omega 1-beta-omega]);     %x0 繁殖、流动、不动 
                   if a==1
                       A(1,i+1)=1;
                   elseif a==11
                       A(1,i:i+1)=[0 1];
                   else 
                       A(1,i+1)=0;
                   end
               elseif A(1,i+1)==1
                   A(1,i+1)=1;
               elseif A(1,i+1)==2     
                   a=randsrc(1,1,[0 1 2;alpha omega 1-alpha-omega]); %12 
                   if a==1   
                       A(1,i:i+1)=[2 1];
                   else
                       A(1,i+1)=a;  
                   end
               else  %A(1,i+1)==3
                   a=randsrc(1,1,[1 3;omega 1-omega]); %13
                   if a==1  
                       A(1,i:i+1)=[3 1];
                   else
                       A(1,i+1)=a;
                   end         
               end
           elseif A(1,i)==2
               if A(1,i+1)==0 
                   a=randsrc(1,1,[2 22 0;beta omega 1-beta-omega]);     %20 
                   if a==2
                       A(1,i+1)=2;
                   elseif a==22
                       A(1,i:i+1)=[0 2];
                   else 
                       A(1,i+1)=0;
                   end
               elseif A(1,i+1)==1
                   a=randsrc(1,1,[2 1;omega 1-omega]); %21 
                   if a==2   
                       A(1,i:i+1)=[1 2];
                   else
                       A(1,i+1)=a;
                   end  
               elseif A(1,i+1)==2     
                   A(1,i+1)=2;
               else %A(1,i+1)==3
                   a=randsrc(1,1,[0 2 3;alpha omega 1-alpha-omega]);  %23
                   if a==2 
                       A(1,i:i+1)=[3 2];
                   else 
                       A(1,i+1)=a;
                   end         
               end
           elseif A(1,i)==3
               if A(1,i+1)==0 
                   a=randsrc(1,1,[3 33 0;beta omega 1-beta-omega]);     %30 
                   if a==3
                       A(1,i+1)=3;
                   elseif a==33
                       A(1,i:i+1)=[0 3];
                   else 
                       A(1,i+1)=0;
                   end
               elseif A(1,i+1)==1
                   a=randsrc(1,1,[0 3 1;alpha omega 1-alpha-omega]); %31 
                   if a==3  
                       A(1,i:i+1)=[1 3];
                   else
                       A(1,i+1)=a;
                   end  
               elseif A(1,i+1)==2     
                   a=randsrc(1,1,[3 2;omega 1-omega]); %32
                   if a==3   
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
           
   
       else  %i=L
           if A(1,i)==1
               if A(1,1)==0 
                   a=randsrc(1,1,[1 11 0;beta omega 1-beta-omega]);     %10
                   if a==1
                       A(1,1)=1;
                   elseif a==11
                       A(1,i)=0;   
                       A(1,1)=1;
                   else 
                       A(1,1)=0;
                   end
               elseif A(1,1)==1
                   A(1,1)=1;
               elseif A(1,1)==2     
                   a=randsrc(1,1,[0 1 2;alpha omega 1-alpha-omega]); %12
                   if a==1   
                       A(1,i)=2;   
                       A(1,1)=1;
                   else
                       A(1,1)=a;  
                   end
               else  %A(1,1)==3
                   a=randsrc(1,1,[1 3;omega 1-omega]); %13
                   if a==1   
                       A(1,i)=3;   
                       A(1,1)=1;
                   else
                       A(1,1)=a;
                   end         
               end
           elseif A(1,i)==2
               if A(1,1)==0 
                   a=randsrc(1,1,[2 22 0;beta omega 1-beta-omega]);     %20 
                   if a==2
                       A(1,1)=2;
                   elseif a==22
                       A(1,i)=0;   
                       A(1,1)=2;
                   else 
                       A(1,1)=0;
                   end
               elseif A(1,1)==1
                   a=randsrc(1,1,[2 1;omega 1-omega]); %21 
                   if a==2   
                       A(1,i)=1;   
                       A(1,1)=2;
                   else
                       A(1,1)=a;
                   end  
               elseif A(1,1)==2     
                   A(1,1)=2;
               else %A(1,1)==3
                   a=randsrc(1,1,[0 2 3;alpha omega 1-alpha-omega]);  %23 
                   if a==2
                       A(1,i)=3;   
                       A(1,1)=2;
                   else 
                       A(1,1)=a;
                   end         
               end
           elseif A(1,i)==3
               if A(1,1)==0 
                   a=randsrc(1,1,[3 33 0;beta omega 1-beta-omega]);     %30 
                   if a==3
                       A(1,1)=3;
                   elseif a==33
                       A(1,i)=0;   
                       A(1,1)=3;
                   else 
                       A(1,1)=0;
                   end
               elseif A(1,1)==1
                   a=randsrc(1,1,[0 3 1;alpha omega 1-alpha-omega]); %31
                   if a==3 
                       A(1,i)=1;   
                       A(1,1)=3;
                   else
                       A(1,1)=a;
                   end  
               elseif A(1,1)==2     
                   a=randsrc(1,1,[3 2;omega 1-omega]); %32 
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

%% picture
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
plot(t,p1,'r',t,p2,'b',t,p3,'g',t,p4,'k','LineWidth',2);
hold on;
legend({'\rho_R','\rho_S','\rho_P','\rho_0'},'Location','northeast','FontWeight','bold','FontSize',14,'LineWidth',1.5);
%The typeface and size of the legend
box on
xlim([0 T]);
ylim([0 1]);
ylabel({'\rho'},'FontWeight','bold','FontSize',20);  %y
xlabel({'Time'},'FontWeight','bold','FontSize',14);  %x
set(gca,'FontWeight','bold','FontSize',14,'LineWidth',1.5);  %Axis fonts and sizes

figure(2)
clims = [0 3];
imagesc(spacetime,clims);
cc=[0 0 0;1 0 0;0 0 1;0 1 0];     %Black; red, blue and green.
colormap(cc);
% colorbar;
y = 0.5:20000:T+0.5;
set(gca,'Ytick',y);
% set(gca,'yticklabel',{'10×10^3','8×10^3','6×10^3','4×10^3','2×10^3','0'}); %10000
% set(gca,'yticklabel',{'15×10^3','12×10^3','9×10^3','6×10^3','3×10^3','0'}); %15000
% set(gca,'yticklabel',{'5×10^4','4×10^4','3×10^4','2×10^4','1×10^4','0'}); %50000
set(gca,'yticklabel',{'10×10^4','9×10^4','8×10^4','7×10^4','6×10^4','5×10^4','4×10^4','3×10^4','2×10^4','1×10^4','0'}); %100000
xlabel({'Space'},'FontWeight','bold','FontSize',14); 
ylabel({'Time'},'FontWeight','bold','FontSize',14);
set(gca,'FontWeight','bold','FontSize',14,'LineWidth',1.5);

