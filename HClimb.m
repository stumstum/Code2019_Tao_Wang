function Vnew=HClimb(Irrad,Temp,Vold,Vcur,dV)
% dV = voltage step
Iold = PVmod(Vold,Irrad,Temp);
Pold = Vold.*Iold;
Icur = PVmod(Vcur,Irrad,Temp);
Pcur = Vcur.*Icur;
if (Vcur>Vold)&&(Pcur>Pold)
Vnew = Vcur+dV;
else if (Vcur>Vold)&&(Pcur<Pold)
Vnew = Vcur-dV;
else if (Vcur<Vold)&&(Pcur>Pold)
Vnew = Vcur-dV;
else
Vnew = Vcur+dV;
end
end
end