extends CanvasModulate

# Stores time passed
var time = 0.5 * PI
var colorTime = 0.08 * PI

# Load Gradient Texture
@export var gradient:GradientTexture1D

# Constants
const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

# Signal that time has ticked
signal time_tick(day, hour, minute)

# Stores last minute
var lastMinute = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Every frame add time and adjust color to time cycle
func _process(delta: float) -> void:
	time += delta / 120
	colorTime += delta / 240
	if(colorTime >= PI):
		colorTime = 0.0
	# Calculates value to time
	var value = (cos(colorTime) + 1)/2
	
	# Set color to value
	self.color = gradient.gradient.sample(value)
	# Calculate in game time with respect to real time
	recalculate_time()

# Move to beginning of next day
func next_day():
	# Current total game minutes
	var curTime = real_to_ingame_time(time)
	
	# Total day that has passed
	var day = int(curTime / MINUTES_PER_DAY)
	
	# Remaining minutes for the day
	var currentTotalMinutes = curTime % MINUTES_PER_DAY

	var missingTime
	# If 6 am has passed, move to the next day, else, move to 6 am of current day	
	if currentTotalMinutes / MINUTES_PER_HOUR >= 6:
		missingTime = MINUTES_PER_DAY - currentTotalMinutes + 6 * MINUTES_PER_HOUR
	else:
		missingTime = 6 * MINUTES_PER_HOUR - currentTotalMinutes

	# Add the missing time equivalent to real time
	time += ingame_to_real_time(missingTime)

# Convert real time to ingame time
func real_to_ingame_time(inTime):
	return int(inTime / INGAME_TO_REAL_MINUTE_DURATION)

# Convert ingame time to real time
func ingame_to_real_time(inTime):
	return inTime * INGAME_TO_REAL_MINUTE_DURATION

# Recalibrate time every frame
func recalculate_time():
	# Total game minutes
	var totalMinutes = real_to_ingame_time(time)
	
	# Total game days
	var day = int(totalMinutes / MINUTES_PER_DAY)
	
	# Total minutes passed for current day
	var currentDayMinutes = totalMinutes % MINUTES_PER_DAY
	
	# Calculate game hour
	var hour = int(currentDayMinutes / MINUTES_PER_HOUR)
	
	# Calculate game minute
	var minute = int(currentDayMinutes % MINUTES_PER_HOUR)
	
	# Emit tick signal if minute change
	if lastMinute != minute:
		lastMinute = minute
		time_tick.emit(day, hour, minute)
