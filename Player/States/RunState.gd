# Inherit State Class
extends MovementState

# RunState class
class_name RunState

# Get Input, Detects when player stop moving, if so, change state to idle and set animation to idle
func get_input():
	if Input.is_action_just_released("ui_left"):
		changeState.call("idle")
		if player.lastDir == "left":
			playerAnimation.play("Idle Left")
	if Input.is_action_just_released("ui_right"):
		changeState.call("idle")
		if player.lastDir == "right":
			playerAnimation.play("Idle Right")
	if Input.is_action_just_released("ui_up"):
		changeState.call("idle")
		if player.lastDir == "up":
			playerAnimation.play("Idle Up")
	if Input.is_action_just_released("ui_down"):
		changeState.call("idle")
		if player.lastDir == "down":
			playerAnimation.play("Idle Down")

# Run get_input every fixed interval
func _physics_process(delta):
	get_input()

# Movement Handling, Set velocity to corresponding movement direction, also plays animation accordingly
func move_left():
	player.velocity.x -= Input.get_action_strength("ui_left")
	if Input.get_action_strength("ui_left") > Input.get_action_strength("ui_up") and Input.get_action_strength("ui_left") > Input.get_action_strength("ui_down"):
		playerAnimation.play("Walk Left")
		hitboxAnimation.play("Interact Left")
		player.lastDir = "left"

func move_right():
	player.velocity.x += Input.get_action_strength("ui_right")
	if Input.get_action_strength("ui_right") > Input.get_action_strength("ui_up") and Input.get_action_strength("ui_right") > Input.get_action_strength("ui_down"):
		playerAnimation.play("Walk Right")
		hitboxAnimation.play("Interact Right")
		player.lastDir = "right"

func move_up():
	player.velocity.y -= Input.get_action_strength("ui_up")
	if Input.get_action_strength("ui_up") > Input.get_action_strength("ui_left") and Input.get_action_strength("ui_up") > Input.get_action_strength("ui_right"):
		playerAnimation.play("Walk Up")
		hitboxAnimation.play("Interact Up")
		player.lastDir = "up"

func move_down():
	player.velocity.y += Input.get_action_strength("ui_down")
	if Input.get_action_strength("ui_down") > Input.get_action_strength("ui_left") and Input.get_action_strength("ui_down") > Input.get_action_strength("ui_right"):
		playerAnimation.play("Walk Down")
		hitboxAnimation.play("Interact Down")
		player.lastDir = "down"
