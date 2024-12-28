extends CanvasLayer

# Get nodes
@onready var timeInfo = $TimeInfo

# Connects daynightcycle modulate to UI and force sleep to player
func _ready():
	var world = get_node("../../../..")
	var canvas = world.get_node("CanvasModulate")
	var player = world.get_node("Player/Player")
	canvas.time_tick.connect(timeInfo.set_daytime)
	canvas.force_sleep.connect(player.sleep)
