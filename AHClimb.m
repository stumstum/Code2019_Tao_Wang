function Vnew=AHClimb(Irrad,Temp,Vold,Vcur,C)
Iold = PVmod(Vold,Irrad,Temp);
Pold = Vold.*Iold;
Icur = PVmod(Vcur,Irrad,Temp);
Pcur = Vcur.*Icur;
 
if Vcur-Vold == 0
dV = 0;
else
dV = C*(Pcur-Pold)/(Vcur-Vold);
end
Vnew = Vcur+dV;
end
