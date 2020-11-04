function I=PVmod(Volt,Irrad,Temp)
% I = current;
% Input = voltage, irradiance and temperatur.

Temp = Temp+273; 
k = 1.381e-23;
q = 1.6e-19;
V_g = 1.12;
n = 72;
V_oc = 44.8;
I_sc1 = 5.5;
T_1 = 25+273;
S_1 = 1;
K_o = 6.5e-4;
Gamma = 1.6;
% Diode Quality factor
R_sh = 800;
R_s = 0.005;

I_L = I_sc1*Irrad/S_1*(1+K_o*(Temp-T_1));
I_L1 = I_L/(exp((q*V_oc/n)/(Gamma*k*Temp))-1);
I_ST = I_L1*((Temp)/(T_1))^(3/Gamma).*exp(-q*V_g*(1/Temp-1/T_1)/Gamma/k); 

A = length(Volt);

for i = 1:A
I_1(1)= 0;
for j = 1:10
f = I_L-I_1(j)-I_ST*(exp(q*(Volt(i)/n+I_1(j)*R_s)/(Gamma*k*Temp))-1)
-(Volt(i)/n+I_1(j)*R_s)/R_sh;
diff = -1-(I_ST*exp(q*((Volt(i)/n)+I_1(j)*R_s)/(Gamma*k*Temp))*q*R_s/(Gamma*k*Temp))-R_s/R_sh;
I_1(j+1) = I_1(j)-f/diff;
if abs(I_1(j+1)) < 0.05
break;
end
end
I(i)=I_1(j+1);
end


end






