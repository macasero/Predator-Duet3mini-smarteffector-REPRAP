; =========================================================================================================
;
; Executed before each print - BEFORE ANY SLICER CODE IS RAN
;
; =========================================================================================================
;
if {move.axes[0].workplaceOffsets[8] == 1}                             ; if filament sensor is active
    if exists(sensors.filamentMonitors[0])                             ; is the run-out mode activated?
        if {sensors.filamentMonitors[0].status != "ok"}                ; if filament is not loaded
            M300 S500 P1000                                            ; beep
            M291 R{"No Filament!"} P{"Please load filament first!"} S2
            abort "ERROR: No Filament!"
    else
        M300 S500 P1000                                                ; beep
        M291 R{"No Filament!"} P{"Please load filament first!"} S2
        abort "ERROR: No Filament!"
;
; =========================================================================================================
;
T0                                                                     ; ensure the tool is selected
;
;
M572 D0 S0.0                                                           ; clear pressure advance.
M220 S100                                                              ; set speed factor back to 100% in case it was changed
M221 S100                                                              ; set extrusion factor back to 100% in case it was changed
M290 R0 S0                                                             ; clear any baby-stepping
;
M106 P0 S0                                                             ; turn off fan 0
;
G28                                                                    ; home
M400                                                                   ; finish all moves, clear the buffer
G90                                                                    ; absolute Positioning
M83                                                                    ; extruder relative mode
;
; Slicer generated gcode takes it away from here ....
;
; =========================================================================================================
;