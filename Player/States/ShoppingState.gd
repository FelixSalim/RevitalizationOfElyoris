# Inherit State Class
extends MovementState

# ShoppingState Class
class_name ShoppingState

# Load shop UI
var shopUI = preload("res://UI/ShopUI.tscn")

func _ready():
	# Stop unwanted animation
	if playerAnimation.current_animation not in ["Fade Out", "Idle Down", ""]:
		playerAnimation.stop()
	
	# Player is interacting
	player.isInteracting = true
	
	# Instantiate notification
	var shop = shopUI.instantiate()
	shop.name = "ShopUI"
	player.get_node("Control/UI").add_child(shop)

# Input handling
func _input(event):
	if event.is_action_pressed("ui_cancel") and player.isInteracting:
		player.get_node("Control/UI/ShopUI").queue_free()
		player.isInteracting = false
		changeState.call("idle")

# Movement Handling, Change State to Run, calls the function stored in changeState (a.k.a change_state)
# Also makes sure that player is not interacting and free notification after change of state
func move_left():
	if not player.isInteracting:
		changeState.call("run")

func move_right():
	if not player.isInteracting:
		changeState.call("run")

func move_up():
	if not player.isInteracting:
		changeState.call("run")

func move_down():
	if not player.isInteracting:
		changeState.call("run")
