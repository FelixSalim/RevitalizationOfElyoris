extends Control

# Stores label and ui
@onready var dayLabel = $CenterContainer/DayLabel
@onready var timeLabel = $CenterContainer2/TimeLabel
@onready var arrow = $Arrow

func set_daytime(day, hour, minute):
	# Update text, day is added by 1 because day starts from 0
	dayLabel.text = "Day" + str(day + 1) 
	var am_pm = "am"
	var shownHour = hour
	
	# Turn the am to pm
	if hour > 12:
		am_pm = "pm"
		shownHour -= 12
	
	# Update the label
	timeLabel.text = ("%02d:%02d %s" % [shownHour, minute, am_pm])
	
	# Set the arrow rotation
	if hour <= 12:
		arrow.rotation_degrees = remap_rangef(hour, 0, 12, -90, 90)
	else:
		arrow.rotation_degrees = remap_rangef(hour, 13, 23, 90, -90)

func remap_rangef(input, minInput, maxInput, minOutput, maxOutput):
	# Return the degree value for arrow rotation
	return float(input - minInput) / float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput
