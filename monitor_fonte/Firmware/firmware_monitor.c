/****************************************************************
* @file : firmware_monitor.c
*
*
*****************************************************************/

/* Includes */
#include "Device.h"

void main(){

 Device_init();
  
  while(1) {                         // Endless loop
    Device_run();
  }
}