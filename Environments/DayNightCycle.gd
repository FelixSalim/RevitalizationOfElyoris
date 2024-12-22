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
		
	var value = (cos(colorTime) + 1)/2
	
	self.color = gradient.gradient.sample(value)
	# Calculate in game time with respect to real time
	recalculate_time()

func recalculate_time():
	# Total game minutes
	var totalMinutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
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
