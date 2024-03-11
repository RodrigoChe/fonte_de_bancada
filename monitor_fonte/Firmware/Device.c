/****************************************************************
* @file : Device.c
*
*
*****************************************************************/

/*includes */
#include "Device.h"

/* Macros */
#define V_MAX  (35.8534)  // Calibration (36678/1023)
#define B_2_V   (4.8876)  // To 5V convertion bits to volts (5000/1023)
#define SENS_CUR (0.185)  // To 5V (5000/1023) / 0.185 mV/A= I
#define LOOP_DELAY (800)  // Delay for infinite loop
#define N_AVAREGE  (12U)  // Number of average

/* Global Variables */

// LCD module connections
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
// End LCD module connections

const int  offset = 512;

/*
unsigned int timer_counter;

 void interrupt()
{
   if(TMR0IF_bit){
      timer_counter++;
      TMR0L = 0;     //1ms
      TMR0H = 251;
      TMR0IF_bit = 0x00;
      //RB7_bit = ~RB7_bit;
      //Device_run();
   }

}*/

/*Functions prototipe */
Device_display_init();
Device_GPIO_init();
Device_ADC_init();
//Device_TIMER_init();

/*Implementation */

Device_init(){

  Device_GPIO_init();
  
  Device_ADC_init();
  
  Device_display_init();
  
  //Device_TIMER_init();
  
  Delay_ms(1000);
  Lcd_Cmd(_LCD_CLEAR);            // Clear display
}

Device_GPIO_init(){
  /*IO pins configuration*/
  /*PA 0,1,2,3 = In, 4,5,6,7 = Out*/
  TRISA = 0x0F;
  /*PB 0 = In, 1,2,3,4,5,6,7 = Out*/
  TRISB = 0x01;
  /*Ports initialize*/
  PORTA = 0x00;
  PORTB = 0x00;
}

Device_ADC_init(){
  /*Configure AN6,5 as digital, AN 4,3,2,1,0 as
  * analog channel and AN 3 as Vref+ external
  * AN4 = VF, AN2 = Temp, AN1 = current, AN0 = Voltage
  */
  ADCON1  = 0x60;;
  /*AN module ON  */
  ADCON0  = 0x41;;
  /* Right justified, Aq time = 2TAD, AD clock = Fosc/2*/
  ADCON2  = 0x88;
}

//Device_TIMER_init(){
  /* Machine Cycle = (10Mhz/4 = 2.5 MHz), T = 1/2.5MHz = 400ns
  *T0-> 16 bits, PS = 2, T0 time = ((65535-1250) x 400ns x 2 = 1ms
  *TMR0L + TMR0H = 64285 -> TMROL = 0 / TMR0H = 251 (64285/256)*/
//  T0CON = 0x080; // 100us
  /*Enable global interrupt, periferal, TMR0 overflow*/
//  GIE_bit = 0x01;
//  PEIE_bit = 0x01;
//  TMR0IE_bit = 0x01;
  /* Start timer0 counter with 206  = 50 x 400ns = 20us*/
//  TMR0L = 0;     //1ms
//  TMR0H = 251;
//}


Device_display_init(){
  Lcd_Init();                     // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);            // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);       // Cursor off
  Lcd_Out(1,3,"INITIALIZING");
}

