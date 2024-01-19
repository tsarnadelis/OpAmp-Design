aem=88;

%Specifications
CL=(2+0.01*aem)*1e-12;
SR=(18+0.01*aem)*1e6;
VDD=1.8+0.003*aem;
VSS=-VDD;
GB=(7+0.01*aem)*1e6;
A=(20+0.01*aem); %dB
P=(50+0.01*aem)*1e-3;

%Parameters from models
Vtop=-0.9056;
Vton=0.786;
kp=29.352*1e-6;
kn=96.379*1e-6;
Vinmin=-0.1;
Vinmax=0.1;
Cox=4.6e-3;
lambda2=0.15;
lambda7=lambda2;
lambda4=0.05;
lambda6=lambda4;

%Select fixed length L
L=2e-6;

%Width Calculation
Cc=0.22 * CL;
Cc=1e-12  ;  %i selected this

I5=SR*Cc;

S3=I5/(kn*(-VSS-Vton+abs(Vtop)+Vinmin)^2) ;
S3=1; %I selected this
S4=S3;

Cgs=2/3*S3*(L^2)*Cox;
gm3=sqrt(kn*S3*I5);
p3=gm3/(2*Cgs);
p3_Hz=p3/(2*pi);

%Check p3 
if (p3/(2*pi)>10*GB)
    fprintf("-------P3 OK-------\n");
end

gm1=2*pi*GB*Cc;
gm2=gm1;
S1=(gm1^2)/(kp*I5);
S2=S1;

b1=kp*S1;
Vsd5=VDD-sqrt(I5/b1)-abs(Vtop)-Vinmax;

%Check Vsd5
if (Vsd5>0.1)
    fprintf("-------Vsd3 OK-------\n");
end

S5=2*I5/(kp*Vsd5^2);

gm6=10*gm1;
gm4=sqrt(kn*S4*I5);
S6=S4*gm6/gm4;

I6=(gm6^2)/(2*kn*S6);

S7=(I6/I5)*S5;

Iref=100e-6; %I selected this
S8=(Iref/I5)*S5;

W1=S1*L*1e6;
W2=S2*L*1e6;
W3=S3*L*1e6;
W4=S4*L*1e6;
W5=S5*L*1e6;
W6=S6*L*1e6;
W7=S7*L*1e6;
W8=S8*L*1e6;

%Check Gain
Av=2*gm2*gm6/(I5*(lambda2+lambda4)*I6*(lambda6+lambda7));
Av_dB=db(Av);
if (Av_dB>A)
    fprintf("-------Gain OK-------\n")
end

%Check Power
Pdiss=(I5+I6)*(VDD+abs(VSS));
if (Pdiss<P)
    fprintf("-------Power OK-------\n")
end