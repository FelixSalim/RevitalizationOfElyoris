extends CanvasModulate

# Stores time passed
var time = 0.5 * PI
var colorTime = 0.08 * PI

# Load Gradient Texture
@export var gradient:GradientTexture1D

# Constants
const DAY_PER_MONTH = 28
const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

# Signal that time has ticked
signal time_tick(day, hour, minute)

# Signal for force sleep
signal force_sleep(forced)

# Stores last minute
var lastMinute = 0

# load saved time
func _ready():
	self.time = Game.gameTime

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Every frame add time and adjust color to time cycle
# Only do so if player is not interacting
func _process(delta: float) -> void:
	if not Game.isInteracting:
		time += delta / 120
		#print(time)
		colorTime += delta / 240
		if(colorTime >= PI):
			colorTime = 0.0
		# Calculates value to time
		var value = (cos(colorTime) + 1)/2
		
		# Set color to value
		self.color = gradient.gradient.sample(value)
		
		# Calculate in game time with respect to real time
		recalculate_time(false)

# Move to beginning of next day
func next_day():
	# Current total game minutes
	var curTime = real_to_ingame_time(time)
	
	# Total day that has passed (starts from 0)
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
	colorTime = 0.08 * PI
	
	# Crops growth handler
	growth_handler()
	
	# Recalculate time again
	recalculate_time(true)
	
	# Save game
	Utils.save_game()

func growth_handler():
	# get land
	var world = get_parent()
	var lands = world.get_node("TillableLands")
	
	for land in lands.get_children():
		# if land is watered and has a seed, advance seed progress
		if land.isWatered and land.tileState == "Planted":
			land.get_child(2).next_progress()
		
		# if land is not watered and not has a seed, turn back to normal land
		if not land.isWatered and land.tileState == "Tilled":
			land.tileState = "Tillable"
		
		# if land is watered, remove the water
		if land.isWatered:
			land.isWatered = false
			
		# Keep track of plot data
		var data
		if land.tileState == "Planted":
			data = {
				"tileState" : land.tileState,
				"isWatered" : land.isWatered,
				"plant" : land.get_child(2).name,
				"plantProgress" : land.get_child(2).progress
			}
		else:
			data = {
				"tileState" : land.tileState,
				"isWatered" : land.isWatered,
				"plant" : null,
				"plantProgress" : 0
			}
		
		Game.plot[str(land.id - 1)] = data

# Convert real time to ingame time
func real_to_ingame_time(inTime):
	return int(inTime / INGAME_TO_REAL_MINUTE_DURATION)

# Convert ingame time to real time
func ingame_to_real_time(inTime):
	return inTime * INGAME_TO_REAL_MINUTE_DURATION

# Recalibrate time every frame
func recalculate_time(forced):
	# Total game minutes
	var totalMinutes = real_to_ingame_time(time)
	
	# Total game days
	var day = int(totalMinutes / MINUTES_PER_DAY)
	
	# Total month that has passed (starts from 0)
	var month = int(day / DAY_PER_MONTH)
	
	# Current day of the month
	var curDay = day % DAY_PER_MONTH
	
	# Total minutes passed for current day
	var currentDayMinutes = totalMinutes % MINUTES_PER_DAY
	
	# Calculate game hour
	var hour = int(currentDayMinutes / MINUTES_PER_HOUR)
	
	# Calculate game minute
	var minute = int(currentDayMinutes % MINUTES_PER_HOUR)
	
	# Emit tick signal if minute change
	if lastMinute != minute or forced:
		lastMinute = minute
		time_tick.emit(curDay, hour, minute)
		Game.gameTime = time
	
		# if time has reach 2 am, emit force sleep signal
		if hour == 2:
			force_sleep.emit(true)
