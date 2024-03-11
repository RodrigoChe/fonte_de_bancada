
_Device_init:

;Device.c,64 :: 		Device_init(){
;Device.c,66 :: 		Device_GPIO_init();
	CALL        _Device_GPIO_init+0, 0
;Device.c,68 :: 		Device_ADC_init();
	CALL        _Device_ADC_init+0, 0
;Device.c,70 :: 		Device_display_init();
	CALL        _Device_display_init+0, 0
;Device.c,74 :: 		Delay_ms(1000);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_Device_init0:
	DECFSZ      R13, 1, 1
	BRA         L_Device_init0
	DECFSZ      R12, 1, 1
	BRA         L_Device_init0
	DECFSZ      R11, 1, 1
	BRA         L_Device_init0
	NOP
;Device.c,75 :: 		Lcd_Cmd(_LCD_CLEAR);            // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Device.c,76 :: 		}
L_end_Device_init:
	RETURN      0
; end of _Device_init

_Device_GPIO_init:

;Device.c,78 :: 		Device_GPIO_init(){
;Device.c,81 :: 		TRISA = 0x0F;
	MOVLW       15
	MOVWF       TRISA+0 
;Device.c,83 :: 		TRISB = 0x01;
	MOVLW       1
	MOVWF       TRISB+0 
;Device.c,85 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;Device.c,86 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;Device.c,87 :: 		}
L_end_Device_GPIO_init:
	RETURN      0
; end of _Device_GPIO_init

_Device_ADC_init:

;Device.c,89 :: 		Device_ADC_init(){
;Device.c,94 :: 		ADCON1  = 0x60;;
	MOVLW       96
	MOVWF       ADCON1+0 
;Device.c,96 :: 		ADCON0  = 0x41;;
	MOVLW       65
	MOVWF       ADCON0+0 
;Device.c,98 :: 		ADCON2  = 0x88;
	MOVLW       136
	MOVWF       ADCON2+0 
;Device.c,99 :: 		}
L_end_Device_ADC_init:
	RETURN      0
; end of _Device_ADC_init

_Device_display_init:

;Device.c,116 :: 		Device_display_init(){
;Device.c,117 :: 		Lcd_Init();                     // Initialize LCD
	CALL        _Lcd_Init+0, 0
;Device.c,118 :: 		Lcd_Cmd(_LCD_CLEAR);            // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Device.c,119 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);       // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Device.c,120 :: 		Lcd_Out(1,3,"INITIALIZING");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Device+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Device+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Device.c,121 :: 		}
L_end_Device_display_init:
	RETURN      0
; end of _Device_display_init

_Device_run:

;Device.c,123 :: 		Device_run(){
;Device.c,130 :: 		Delay_ms(LOOP_DELAY);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_Device_run1:
	DECFSZ      R13, 1, 1
	BRA         L_Device_run1
	DECFSZ      R12, 1, 1
	BRA         L_Device_run1
	DECFSZ      R11, 1, 1
	BRA         L_Device_run1
	NOP
	NOP
;Device.c,131 :: 		PORTB.RB7 = ~PORTB.RB7;  //heartbeat
	BTG         PORTB+0, 7 
;Device.c,133 :: 		voltageVar  = Device_meseure_average(CHANNEL0);
	CLRF        FARG_Device_meseure_average_channel+0 
	CALL        _Device_meseure_average+0, 0
	MOVF        R0, 0 
	MOVWF       Device_run_voltageVar_L0+0 
	MOVF        R1, 0 
	MOVWF       Device_run_voltageVar_L0+1 
;Device.c,134 :: 		voltageVar  = voltageVar * V_MAX ; // Vmax source to 35V  (35000/1023)
	CALL        _word2double+0, 0
	MOVLW       226
	MOVWF       R4 
	MOVLW       105
	MOVWF       R5 
	MOVLW       15
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       Device_run_voltageVar_L0+0 
	MOVF        R1, 0 
	MOVWF       Device_run_voltageVar_L0+1 
;Device.c,135 :: 		Device_print_voltage_measure(voltageVar);
	MOVF        R0, 0 
	MOVWF       FARG_Device_print_voltage_measure_voltage+0 
	MOVF        R1, 0 
	MOVWF       FARG_Device_print_voltage_measure_voltage+1 
	CALL        _Device_print_voltage_measure+0, 0
;Device.c,137 :: 		voltageFix = Device_meseure_average(CHANNEL4);
	MOVLW       4
	MOVWF       FARG_Device_meseure_average_channel+0 
	CALL        _Device_meseure_average+0, 0
;Device.c,138 :: 		voltageFix = voltageFix * B_2_V; // To 5V   (5000/1023)
	CALL        _word2double+0, 0
	MOVLW       56
	MOVWF       R4 
	MOVLW       103
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
;Device.c,139 :: 		Device_print_voltage_fixed_measure(voltageFix);
	MOVF        R0, 0 
	MOVWF       FARG_Device_print_voltage_fixed_measure_voltage+0 
	MOVF        R1, 0 
	MOVWF       FARG_Device_print_voltage_fixed_measure_voltage+1 
	CALL        _Device_print_voltage_fixed_measure+0, 0
;Device.c,141 :: 		currentVar  = Device_meseure_average(CHANNEL1);
	MOVLW       1
	MOVWF       FARG_Device_meseure_average_channel+0 
	CALL        _Device_meseure_average+0, 0
	MOVF        R0, 0 
	MOVWF       Device_run_currentVar_L0+0 
	MOVF        R1, 0 
	MOVWF       Device_run_currentVar_L0+1 
;Device.c,147 :: 		if(currentVar < offset){
	MOVLW       2
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Device_run38
	MOVLW       0
	SUBWF       R0, 0 
L__Device_run38:
	BTFSC       STATUS+0, 0 
	GOTO        L_Device_run2
;Device.c,148 :: 		currentVar = offset;
	MOVLW       0
	MOVWF       Device_run_currentVar_L0+0 
	MOVLW       2
	MOVWF       Device_run_currentVar_L0+1 
;Device.c,149 :: 		}else{
	GOTO        L_Device_run3
L_Device_run2:
;Device.c,150 :: 		currentVar = (currentVar - offset);
	MOVLW       0
	SUBWF       Device_run_currentVar_L0+0, 1 
	MOVLW       2
	SUBWFB      Device_run_currentVar_L0+1, 1 
;Device.c,151 :: 		}
L_Device_run3:
;Device.c,153 :: 		currentVar = currentVar * B_2_V; //To 5V   (5000/1023) / 185 mV/A= I
	MOVF        Device_run_currentVar_L0+0, 0 
	MOVWF       R0 
	MOVF        Device_run_currentVar_L0+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       56
	MOVWF       R4 
	MOVLW       103
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       Device_run_currentVar_L0+0 
	MOVF        R1, 0 
	MOVWF       Device_run_currentVar_L0+1 
;Device.c,154 :: 		currentVar = currentVar/SENS_CUR;
	CALL        _word2double+0, 0
	MOVLW       164
	MOVWF       R4 
	MOVLW       112
	MOVWF       R5 
	MOVLW       61
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       Device_run_currentVar_L0+0 
	MOVF        R1, 0 
	MOVWF       Device_run_currentVar_L0+1 
;Device.c,157 :: 		Device_print_current_measure(currentVar);
	MOVF        R0, 0 
	MOVWF       FARG_Device_print_current_measure_current+0 
	MOVF        R1, 0 
	MOVWF       FARG_Device_print_current_measure_current+1 
	CALL        _Device_print_current_measure+0, 0
;Device.c,159 :: 		powerVar = (voltageVar/1000) * (currentVar/10);// rearranje numbers
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        Device_run_voltageVar_L0+0, 0 
	MOVWF       R0 
	MOVF        Device_run_voltageVar_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Device_run+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Device_run+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Device_run_currentVar_L0+0, 0 
	MOVWF       R0 
	MOVF        Device_run_currentVar_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        FLOC__Device_run+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Device_run+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
;Device.c,160 :: 		Device_print_power_measure(powerVar);
	MOVF        R0, 0 
	MOVWF       FARG_Device_print_power_measure_power+0 
	MOVF        R1, 0 
	MOVWF       FARG_Device_print_power_measure_power+1 
	CALL        _Device_print_power_measure+0, 0
;Device.c,162 :: 		temperatureVar  = Device_meseure_average(CHANNEL2);
	MOVLW       2
	MOVWF       FARG_Device_meseure_average_channel+0 
	CALL        _Device_meseure_average+0, 0
;Device.c,163 :: 		temperatureVar = temperatureVar * B_2_V; //voltage in miliVolts
	CALL        _word2double+0, 0
	MOVLW       56
	MOVWF       R4 
	MOVLW       103
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
;Device.c,164 :: 		Device_print_temperature_measure(temperatureVar);
	MOVF        R0, 0 
	MOVWF       FARG_Device_print_temperature_measure_voltage+0 
	MOVF        R1, 0 
	MOVWF       FARG_Device_print_temperature_measure_voltage+1 
	CALL        _Device_print_temperature_measure+0, 0
;Device.c,166 :: 		}
L_end_Device_run:
	RETURN      0
; end of _Device_run

_Device_print_voltage_measure:

;Device.c,168 :: 		Device_print_voltage_measure(unsigned int voltage){
;Device.c,171 :: 		dez_milhar = (voltage/10000);
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        FARG_Device_print_voltage_measure_voltage+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_voltage_measure_voltage+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_voltage_measure_dez_milhar_L0+0 
;Device.c,172 :: 		milhar =  (voltage%10000)/1000;
	MOVLW       16
	MOVWF       R4 
	MOVLW       39
	MOVWF       R5 
	MOVF        FARG_Device_print_voltage_measure_voltage+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_voltage_measure_voltage+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_voltage_measure_milhar_L0+0 
;Device.c,173 :: 		cent =    (voltage%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_Device_print_voltage_measure_voltage+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_voltage_measure_voltage+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_voltage_measure_cent_L0+0 
;Device.c,174 :: 		dez =     (voltage%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_Device_print_voltage_measure_voltage+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_voltage_measure_voltage+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_voltage_measure_dez_L0+0 
;Device.c,177 :: 		Lcd_Chr(1,1,'V');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Device.c,178 :: 		Lcd_Chr_Cp('=');
	MOVLW       61
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,179 :: 		Lcd_Chr_Cp(dez_milhar + 0x30);  // (0x30 offset ASCII charracters)
	MOVLW       48
	ADDWF       Device_print_voltage_measure_dez_milhar_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,180 :: 		Lcd_Chr_Cp(milhar + 0x30);
	MOVLW       48
	ADDWF       Device_print_voltage_measure_milhar_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,181 :: 		Lcd_Chr_Cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,182 :: 		Lcd_Chr_Cp(cent+ 0x30);
	MOVLW       48
	ADDWF       Device_print_voltage_measure_cent_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,183 :: 		Lcd_Chr_Cp(dez + 0x30);
	MOVLW       48
	ADDWF       Device_print_voltage_measure_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,185 :: 		}
L_end_Device_print_voltage_measure:
	RETURN      0
; end of _Device_print_voltage_measure

_Device_print_voltage_fixed_measure:

;Device.c,187 :: 		Device_print_voltage_fixed_measure(unsigned int voltage){
;Device.c,189 :: 		Lcd_Chr(1,15,'V');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       86
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Device.c,190 :: 		Lcd_Chr_Cp('F');
	MOVLW       70
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,191 :: 		if(voltage < 1500){
	MOVLW       5
	SUBWF       FARG_Device_print_voltage_fixed_measure_voltage+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Device_print_voltage_fixed_measure41
	MOVLW       220
	SUBWF       FARG_Device_print_voltage_fixed_measure_voltage+0, 0 
L__Device_print_voltage_fixed_measure41:
	BTFSC       STATUS+0, 0 
	GOTO        L_Device_print_voltage_fixed_measure4
;Device.c,192 :: 		Lcd_Chr(2,15,'D');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       68
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Device.c,193 :: 		Lcd_Chr_Cp('N');
	MOVLW       78
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,194 :: 		}else if(voltage > 3000){
	GOTO        L_Device_print_voltage_fixed_measure5
L_Device_print_voltage_fixed_measure4:
	MOVF        FARG_Device_print_voltage_fixed_measure_voltage+1, 0 
	SUBLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L__Device_print_voltage_fixed_measure42
	MOVF        FARG_Device_print_voltage_fixed_measure_voltage+0, 0 
	SUBLW       184
L__Device_print_voltage_fixed_measure42:
	BTFSC       STATUS+0, 0 
	GOTO        L_Device_print_voltage_fixed_measure6
;Device.c,195 :: 		Lcd_Chr(2,15,'U');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       85
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Device.c,196 :: 		Lcd_Chr_Cp('P');
	MOVLW       80
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,197 :: 		}else{
	GOTO        L_Device_print_voltage_fixed_measure7
L_Device_print_voltage_fixed_measure6:
;Device.c,198 :: 		Lcd_Chr(2,15,'O');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       79
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Device.c,199 :: 		Lcd_Chr_Cp('K');
	MOVLW       75
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,200 :: 		}
L_Device_print_voltage_fixed_measure7:
L_Device_print_voltage_fixed_measure5:
;Device.c,201 :: 		}
L_end_Device_print_voltage_fixed_measure:
	RETURN      0
; end of _Device_print_voltage_fixed_measure

_Device_print_current_measure:

;Device.c,203 :: 		Device_print_current_measure(unsigned int current){
;Device.c,206 :: 		milhar =  (current/1000);
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_Device_print_current_measure_current+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_current_measure_current+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_current_measure_milhar_L0+0 
;Device.c,207 :: 		cent =    (current%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_Device_print_current_measure_current+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_current_measure_current+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_current_measure_cent_L0+0 
;Device.c,208 :: 		dez =     (current%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_Device_print_current_measure_current+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_current_measure_current+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_current_measure_dez_L0+0 
;Device.c,211 :: 		Lcd_Chr(2,1,'A');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       65
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Device.c,212 :: 		Lcd_Chr_Cp('=');
	MOVLW       61
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,213 :: 		Lcd_Chr_Cp(milhar + 0x30);
	MOVLW       48
	ADDWF       Device_print_current_measure_milhar_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,214 :: 		Lcd_Chr_Cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,215 :: 		Lcd_Chr_Cp(cent+ 0x30);
	MOVLW       48
	ADDWF       Device_print_current_measure_cent_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,216 :: 		Lcd_Chr_Cp(dez + 0x30);
	MOVLW       48
	ADDWF       Device_print_current_measure_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,218 :: 		}
L_end_Device_print_current_measure:
	RETURN      0
; end of _Device_print_current_measure

_Device_print_power_measure:

;Device.c,220 :: 		Device_print_power_measure(unsigned int power){
;Device.c,224 :: 		milhar =  (power/1000);
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_Device_print_power_measure_power+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_power_measure_power+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_power_measure_milhar_L0+0 
;Device.c,225 :: 		cent =    (power%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_Device_print_power_measure_power+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_power_measure_power+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_power_measure_cent_L0+0 
;Device.c,226 :: 		dez =     (power%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_Device_print_power_measure_power+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_power_measure_power+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_power_measure_dez_L0+0 
;Device.c,228 :: 		Lcd_Chr(2,8,'W');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       87
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Device.c,229 :: 		Lcd_Chr_Cp('=');
	MOVLW       61
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,230 :: 		Lcd_Chr_Cp(milhar + 0x30);
	MOVLW       48
	ADDWF       Device_print_power_measure_milhar_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,231 :: 		Lcd_Chr_Cp(cent+ 0x30);
	MOVLW       48
	ADDWF       Device_print_power_measure_cent_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,232 :: 		Lcd_Chr_Cp('.');
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,233 :: 		Lcd_Chr_Cp(dez + 0x30);
	MOVLW       48
	ADDWF       Device_print_power_measure_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,235 :: 		}
L_end_Device_print_power_measure:
	RETURN      0
; end of _Device_print_power_measure

_Device_print_temperature_measure:

;Device.c,237 :: 		Device_print_temperature_measure(unsigned int voltage){
;Device.c,240 :: 		milhar =  (voltage/1000);
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_Device_print_temperature_measure_voltage+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_temperature_measure_voltage+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_temperature_measure_milhar_L0+0 
;Device.c,241 :: 		cent =    (voltage%1000)/100;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FARG_Device_print_temperature_measure_voltage+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_temperature_measure_voltage+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_temperature_measure_cent_L0+0 
;Device.c,242 :: 		dez =     (voltage%100)/10;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_Device_print_temperature_measure_voltage+0, 0 
	MOVWF       R0 
	MOVF        FARG_Device_print_temperature_measure_voltage+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Device_print_temperature_measure_dez_L0+0 
;Device.c,244 :: 		Lcd_Chr(1,9,'T');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       84
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Device.c,245 :: 		Lcd_Chr_Cp('=');
	MOVLW       61
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,246 :: 		Lcd_Chr_Cp(milhar + 0x30);
	MOVLW       48
	ADDWF       Device_print_temperature_measure_milhar_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,247 :: 		Lcd_Chr_Cp(cent+ 0x30);
	MOVLW       48
	ADDWF       Device_print_temperature_measure_cent_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,248 :: 		Lcd_Chr_Cp(dez + 0x30);
	MOVLW       48
	ADDWF       Device_print_temperature_measure_dez_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;Device.c,249 :: 		}
L_end_Device_print_temperature_measure:
	RETURN      0
; end of _Device_print_temperature_measure

_Device_read_adc:

;Device.c,251 :: 		unsigned int Device_read_adc(unsigned short channel){
;Device.c,254 :: 		switch(channel){
	GOTO        L_Device_read_adc8
;Device.c,255 :: 		case 0:
L_Device_read_adc10:
;Device.c,256 :: 		ADCON0  = 0x41;           // read channel 0
	MOVLW       65
	MOVWF       ADCON0+0 
;Device.c,257 :: 		ADON_bit = 1;
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;Device.c,258 :: 		Delay_us(20);
	MOVLW       16
	MOVWF       R13, 0
L_Device_read_adc11:
	DECFSZ      R13, 1, 1
	BRA         L_Device_read_adc11
	NOP
;Device.c,259 :: 		GO_NOT_DONE_bit = 1;
	BSF         GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0) 
;Device.c,260 :: 		while(GO_NOT_DONE_bit == 1);
L_Device_read_adc12:
	BTFSS       GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0) 
	GOTO        L_Device_read_adc13
	GOTO        L_Device_read_adc12
L_Device_read_adc13:
;Device.c,261 :: 		Delay_us(20);
	MOVLW       16
	MOVWF       R13, 0
L_Device_read_adc14:
	DECFSZ      R13, 1, 1
	BRA         L_Device_read_adc14
	NOP
;Device.c,262 :: 		read =  (ADRESH << 8) + ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        ADRESL+0, 0 
	ADDWF       R2, 1 
	MOVLW       0
	ADDWFC      R3, 1 
;Device.c,263 :: 		break;
	GOTO        L_Device_read_adc9
;Device.c,264 :: 		case 1:
L_Device_read_adc15:
;Device.c,265 :: 		ADCON0  = 0x45;           // read channel 1
	MOVLW       69
	MOVWF       ADCON0+0 
;Device.c,266 :: 		ADON_bit = 1;
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;Device.c,267 :: 		Delay_us(20);
	MOVLW       16
	MOVWF       R13, 0
L_Device_read_adc16:
	DECFSZ      R13, 1, 1
	BRA         L_Device_read_adc16
	NOP
;Device.c,268 :: 		GO_NOT_DONE_bit = 1;
	BSF         GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0) 
;Device.c,269 :: 		while(GO_NOT_DONE_bit == 1);
L_Device_read_adc17:
	BTFSS       GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0) 
	GOTO        L_Device_read_adc18
	GOTO        L_Device_read_adc17
L_Device_read_adc18:
;Device.c,270 :: 		Delay_us(20);
	MOVLW       16
	MOVWF       R13, 0
L_Device_read_adc19:
	DECFSZ      R13, 1, 1
	BRA         L_Device_read_adc19
	NOP
;Device.c,271 :: 		read =  (ADRESH << 8) + ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        ADRESL+0, 0 
	ADDWF       R2, 1 
	MOVLW       0
	ADDWFC      R3, 1 
;Device.c,272 :: 		break;
	GOTO        L_Device_read_adc9
;Device.c,273 :: 		case 2:
L_Device_read_adc20:
;Device.c,274 :: 		ADCON0  = 0x49;           // read channel 2
	MOVLW       73
	MOVWF       ADCON0+0 
;Device.c,275 :: 		ADON_bit = 1;
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;Device.c,276 :: 		Delay_us(20);
	MOVLW       16
	MOVWF       R13, 0
L_Device_read_adc21:
	DECFSZ      R13, 1, 1
	BRA         L_Device_read_adc21
	NOP
;Device.c,277 :: 		GO_NOT_DONE_bit = 1;
	BSF         GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0) 
;Device.c,278 :: 		while(GO_NOT_DONE_bit == 1);
L_Device_read_adc22:
	BTFSS       GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0) 
	GOTO        L_Device_read_adc23
	GOTO        L_Device_read_adc22
L_Device_read_adc23:
;Device.c,279 :: 		Delay_us(20);
	MOVLW       16
	MOVWF       R13, 0
L_Device_read_adc24:
	DECFSZ      R13, 1, 1
	BRA         L_Device_read_adc24
	NOP
;Device.c,280 :: 		read =  (ADRESH << 8) + ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        ADRESL+0, 0 
	ADDWF       R2, 1 
	MOVLW       0
	ADDWFC      R3, 1 
;Device.c,281 :: 		break;
	GOTO        L_Device_read_adc9
;Device.c,282 :: 		case 4:
L_Device_read_adc25:
;Device.c,283 :: 		ADCON0  = 0x51;           // read channel 4
	MOVLW       81
	MOVWF       ADCON0+0 
;Device.c,284 :: 		ADON_bit = 1;
	BSF         ADON_bit+0, BitPos(ADON_bit+0) 
;Device.c,285 :: 		Delay_us(20);
	MOVLW       16
	MOVWF       R13, 0
L_Device_read_adc26:
	DECFSZ      R13, 1, 1
	BRA         L_Device_read_adc26
	NOP
;Device.c,286 :: 		GO_NOT_DONE_bit = 1;
	BSF         GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0) 
;Device.c,287 :: 		while(GO_NOT_DONE_bit == 1);
L_Device_read_adc27:
	BTFSS       GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0) 
	GOTO        L_Device_read_adc28
	GOTO        L_Device_read_adc27
L_Device_read_adc28:
;Device.c,288 :: 		Delay_us(20);
	MOVLW       16
	MOVWF       R13, 0
L_Device_read_adc29:
	DECFSZ      R13, 1, 1
	BRA         L_Device_read_adc29
	NOP
;Device.c,289 :: 		read =  (ADRESH << 8) + ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       R3 
	CLRF        R2 
	MOVF        ADRESL+0, 0 
	ADDWF       R2, 1 
	MOVLW       0
	ADDWFC      R3, 1 
;Device.c,290 :: 		break;
	GOTO        L_Device_read_adc9
;Device.c,291 :: 		}
L_Device_read_adc8:
	MOVF        FARG_Device_read_adc_channel+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Device_read_adc10
	MOVF        FARG_Device_read_adc_channel+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_Device_read_adc15
	MOVF        FARG_Device_read_adc_channel+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_Device_read_adc20
	MOVF        FARG_Device_read_adc_channel+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_Device_read_adc25
L_Device_read_adc9:
;Device.c,292 :: 		return read;
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	MOVWF       R1 
;Device.c,293 :: 		}
L_end_Device_read_adc:
	RETURN      0
