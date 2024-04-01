; global variables
if !exists(global.IdleCounter)
	global IdleCounter = 0                                                 ; counts idle time
if !exists(global.ExtruderTempActive_Old)
	global ExtruderTempActive_Old = 0                                      ; stores extruder temperature for idle check
if !exists(global.BedTempActive_Old)
	global BedTempActive_Old = 0                                           ; stores bed temperature for idle check
if !exists(global.OldStateStatus)
	global OldStateStatus = 0                                              ; stores the status of the printer, processing = 1
if !exists(global.purge)
	global purge = 0                                                       ; stores status to purge when autoloading
if !exists(global.zLiftDistance)
	global zLiftDistance = 0                                               ; stores distance for lifting z axis
if !exists(global.waitForExtruderTemperature)
	global waitForExtruderTemperature = false                              ; beeps when pre-heat temperature is reached
if !exists(global.waitForBedTemperature)
	global waitForBedTemperature = false                                   ; beeps when pre-heat temperature is reached
if !exists(global.AskToChange)
	global AskToChange = 1                                                 ; ask if filament should be changed?
if !exists(global.x_accel)
	global x_accel = 0                                                     ; stores x accelerations (mm/s^2)
if !exists(global.x_jerk)
	global x_jerk = 0                                                      ; stores x maximum instantaneous speed changes (mm/min)
if !exists(global.y_accel)
	global y_accel = 0                                                     ; stores y accelerations (mm/s^2)
if !exists(global.y_jerk)
	global y_jerk = 0                                                      ; maximum y instantaneous speed changes (mm/min)
if !exists(global.filamentErrorIgnore)
	global filamentErrorIgnore = 0                                         ; enable / disable execution of filament-error.g
if !exists(global.filamentTriggerIgnore)
	global filamentTriggerIgnore = 0                                       ; enable / disable execution of trigger2.g
if !exists(global.nozzleProbeTemperature)									; checks for the existence of global.nozzleProbeTemperature
	global nozzleProbeTemperature = 150	
if !exists(global.TAPPING)
  global TAPPING = false