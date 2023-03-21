; config.g
; Called on power-up of the Duet Electronics
; =========================================================================================================
;
; global variables
;
global IdleCounter = 0                                                 ; counts idle time
global ExtruderTempActive_Old = 0                                      ; stores extruder temperature for idle check
global BedTempActive_Old = 0                                           ; stores bed temperature for idle check
global OldStateStatus = 0                                              ; stores the status of the printer, processing = 1
global purge = 0                                                       ; stores status to purge when autoloading
global zLiftDistance = 0                                               ; stores distance for lifting z axis
global waitForExtruderTemperature = false                              ; beeps when pre-heat temperature is reached
global waitForBedTemperature = false                                   ; beeps when pre-heat temperature is reached
global AskToChange = 1                                                 ; ask if filament should be changed?
global x_accel = 0                                                     ; stores x accelerations (mm/s^2)
global x_jerk = 0                                                      ; stores x maximum instantaneous speed changes (mm/min)
global y_accel = 0                                                     ; stores y accelerations (mm/s^2)
global y_jerk = 0                                                      ; maximum y instantaneous speed changes (mm/min)
global filamentErrorIgnore = 0                                         ; enable / disable execution of filament-error.g
global filamentTriggerIgnore = 0                                       ; enable / disable execution of trigger2.g
;
; general settings
;
M111 S0                                                                ; debugging off
G21                                                                    ; work in millimetres
G90										; Send absolute coordinates...
M83										; ...but relative extruder moves
;
; =========================================================================================================
; network settings
; =========================================================================================================
;
M550 P"KaPredator"							; Set machine name
M552 S1 P192.168.0.53						; Set IP
M553 P255.255.255.0							; Set subnetwork mask
M554 P192.168.0.1							; Set gateway
M586 P0 S1									; Enable HTTP
M586 P1 S0 ;C"*"									; Allow FTP and Cross Origin Resource Sharing (CORS)for DueUI
M586 P2 S0									; Disable Telnet
; LCD
M575 P1 S0 B57600								; Set Baudrate to 57600
;
; =========================================================================================================
; DELTA settings VOLCANO
; =========================================================================================================
;
M665 L440.833:440.833:440.833 R234.891 H411.550 B190.0 X0.015 Y-0.055 Z0.000
M666 X-0.217 Y-0.066 Z0.284 A0.00 B0.00
;
; =========================================================================================================
; drives
; =========================================================================================================
;
M569 P0.0 S0 D3 								; Drive 0 @X 
M569 P0.1 S0 D3									; Drive 1 @Y 
M569 P0.2 S0 D3									; Drive 2 @Z 
M569 P0.3 S0 D3									; Drive 3 @E
;
; motor configuration
;
M584 X0.0 Y0.1 Z0.2 E0.3						; Map drivers
;
; set microsteps and steps / mm
; =========================================================================================================
;
M350 X16 Y16 Z16 I1								; Configure micro-stepping with interpolation for X, Y, Z 
M350 E16 I0										; Configure micro-stepping without interpolation for E
M92 X80 Y80 Z80 E691							; Set steps per mm
;
; set motor currents
; =========================================================================================================
;
M906 X1250 Y1250 Z1250 E350 I30								; Set motor currents (mA) and motor idle factor in per cent
M84 S30														; Set idle timeout
;
; set speeds, acc and jerks...
; =========================================================================================================
;
M203 X36000 Y36000 Z36000 E4200							; Set maximum speeds (mm/min)
M201 X6400 Y6400 Z6400 E3000							; Set accelerations (mm/s^2)
M201.1 X500 Y500 Z20 E500 								; Set accelerations for special moves (mm/s^2)
M204 P6400 T6400										; Set printing and travel accelerations
M566 E600										    ; Set maximum instantaneous speed changes (JERKS) (mm/min) ONLY EXTRUDER
M205 X7 Y7 Z7											; Set maximum instantaneous speed changes (JERKS) (mm/seg) XYZ . USE this for Marlin COMPATIBILITY
;
set global.x_accel = move.axes[0].acceleration                         ; save accelerations (mm/s^2)
set global.x_jerk = move.axes[0].jerk                                  ; save maximum instantaneous speed changes (mm/min)
;
set global.y_accel = move.axes[1].acceleration                         ; save accelerations (mm/s^2)
set global.y_jerk = move.axes[1].jerk                                  ; save maximum instantaneous speed changes (mm/min)
;
; =========================================================================================================
; axes limits
; =========================================================================================================
;
M208 Z-1 S1									; Set minimum Z
;
; =========================================================================================================
; endstops
; =========================================================================================================
;
M574 X2 S1 P"io4.in"								; Set active high endstop on X on pin xstop
M574 Y2 S1 P"io3.in"								; Set active high endstop on Y on pin ystop
M574 Z2 S1 P"io5.in"								; Set active high endstop on Z on pin zstop
;
; Z-Probe Smarteffector
;
M558 P8 R0.4 C"io1.in+io1.out" H5 F1200 T9000 ;A3 S0.03    ; set Z probe type to effector and the dive height + speeds
G31 K0 P100 X0.0 Y0.0 Z-0.18                             ; set Z probe trigger value, offset and trigger
M557 R170 S25									; Define mesh grid
;
; =========================================================================================================
; heaters, fans, thermistors
; =========================================================================================================
;
; heated bed
; =========================================================================================================
;
M308 S0 P"temp0" Y"thermistor"  T100000 B3950 C0 A"Bed"			; Define Sensor0 as the heated bed temperature TRY B4300
M950 H0 C"out0" T0								; Define Heater0 as the heated bed, bind to Sensor0				; PID M950 H0 C"bedheat" T0								; Define Heater0 as the heated bed, bind to Sensor0				; PID 
M140 H0                                                   ; map heated bed to heater 0
M143 H0 P0 S120 A2                                      ; disable temporarily H0 if temp exceeds 120C
M143 H0 P0 S130 A0                                      ; heater fault H0 if temp exceeds 130C
M307 H0 B0 S1.00                                     ; disable bang-bang mode for the bed heater and set PWM limit
M570 H0 P60 T15                                      ; heater fault for 60seg of 15ºC excursion
;
; extruder
; =========================================================================================================
;
; hotend (V6 with E3d Thermistor)
;
M308 S1 P"temp1" Y"thermistor" T100000 B4725 C7.06e-8 A"Hotend"	R2200			; Define Sensor1 as Extruder0 temperature
M950 H1 C"out1" T1										; Define Heater1 as Extruder0 heater, bind to Sensor1
M143 H1 S275 A2                                         ; disable temporarily H1 if temp exceeds 275C
M143 H1 S285 A0                                         ; heater fault H1 if temp exceeds 280C
M307 H1 B0 S1.00                                        ; disable bang-bang mode for heater  and set PWM limit
M570 H1 P10 T30                                      	 ; heater fault for 10 seg of 30ºC excursion
;
; Heater model parameters
; =========================================================================================================
;
M307 H0 R0.408 C457.073:457.073 D1.85 S1.00 V24.5 B0
M307 H1 R2.080 C254.185:184.546 D10.06 S1.00 V24.5 B0
;
; fans
; =========================================================================================================
;
; Fan0 = Part Coooling (5015 radial)
M950 F0 C"out6" Q160								; Define Fan0 for Part Cooling (2x Delta BFB0412HHA-A), 500Hz PWM
M106 P0 S0 H-1 B0.4									; Set Fan0 to default off, manual control
;
; Fan1 = extruder fan (temperature controlled)
M950 F1 C"out5" Q500								; Define Fan1 for Hotend cooling, 500Hz PWM
M106 P1 S1 H1 T45									; Set Fan1 to Thermostatic control, max RPM at 45C
;
; Fan2 = MotherBoard Cooling
;----MCU & DRIVERS sensors------
M308 S3 Y"mcu-temp"	A"MCU"								; create sensor for MCU temp M308 S3 Y"mcutemp"
M308 S4 Y"drivers"	A"Drivers"							; create sensor for drivers temp M308 S4 Y"drivers"
;M912 P0 S-0.8                                          ; Calibrate MCU temp
M950 F2 C"out3" Q500									; create fan 2 on pin out4 - alternative with tacho M950 F2 C"!fan2+^pb6"
M106 P2 H3:4 L.3 B.5 X1 T40:65 							; Set fan 2 PWR fan. Turns on when MCU temperature, hits 45C and full when the MCU temperature reaches 65C or any TMC2660 alarms
;
; =========================================================================================================
; Accelerometer and input Shaping
; =========================================================================================================
;
M955 P0 C"io2.out+io2.in" I50							; Set Accelerometro on IO2
M593 P"zvdd" F42										; Input Shaping
;
; =========================================================================================================
;  filament handling
; =========================================================================================================
;
; execute macros that has the status of the filament sensor
;
M98 P"0:/sys/00-Functions/FilamentsensorStatus"
;
; ========================================================================================================
; tools
; =========================================================================================================
;
M200 D1.75
M563 P0 S"T0" D0 H1 F0                                  ; define tool 0
G10 P0 X0 Y0 Z0											; Set tool 0 axis offsets
M568 P0 S0 R0 A0                                        ; turn off extruder
;G10 P0 S-274 R-274  									; Set initial tool 0 active and standby temperatures to 0C
M302 S180 R180                                          ; allow extrusion starting from 180°C and retractions already from 180°C 
;
; =========================================================================================================
; other settings
; =========================================================================================================
;
M404 N1.75												; Define filament diameter for print monitor
M207 S0.85 R0 F2400 Z0									; Firmware retraction
M572 D0 S0.057											; Pressure Advance
;
; =========================================================================================================
; power fail settings
; =========================================================================================================
;
M911 S23 R24 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"      ; set voltage thresholds and actions to run on power loss
T0										; Select first tool (Extruder 0)
M501
;
; =========================================================================================================
;
; LEDS
;M950 P0 C"out4" Q1000                                ; Leds life
;
; Saved Mesh
;G29 S1										; Load bed mesh
;M376 H10									; Mesh bed compensation. Height must be set to at least 20x the maximum error in the height map (max 5%)