Device_run(){
      unsigned int voltageVar, voltageFix, currentVar,temperatureVar, powerVar;

      /*if(timer_counter == 1000){
         PORTB.RB7 = ~PORTB.RB7;  //heartbeat
         timer_counter = 0x00;
      }*/
      Delay_ms(LOOP_DELAY);
      PORTB.RB7 = ~PORTB.RB7;  //heartbeat
      
      voltageVar  = Device_meseure_average(CHANNEL0);
      voltageVar  = voltageVar * V_MAX ; // Vmax source to 35V  (35000/1023)
      Device_print_voltage_measure(voltageVar);

      voltageFix = Device_meseure_average(CHANNEL4);
      voltageFix = voltageFix * B_2_V; // To 5V   (5000/1023)
      Device_print_voltage_fixed_measure(voltageFix);

      currentVar  = Device_meseure_average(CHANNEL1);
      if(currentVar < offset){
          currentVar = offset;
      }else{
         currentVar = (currentVar - offset);
      }
      currentVar = currentVar * B_2_V; //To 5V   (5000/1023) / 185 mV/A= I
      currentVar = currentVar/SENS_CUR;
      Device_print_current_measure(currentVar);

      powerVar = (voltageVar/1000) * (currentVar/10);// rearranje numbers
      Device_print_power_measure(powerVar);

      temperatureVar  = Device_meseure_average(CHANNEL2);
      temperatureVar = temperatureVar * B_2_V; //voltage in miliVolts
      Device_print_temperature_measure(temperatureVar);

}

Device_print_voltage_measure(unsigned int voltage){
    char dez_milhar, milhar, cent, dez, uni;
    /* convertion numbers to display */
    dez_milhar = (voltage/10000);
    milhar =  (voltage%10000)/1000;
    cent =    (voltage%1000)/100;
    dez =     (voltage%100)/10;
    uni =     (voltage%10);
    
    Lcd_Chr(1,1,'V');
    Lcd_Chr_Cp('=');
    Lcd_Chr_Cp(dez_milhar + 0x30);  // (0x30 offset ASCII charracters)
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

    milhar =  (current/1000);
    cent =    (current%1000)/100;
    dez =     (current%100)/10;
    uni =     (current%10);

    Lcd_Chr(2,1,'A');
    Lcd_Chr_Cp('=');
    Lcd_Chr_Cp(milhar + 0x30);
    Lcd_Chr_Cp('.');
    Lcd_Chr_Cp(cent+ 0x30);
    Lcd_Chr_Cp(dez + 0x30);
}

Device_print_power_measure(unsigned int power){

    char milhar, cent, dez;

    milhar =  (power/1000);
    cent =    (power%1000)/100;
    dez =     (power%100)/10;

    Lcd_Chr(2,8,'W');
    Lcd_Chr_Cp('=');
    Lcd_Chr_Cp(milhar + 0x30);
    Lcd_Chr_Cp(cent+ 0x30);
    Lcd_Chr_Cp('.');
    Lcd_Chr_Cp(dez + 0x30);

}

Device_print_temperature_measure(unsigned int voltage){
    char milhar, cent, dez;

    milhar =  (voltage/1000);
    cent =    (voltage%1000)/100;
    dez =     (voltage%100)/10;

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
          ADCON0  = 0x41;           // read channel 0
          ADON_bit = 1;
          Delay_us(20);
          GO_NOT_DONE_bit = 1;
          while(GO_NOT_DONE_bit == 1);
          Delay_us(20);
          read =  (ADRESH << 8) + ADRESL;
       break;
       case 1:
          ADCON0  = 0x45;           // read channel 1
          ADON_bit = 1;
          Delay_us(20);
          GO_NOT_DONE_bit = 1;
          while(GO_NOT_DONE_bit == 1);
          Delay_us(20);
          read =  (ADRESH << 8) + ADRESL;
       break;
       case 2:
          ADCON0  = 0x49;           // read channel 2
          ADON_bit = 1;
          Delay_us(20);
          GO_NOT_DONE_bit = 1;
          while(GO_NOT_DONE_bit == 1);
          Delay_us(20);
          read =  (ADRESH << 8) + ADRESL;
       break;
       case 4:
          ADCON0  = 0x51;           // read channel 4
          ADON_bit = 1;
          Delay_us(20);
          GO_NOT_DONE_bit = 1;
          while(GO_NOT_DONE_bit == 1);
          Delay_us(20);
          read =  (ADRESH << 8) + ADRESL;
       break;
    }
    return read;
}

unsigned int Device_meseure_average(unsigned short channel){
    unsigned char i;
    unsigned int average = 0;

    for(i = 0; i < N_AVAREGE; i++){
          average += Device_read_adc(channel);
    }
    return (average/N_AVAREGE);
}