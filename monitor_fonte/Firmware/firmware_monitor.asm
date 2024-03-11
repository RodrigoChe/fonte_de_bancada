
_main:

;firmware_monitor.c,10 :: 		void main(){
;firmware_monitor.c,12 :: 		Device_init();
	CALL        _Device_init+0, 0
;firmware_monitor.c,14 :: 		while(1) {                         // Endless loop
L_main0:
;firmware_monitor.c,15 :: 		Device_run();
	CALL        _Device_run+0, 0
;firmware_monitor.c,16 :: 		}
	GOTO        L_main0
;firmware_monitor.c,17 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
