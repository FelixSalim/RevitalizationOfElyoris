extends CanvasLayer

# Get nodes
@onready var timeInfo = $TimeInfo

# Connects daynightcycle modulate to UI
func _ready():
	var world = get_parent().get_parent().get_parent()
	var canvas = world.get_node("CanvasModulate")
	canvas.time_tick.connect(timeInfo.set_daytime)
