M291 P"Probe will be tested 10 times and return mean and standard deviation. Ok or Cancel?" R"WARNING" S3 ; User must click OK or cancel.
G28
;M401 				; Enable for BLtouch
G30 P0 X151 Y161 Z-9999
G30 P1 X151 Y161 Z-9999
G30 P2 X151 Y161 Z-9999
G30 P3 X151 Y161 Z-9999
G30 P4 X151 Y161 Z-9999
G30 P5 X151 Y161 Z-9999
G30 P6 X151 Y161 Z-9999
G30 P7 X151 Y161 Z-9999
G30 P8 X151 Y161 Z-9999
G30 P9 X151 Y161 Z-9999 S-1
;M402 				; Enable for BLtouch