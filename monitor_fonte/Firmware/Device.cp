#line 1 "E:/FONTE_DE_BANCADA/Instrumentacao_fonte/Monitor_Fonte/Firmware/Device.c"
#line 1 "e:/fonte_de_bancada/instrumentacao_fonte/monitor_fonte/firmware/device.h"
#line 16 "e:/fonte_de_bancada/instrumentacao_fonte/monitor_fonte/firmware/device.h"
Device_init();

Device_print_voltage_measure(unsigned int voltage);

Device_print_voltage_fixed_measure(unsigned int voltage);

Device_print_temperature_measure(unsigned int voltage);

Device_print_current_measure(unsigned int current);

Device_print_power_measure(unsigned int power);

unsigned int Device_read_adc(unsigned short channel);

unsigned int Device_meseure_average(unsigned short channel);

Device_run();
#line 22 "E:/FONTE_DE_BANCADA/Instrumentacao_fonte/Monitor_Fonte/Firmware/Device.c"
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB6_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;



const int offset = 512;
#line 57 "E:/FONTE_DE_BANCADA/Instrumentacao_fonte/Monitor_Fonte/Firmware/Device.c"
Device_display_init();
Device_GPIO_init();
Device_ADC_init();




Device_init(){

 Device_GPIO_init();

 Device_ADC_init();

 Device_display_init();



 Delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);
}

Device_GPIO_init(){


 TRISA = 0x0F;

 TRISB = 0x01;

 PORTA = 0x00;
 PORTB = 0x00;
}

Device_ADC_init(){
#line 94 "E:/FONTE_DE_BANCADA/Instrumentacao_fonte/Monitor_Fonte/Firmware/Device.c"
 ADCON1 = 0x60;;

 ADCON0 = 0x41;;

 ADCON2 = 0x88;
}
#line 116 "E:/FONTE_DE_BANCADA/Instrumentacao_fonte/Monitor_Fonte/Firmware/Device.c"
Device_display_init(){
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,3,"INITIALIZING");
}

Device_run(){
 unsigned int voltageVar, voltageFix, currentVar,temperatureVar, powerVar;
#line 130 "E:/FONTE_DE_BANCADA/Instrumentacao_fonte/Monitor_Fonte/Firmware/Device.c"
 Delay_ms( (800) );
 PORTB.RB7 = ~PORTB.RB7;

 voltageVar = Device_meseure_average( (0U) );
 voltageVar = voltageVar *  (35.8534)  ;
 Device_print_voltage_measure(voltageVar);

 voltageFix = Device_meseure_average( (4U) );
 voltageFix = voltageFix *  (4.8876) ;
 Device_print_voltage_fixed_measure(voltageFix);

 currentVar = Device_meseure_average( (1U) );





 if(currentVar < offset){
 currentVar = offset;
 }else{
 currentVar = (currentVar - offset);
 }

 currentVar = currentVar *  (4.8876) ;
 currentVar = currentVar/ (0.185) ;


 Device_print_current_measure(currentVar);

 powerVar = (voltageVar/1000) * (currentVar/10);
 Device_print_power_measure(powerVar);

 temperatureVar = Device_meseure_average( (2U) );
 temperatureVar = temperatureVar *  (4.8876) ;
 Device_print_temperature_measure(temperatureVar);

}

Device_print_voltage_measure(unsigned int voltage){
 char dez_milhar, milhar, cent, dez, uni;

 dez_milhar = (voltage/10000);
 milhar = (voltage%10000)/1000;
 cent = (voltage%1000)/100;
 dez = (voltage%100)/10;
 uni = (voltage%10);

 Lcd_Chr(1,1,'V');
 Lcd_Chr_Cp('=');
 Lcd_Chr_Cp(dez_milhar + 0x30);
 Lcd_Chr_Cp(milhar + 0x30);
 Lcd_Chr_Cp('.');
 Lcd_Chr_Cp(cent+ 0x30);
 Lcd_Chr_Cp(dez + 0x30);

}

Device_print_voltage_fixed_measure(unsigned int voltage){

 Lcd_Chr(1,15,'V');
 Lcd_Chr_Cp('F');
 if(voltage < 1500){
 Lcd_Chr(2,15,'D');
 Lcd_Chr_Cp('N');
 }else if(voltage > 3000){
 Lcd_Chr(2,15,'U');
 Lcd_Chr_Cp('P');
 }else{
 Lcd_Chr(2,15,'O');
 Lcd_Chr_Cp('K');
 }
}

Device_print_current_measure(unsigned int current){
 char milhar, cent, dez, uni;

 milhar = (current/1000);
 cent = (current%1000)/100;
 dez = (current%100)/10;
 uni = (current%10);

 Lcd_Chr(2,1,'A');
 Lcd_Chr_Cp('=');
 Lcd_Chr_Cp(milhar + 0x30);
 Lcd_Chr_Cp('.');
 Lcd_Chr_Cp(cent+ 0x30);
 Lcd_Chr_Cp(dez + 0x30);

}

Device_print_power_measure(unsigned int power){

 char milhar, cent, dez;

 milhar = (power/1000);
 cent = (power%1000)/100;
 dez = (power%100)/10;

 Lcd_Chr(2,8,'W');
 Lcd_Chr_Cp('=');
 Lcd_Chr_Cp(milhar + 0x30);
 Lcd_Chr_Cp(cent+ 0x30);
 Lcd_Chr_Cp('.');
 Lcd_Chr_Cp(dez + 0x30);

}

Device_print_temperature_measure(unsigned int voltage){
 char milhar, cent, dez;

 milhar = (voltage/1000);
 cent = (voltage%1000)/100;
 dez = (voltage%100)/10;

 Lcd_Chr(1,9,'T');
 Lcd_Chr_Cp('=');
 Lcd_Chr_Cp(milhar + 0x30);
 Lcd_Chr_Cp(cent+ 0x30);
 Lcd_Chr_Cp(dez + 0x30);
}

unsigned int Device_read_adc(unsigned short channel){
 int read;

 switch(channel){
 case 0:
 ADCON0 = 0x41;
 ADON_bit = 1;
 Delay_us(20);
 GO_NOT_DONE_bit = 1;
 while(GO_NOT_DONE_bit == 1);
 Delay_us(20);
 read = (ADRESH << 8) + ADRESL;
 break;
 case 1:
 ADCON0 = 0x45;
 ADON_bit = 1;
 Delay_us(20);
 GO_NOT_DONE_bit = 1;
 while(GO_NOT_DONE_bit == 1);
 Delay_us(20);
 read = (ADRESH << 8) + ADRESL;
 break;
 case 2:
 ADCON0 = 0x49;
 ADON_bit = 1;
 Delay_us(20);
 GO_NOT_DONE_bit = 1;
 while(GO_NOT_DONE_bit == 1);
 Delay_us(20);
 read = (ADRESH << 8) + ADRESL;
 break;
 case 4:
 ADCON0 = 0x51;
 ADON_bit = 1;
 Delay_us(20);
 GO_NOT_DONE_bit = 1;
 while(GO_NOT_DONE_bit == 1);
 Delay_us(20);
 read = (ADRESH << 8) + ADRESL;
 break;
 }
 return read;
}

unsigned int Device_meseure_average(unsigned short channel){
 unsigned char i;
 unsigned int average = 0;

 for(i = 0; i <  (12U) ; i++){
 average += Device_read_adc(channel);
 }
 return (average/ (12U) );
}
