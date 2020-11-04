Lambda = 139.839478; 
%longitude of Tokyo
Phi = 35.652832;  
%latitude of Tokyo
TZ = 9;  
%Timezone of Tokyo
DOY = 31+28+31+30+31+24;  
%the ordinal of the day: 24.06.2019
TD = 4:18;  
%Time duration is  4 a.m. to 18 p.m. 
[Am,Ys,SAz] = Sundata(Lambda,Phi,TZ,DOY,TD);
figure(1)
plot(SAz,Ys,'-or')
hold on
xlabel('Azimuth in degrees SAz')
ylabel('Amplitude Position in degrees Ys')
title('Tokyo (139.839478, 35.652832) on 24.06.2019')
grid on;
figure(2)
plot(TD,Am,'-or');
hold on
xlabel('Azimuth in degrees SAz')
ylabel('Air Mass Am')
title('Air Mass factor for Tokyo for 4 a.m. to 18 p.m. on the 24.06.2019')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Volt = 0:0.01:44.8;
Irrad = 1;
Temp = 25; 
I = PVmod(Volt,Irrad,Temp);
P = Volt.*I;
figure(3)
[AX]=plotyy(Volt,I,Volt,P);
xlim(AX(1),[0,55]);xlim(AX(2),[0,55]);
set(AX(1),'yTick',[0:6]);
set(gca,'box','off','Ytick',[]);
set(AX(1),'ylim',[0,6],'yTick',[0,1,2,3,4,5,6]); 
set(AX(2),'ylim',[0,270],'yTick',[0,46,92,138,184,230,276]) ; 
set(get(AX(1),'Ylabel'),'String','module current [A]');
set(get(AX(2),'Ylabel'),'String','module power [W]');
xlabel('module voltage [V]');
grid;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Volt = 0:0.01:44.8;
Irrad=1;
%kW
Temp = 25; 
I = PVmod(Volt,Irrad,Temp);
P = Volt.*I;
L = 1621/1000;
W = 936/1000;
%meter
A = L*W;
[PMAX,PLACE] = max(P);
Nmax = PMAX/(A*Irrad*1000)
%fill factor  
[V_oc,VPLACE] = max(Volt);
[I_oc,IPLACE] = max(I);
FF = PMAX/(V_oc*I_oc)
%efficiency
 
Irrad1=300;
Temp1=0;
Rm1=RMPP(Irrad1,Temp1)
 
Irrad2=300;
Temp2=25;
Rm2=RMPP(Irrad2,Temp2)
 
Irrad3=900;
Temp3=0;
Rm3=RMPP(Irrad3,Temp3)
 
Irrad4=900;
Temp4=25;
Rm4=RMPP(Irrad4,Temp4)
 
Irrad5=1200;
Temp5=0;
Rm5=RMPP(Irrad5,Temp5)
 
Irrad6=1200;
Temp6=25;
Rm6=RMPP(Irrad6,Temp6)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Volt = 0:0.01:44.8;
Irrad = 1;
%kW
Temp = 25; 
I = PVmod(Volt,Irrad,Temp);
P = Volt.*I;

R1 = 0;
PLoss1 = PPloss(Irrad,Temp,R1)
I_1 = Volt./R1;
P1 = Volt.*I_1;

R2 = 5;
PLoss2 = PPloss(Irrad,Temp,R2)
I_2 = Volt./R2;
P2 = Volt.*I_2;

R3 = 9;
PLoss3 = PPloss(Irrad,Temp,R3)
I_3 = Volt./R3;
P3 = Volt.*I_3;

R4 = 27;
PLoss4 = PPloss(Irrad,Temp,R4)
I_4 = Volt./R4;
P4 = Volt.*I_4;

R5 = 98;
PLoss5 = PPloss(Irrad,Temp,R5)
I_5 = Volt./R5;
P5 = Volt.*I_5;

figure(4);
plot( Volt,I,'r',Volt,I_1,'g',Volt,I_2,'b',Volt,I_3,'m',Volt,I_4,'c',Volt,I_5,'k');
legend('STC','R=0','R=5','R=9','R=27','R=98');
axis([0 50 0 6]);
xlabel('module voltage [V]');ylabel('module current [A]');
hold on;
grid;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C=[0.3 0.6 1.0];
Irrad = 1;
Temp = 25;
Vout = 35;
 
Vold1(1) = 0;
Vcur1(1) = 1;

for i = 1:4*10^5
if (i-1)/1000 == fix((i-1)/1000)
Vnew1(i) = AHClimb(Irrad, Temp, Vold1(i), Vcur1(i), C(1));
D1(i) = Vout/(Vnew1(i)+Vout);
Vcur1(i+1) = Vnew1(i);
Vold1(i+1) = Vcur1(i);
else
Vnew1(i) = Vnew1(i-1);
D1(i) = D1(i-1);
Vcur1(i+1) = Vcur1(i);
Vold1(i+1) = Vold1(i);
end
end
 
