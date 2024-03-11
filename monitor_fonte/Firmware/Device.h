/****************************************************************
* @file : Device.h
*
*
*****************************************************************/

//Macros
#define CHANNEL0 (0U)
#define CHANNEL1 (1U)
#define CHANNEL2 (2U)
#define CHANNEL4 (4U)

//unsigned int timer_counter = 0;

//Functions prototipe
Device_init();

Device_print_voltage_measure(unsigned int voltage);

Device_print_voltage_fixed_measure(unsigned int voltage);

Device_print_temperature_measure(unsigned int voltage);

Device_print_current_measure(unsigned int current);

Device_print_power_measure(unsigned int power);

unsigned int Device_read_adc(unsigned short channel);

unsigned int Device_meseure_average(unsigned short channel);

Device_run();