; end of _Device_read_adc

_Device_meseure_average:

;Device.c,295 :: 		unsigned int Device_meseure_average(unsigned short channel){
;Device.c,297 :: 		unsigned int average = 0;
	CLRF        Device_meseure_average_average_L0+0 
	CLRF        Device_meseure_average_average_L0+1 
;Device.c,299 :: 		for(i = 0; i < N_AVAREGE; i++){
	CLRF        Device_meseure_average_i_L0+0 
L_Device_meseure_average30:
	MOVLW       12
	SUBWF       Device_meseure_average_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Device_meseure_average31
;Device.c,300 :: 		average += Device_read_adc(channel);
	MOVF        FARG_Device_meseure_average_channel+0, 0 
	MOVWF       FARG_Device_read_adc_channel+0 
	CALL        _Device_read_adc+0, 0
	MOVF        R0, 0 
	ADDWF       Device_meseure_average_average_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      Device_meseure_average_average_L0+1, 1 
;Device.c,299 :: 		for(i = 0; i < N_AVAREGE; i++){
	INCF        Device_meseure_average_i_L0+0, 1 
;Device.c,301 :: 		}
	GOTO        L_Device_meseure_average30
L_Device_meseure_average31:
;Device.c,302 :: 		return (average/N_AVAREGE);
	MOVLW       12
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        Device_meseure_average_average_L0+0, 0 
	MOVWF       R0 
	MOVF        Device_meseure_average_average_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
;Device.c,303 :: 		}
L_end_Device_meseure_average:
	RETURN      0
; end of _Device_meseure_average
