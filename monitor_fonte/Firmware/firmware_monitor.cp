#line 1 "E:/FONTE_DE_BANCADA/Instrumentacao_fonte/Monitor_Fonte/Firmware/firmware_monitor.c"
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
#line 10 "E:/FONTE_DE_BANCADA/Instrumentacao_fonte/Monitor_Fonte/Firmware/firmware_monitor.c"
void main(){

 Device_init();

 while(1) {
 Device_run();
 }
}
