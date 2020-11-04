function Rm=RMPP(Irrad,Temp)
Volt = 0:0.01:44.8;
Irrad = Irrad/1000;
%W to kW
I = PVmod(Volt,Irrad,Temp);
P = Volt.*I;
[PMAX,PLACE] = max(P);
V_m = Volt(PLACE);
I_m = I(PLACE);
Rm = V_m/I_m;
end