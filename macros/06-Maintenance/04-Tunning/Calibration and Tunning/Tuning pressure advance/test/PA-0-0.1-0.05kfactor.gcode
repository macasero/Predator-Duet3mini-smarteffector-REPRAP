; ### Marlin K-Factor Calibration Pattern ###
; -------------------------------------------
;
; Printer: AKL
; Filament: PLA
; Created: Wed Apr 15 2020 11:56:59 GMT+0200 (hora de verano de Europa central)
;
; Settings Printer:
; Filament Diameter = 1.75 mm
; Nozzle Diameter = 0.4 mm
; Nozzle Temperature = 210 °C
; Bed Temperature = 60 °C
; Retraction Distance = 1.3 mm
; Layer Height = 0.2 mm
; Z-axis Offset = 0 mm
;
; Settings Print Bed:
; Bed Shape = Round
; Bed Diameter = 220 mm
; Origin Bed Center = true
;
; Settings Speed:
; Slow Printing Speed = 1200 mm/min
; Fast Printing Speed = 4800 mm/min
; Movement Speed = 7200 mm/min
; Retract Speed = 2100 mm/min
; Printing Acceleration = 500 mm/s^2
; Jerk X-axis =  firmware default
; Jerk Y-axis =  firmware default
; Jerk Z-axis =  firmware default
; Jerk Extruder =  firmware default
;
; Settings Pattern:
; Linear Advance Version = 1.5
; Starting Value Factor = 0
; Ending Value Factor = 0.1
; Factor Stepping = 0.05
; Test Line Spacing = 5 mm
; Test Line Length Slow = 20 mm
; Test Line Length Fast = 40 mm
; Print Pattern = Standard
; Print Frame = true
; Number Lines = true
; Print Size X = 98 mm
; Print Size Y = 35 mm
; Print Rotation = 0 degree
;
; Settings Advance:
; Nozzle / Line Ratio = 1.2
; Bed leveling = 0
; Use FWRETRACT = false
; Extrusion Multiplier = 0.93
; Prime Nozzle = true
; Prime Extrusion Multiplier = 2.5
; Prime Speed = 1800
; Dwell Time = 2 s
;
; prepare printing
;
G21 ; Millimeter units
G90 ; Absolute XYZ
M83 ; Relative E
G28 ; Home all axes
G1 Z5 F100 ; Z raise
M104 S210 ; Set nozzle temperature (no wait)
M190 S60 ; Set bed temperature (wait)
M109 S210 ; Wait for nozzle temp
M204 P500 ; Acceleration
G92 E0 ; Reset extruder distance
G1 X0 Y0 F7200 ; move to start
G1 Z0.2 F1200 ; Move to layer height
;
; prime nozzle
;
G1 X-49 Y-17.5 F7200 ; move to start
G1 X-49 Y17.5 E3.4923 F1800 ; print line
G1 X-48.28 Y17.5 F7200 ; move to start
G1 X-48.28 Y-17.5 E3.4923 F1800 ; print line
G1 E-1.3 F2100 ; retract
;
; print anchor frame
;
G1 X-39 Y-20.5 F7200 ; move to start
G1 E1.3 F2100 ; un-retract
G1 X-39 Y-4.5 E0.6533 F1200 ; print line
G1 X-38.52 Y-4.5 F7200 ; move to start
G1 X-38.52 Y-20.5 E0.6533 F1200 ; print line
G1 E-1.3 F2100 ; retract
G1 X41 Y-20.5 F7200 ; move to start
G1 E1.3 F2100 ; un-retract
G1 X41 Y-4.5 E0.6533 F1200 ; print line
G1 X40.52 Y-4.5 F7200 ; move to start
G1 X40.52 Y-20.5 E0.6533 F1200 ; print line
G1 E-1.3 F2100 ; retract
;
; start the Test pattern
;
G4 P2000 ; Pause (dwell) for 2 seconds
G1 X-39 Y-17.5 F7200 ; move to start
M572 D0 ; set K-factor
M117 K0 ; 
G1 E1.3 F2100 ; un-retract
G1 X-19 Y-17.5 E0.7424 F1200 ; print line
G1 X21 Y-17.5 E1.4847 F4800 ; print line
G1 X41 Y-17.5 E0.7424 F1200 ; print line
G1 E-1.3 F2100 ; retract
G1 X-39 Y-12.5 F7200 ; move to start
M572 D0.05 ; set K-factor
M117 K0.05 ; 
G1 E1.3 F2100 ; un-retract
G1 X-19 Y-12.5 E0.7424 F1200 ; print line
G1 X21 Y-12.5 E1.4847 F4800 ; print line
G1 X41 Y-12.5 E0.7424 F1200 ; print line
G1 E-1.3 F2100 ; retract
G1 X-39 Y-7.5 F7200 ; move to start
M572 D0.1 ; set K-factor
M117 K0.1 ; 
G1 E1.3 F2100 ; un-retract
G1 X-19 Y-7.5 E0.7424 F1200 ; print line
G1 X21 Y-7.5 E1.4847 F4800 ; print line
G1 X41 Y-7.5 E0.7424 F1200 ; print line
G1 E-1.3 F2100 ; retract
;
; Mark the test area for reference
M117 K0
M572 D0 ; Set K-factor 0
G1 X-19 Y-2.5 F7200 ; move to start
G1 E1.3 F2100 ; un-retract
G1 X-19 Y17.5 E0.7424 F1200 ; print line
G1 E-1.3 F2100 ; retract
G1 X21 Y-2.5 F7200 ; move to start
G1 E1.3 F2100 ; un-retract
G1 X21 Y17.5 E0.7424 F1200 ; print line
G1 E-1.3 F2100 ; retract
G1 Z0.3 F1200 ; zHop
;
; print K-values
;
G1 X43 Y-19.5 F7200 ; move to start
G1 Z0.2 F1200 ; zHop
G1 E1.3 F2100 ; un-retract
G1 X45 Y-19.5 E0.0742 F1200 ; 0
G1 X45 Y-17.5 E0.0742 F1200 ; 0
G1 X45 Y-15.5 E0.0742 F1200 ; 0
G1 X43 Y-15.5 E0.0742 F1200 ; 0
G1 X43 Y-17.5 E0.0742 F1200 ; 0
G1 X43 Y-19.5 E0.0742 F1200 ; 0
G1 E-1.3 F2100 ; retract
G1 Z0.3 F1200 ; zHop
G1 X43 Y-9.5 F7200 ; move to start
G1 Z0.2 F1200 ; zHop
G1 E1.3 F2100 ; un-retract
G1 X45 Y-9.5 E0.0742 F1200 ; 0
G1 X45 Y-7.5 E0.0742 F1200 ; 0
G1 X45 Y-5.5 E0.0742 F1200 ; 0
G1 X43 Y-5.5 E0.0742 F1200 ; 0
G1 X43 Y-7.5 E0.0742 F1200 ; 0
G1 X43 Y-9.5 E0.0742 F1200 ; 0
G1 E-1.3 F2100 ; retract
G1 X46 Y-9.5 F7200 ; move to start
G1 E1.3 F2100 ; un-retract
G1 X46 Y-9.1 E0.0148 F1200 ; dot
G1 E-1.3 F2100 ; retract
G1 X47 Y-9.5 F7200 ; move to start
G1 E1.3 F2100 ; un-retract
G1 X47 Y-7.5 E0.0742 F1200 ; 1
G1 X47 Y-5.5 E0.0742 F1200 ; 1
G1 E-1.3 F2100 ; retract
G1 Z0.3 F1200 ; zHop
;
; FINISH
;
M104 S0 ; Turn off hotend
M140 S0 ; Turn off bed
G1 Z30 X0 Y0 F7200 ; Move away from the print
M84 ; Disable motors
M501 ; Load settings from EEPROM
;