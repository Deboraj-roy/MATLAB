%  DEBORAJ ROY 19-40158-1. 

clc;    
close all;  
workspace;  
fontSize = 14;
image = imread("40158.png"); % can use any size image.



binaryData = imageTobinConverter(image);
disp("Message transmitter: ");

figure
stem(binaryData, 'Linewidth',1), grid on;
title('Information before Transmiting ');
axis([ 0 99 0 1.5]);

disp(binaryData);
size(binaryData);


data_NZR=2*binaryData-1; 
SPData=reshape(data_NZR,2,length(binaryData)/2); 

br=10^6; 
f=br; 
T=1/br; 
t=T/99:T/99:T; 

y=[];
yInPhase=[];
yQuadrature=[];

rcvddata=image;


for i=1:length(binaryData)/2
    
    y1=SPData(1,i)*cos(2*pi*f*t); 
    
    y2=SPData(2,i)*sin(2*pi*f*t) ;
    
    yInPhase=[yInPhase y1]; 
    
    yQuadrature=[yQuadrature y2]; 
    
    y=[y y1+y2]; 
    
end


transmittedSignal=awgn(y,10); 

tt=T/99:T/99:(T*length(binaryData))/2;

figure

subplot(3,1,1);

plot(tt,y_inPhase,'Linewidth',3), grid on;

title('QPSK modulation');

xlabel('time(sec)');

ylabel('Amplitude(volt0');

subplot(3,1,2);

plot(tt,y_quadrature,'Linewidth',3), grid on;

title('QPSK modulation ');
xlabel('time(sec)');
ylabel('Amplitude(volt0');

subplot(3,1,3);
plot(tt,transmittedSignal,'r','Linewidth',3), grid on;

title('QPSK modulated signal (sum of inphase and Quadrature phase signal)');
xlabel('time(sec)');
ylabel('Amplitude(volt0');
        

receivedData=[];
receivedSignal=transmittedSignal; 


for i=1:1:length(binaryData)/2

    
    ZInPhase=receivedSignal((i-1)*length(t)+1:i*length(t)).*cos(2*pi*f*t); 
    
    ZInPhase_intg=(trapz(t,ZInPhase))*(2/T);
    
    
    if(ZInPhase_intg>0) 
        receivedInphaseData=1;
        
    else
       receivedInphaseData=0; 
       
    end
    
    
    Quadrature=receivedSignal((i-1)*length(t)+1:i*length(t)).*sin(2*pi*f*t);
    
    Quadrature_intg=(trapz(t,Quadrature))*(2/T);
    
        if (Quadrature_intg>0)
           receivedQuadratureData=1;
        
        else
           receivedQuadratureData=0; 
       
        end
        
        
        receivedData=[receivedData  receivedInphaseData  receivedQuadratureData]; % Received Data vector
end


figure

stem(receivedData,'Linewidth',1);

title('Information after Receiveing ');

axis([ 0 99 0 1.5]), grid on;

figure

subplot(2,1,1);

imshow(rcvddata);

title('Output Image');

De=reshape(receivedData,10,[]);

disp("binary matrix after receiving & demodulation");

disp(De);

GrayImage = uint8(255 *receivedData);
