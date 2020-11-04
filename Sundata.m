function [Am,Ys,SAz] = Sundata(Lambda,Phi,TZ,DOY,TD)
% Am = Air Masse
% Ys = Sun Elevation
% SAz = Sun Azimuth
% Lambda = Longitude
% Phi = Latitude
% TZ = Time zone
% DOY = Day of year
% TD = Time Duration
J = 360*DOY/365;
% Day Angle
Delta = 0.3948-23.2559*cosd(J+9.1)-0.3915*cosd(2*J+5.4)-0.176*cosd(3*J+26);
% Declination
TEQ = (0.0066+7.3525*cosd(J+85.9)+9.9359*cosd(2*J+108.9)+0.3387*cosd(3*J+105.2))*60;
% Time Equation
TLT = (TD-TZ)*3600+4*Lambda*60+TEQ; 
% True Local Time
Omega = (12-TLT/3600)*15;
% Hour Angle
Ys = asind(cosd(Omega).*cosd(Phi).*cosd(Delta)+sind(Phi).*sind(Delta)); 
% Sun Elevation
Am = 1./sind(Ys);
% Air Mass
A = (TLT/3600<12);
B = (-1).^A;
SAz=180+B.*(acosd((sind(Ys).*sind(Phi)-sind(Delta))./(cosd(Ys).*cosd(Phi)))); 
% Sun Azimuth
end
