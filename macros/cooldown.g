; =========================================================================================================
;
; turn off heaters and part cooling fan
;
; =========================================================================================================
;
M291 P"Turning heaters off ..." S2       ; Display new message

M104 S0      ; turn off temperature
M140 S0      ; turn off heatbed
M107         ; turn off fan
;
; =========================================================================================================