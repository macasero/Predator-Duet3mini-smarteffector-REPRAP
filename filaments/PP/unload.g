; =========================================================================================================
;
;  Prepare to un-load PP at 254°C
;
; =========================================================================================================
;
M291 P"Prepare for filament un-loading. Please wait while the nozzle is being heated up. Press OK to continue or CANCEL to abort." R"Unloading PP at 254°C" S3
;
M291 P"Please wait while the nozzle is being heated up" R"Heating: 254°C" S1 T5 ; display message
;
G91                                                                    ; relative positioning
G1 Z5 F6000 H2                                                         ; lift z relative to current position
M568 S254 R190 A2                                                      ; set current tool temperature to 254°C
M116                                                                   ; wait for the temperatures to be reached
;
M98 P"0:/macros/03-Filament_Handling/01-Unload_Filament"               ; execute macro to unload filament
;
; =========================================================================================================
;