Vold2(1) = 0;
Vcur2(1) = 1;

for i=1:4*10^5
if (i-1)/1000 == fix((i-1)/1000)
Vnew2(i) = AHClimb(Irrad, Temp, Vold2(i), Vcur2(i), C(2));
D2(i) = Vout/(Vnew2(i)+Vout);
Vcur2(i+1) = Vnew2(i);
Vold2(i+1) = Vcur2(i);
else
Vnew2(i) = Vnew2(i-1); 
D2(i) = D2(i-1);
Vcur2(i+1) = Vcur2(i);
Vold2(i+1) = Vold2(i);
end
end
 
Vold3(1) = 0;
Vcur3(1) = 1;
for i = 1:4*10^5
if (i-1)/1000 == fix((i-1)/1000)
Vnew3(i) = AHClimb(Irrad, Temp, Vold3(i), Vcur3(i), C(3));
D3(i) = Vout/(Vnew3(i)+Vout);
Vcur3(i+1) = Vnew3(i);
Vold3(i+1) = Vcur3(i);
else
Vnew3(i) = Vnew3(i-1); 
D3(i) = D3(i-1);
Vcur3(i+1) = Vcur3(i);
Vold3(i+1) = Vold3(i);
end
end

figure(5);
plot(1:4*10^5, Vnew1,'r',1:4*10^5,Vnew2,'g',1:4*10^5,Vnew3,'b');
legend('C=0.3','C=0.6','C=1.0');
hold on; grid;
xlabel('Time steps / s');
ylabel('Module operating voltage [V]');
 
figure(6);
plot(1:4*10^5,D1,'c',1:4*10^5,D2,'m',1:4*10^5,D3,'k');
legend('C=0.3','C=0.6','C=1.0');
hold on;grid;
xlabel('Time steps / s');
ylabel('Duty cycle');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vold1(1) = 0;
dV1 = 1;
%  step for voltage change of 1 volt
Vcur1(1) = Vold1(1)+dV1;
Vout = 35;
for i = 1:4*10^5
if (i-1)/1000 == fix((i-1)/1000)
Vnew1(i) = HClimb(1, 25, Vold1(i), Vcur1(i), dV1);
D1(i) = Vout/(Vnew1(i)+Vout);
Vcur1(i+1) = Vnew1(i);
Vold1(i+1) = Vcur1(i);
 
else
 Vnew1(i) = Vnew1(i-1);
D1(i) = D1(i-1);
Vcur1(i+1) = Vcur1(i);
Vold1(i+1) = Vold1(i);
end
 
end

Vold2(1) = 0;
dV2 = 0.3;
%  step for voltage change of 0.3 volt
Vcur2(1) = Vold2(1)+dV2;
Vnew2 = [];
D2 = [];
Vnew2(1) = 0;
%Vout=35;
for i = 1:4*10^5
if (i-1)/1000 == fix((i-1)/1000)
Vnew2(i) = HClimb(1, 25, Vold2(i), Vcur2(i), dV2);
D2(i) = Vout/(Vnew2(i)+Vout);
Vcur2(i+1) = Vnew2(i);
Vold2(i+1) = Vcur2(i);
 
else
 Vnew2(i) = Vnew2(i-1);
D2(i) = D2(i-1);
Vcur2(i+1) = Vcur2(i);
Vold2(i+1) = Vold2(i);
end
 
end
figure(7);
plot(1:4*10^5,Vnew1,'b',1:4*10^5,Vnew2,'r');
legend('Vstep=1 Volt','Vstep=0.3 Volt');
hold on;grid;
xlabel('Time steps / s');
ylabel('Module operating voltage [V]');
figure(8);
plot(1:4*10^5,D1,'g',1:4*10^5,D2,'c');
legend('Vstep=1 Volt','Vstep=0.3 Volt');
hold on;grid;
xlabel('Time steps / s');
ylabel('Duty cycle');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vold(1) = 0;
dV = 1;
%  step for voltage change of 1 volt
Vcur(1) = Vold(1)+dV;
 
Vnew = [];
D = [];
Vnew(1) = 0;
Vout = 35;
 
 
for i = 1:4*10^5
if (i-1)/1000 == fix((i-1)/1000)
Vnew(i) = HClimb(1, 25, Vold(i), Vcur(i), dV);
D(i) = Vout/(Vnew(i)+Vout);
Vcur(i+1) = Vnew(i);
Vold(i+1) = Vcur(i);
 
else
 Vnew(i) = Vnew(i-1);
D(i) = D(i-1);
Vcur(i+1) = Vcur(i);
Vold(i+1) = Vold(i);
end
 
end
figure(9)
plot(1:4*10^5,Vnew,'m');
hold on; grid;
xlabel('Time steps / s');
ylabel('Module operating voltage [V]');
 
figure(10);
plot(1:4*10^5,D,'c');
hold on; grid;
xlabel('Time steps / s');
ylabel('Duty cycle');