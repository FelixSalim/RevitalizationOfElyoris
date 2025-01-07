extends Area2D

# Stores plant sprite
@onready var plant = $Label # Subject to change when sprite is ready

# Stores plant stage
var stage = 1

# Stores plant progress
var progress = 1

# Update sprites accordingly
func _process(delta):
	plant.text = "Stage " + str(stage)
	
	if progress == 2:
		stage = 2
	elif progress == 4:
		stage = 3
	elif progress == 5:
		stage = 4

# Advance to next stage
func next_progress():
	if self.progress < 6:
		self.progress += 1
	
