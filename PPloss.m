function PLoss=PPloss(Irrad,Temp,R)
Volt = 0:0.01:44.8;
I = PVmod(Volt,Irrad,Temp);
P = Volt.*I;
 
[PMAX,PLACE] = max(P);
I_1 = Volt./R;
I_2 = abs(I-I_1);
[MIN,IPLACE] = min(I_2);
 
II = I(IPLACE);
VV = Volt(IPLACE);
PP = VV*II;
PLoss = 1-PP/PMAX;
end
