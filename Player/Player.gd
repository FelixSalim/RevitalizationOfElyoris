extends CharacterBody2D

# Initate a Player class
class_name Player

# Player State Handling
var state
var stateManager

# Character Speed
var speed = 10000

# Initiates State Manager, Set Initial State to Idle and set animations accordingly
func _ready():
	stateManager = StateManager.new()
	change_moving_state("idle")
	state.playerAnimation.play("Idle Down")
	state.hitboxAnimation.play("Interact Down")

# Process User Input
func get_input(delta):
	# Reset velocity
	velocity = Vector2()
	
	# Call Move Function
	if Input.is_action_pressed("ui_left"):
		move_left()
	if Input.is_action_pressed("ui_right"):
		move_right()
	if Input.is_action_pressed("ui_up"):
		move_up()
	if Input.is_action_pressed("ui_down"):
		move_down()
	
	# Update Velocity
	velocity = velocity.normalized() * speed * delta

# Get Input and Move Player Each Frame
func _process(delta):
	get_input(delta)
	move_and_slide()

# Movement Handling (Handled in the individual state class like RunState and IdleState)
func move_left():
	state.move_left()

func move_right():
	state.move_right()

func move_up():
	state.move_up()

func move_down():
	state.move_down()

# Handles Player Moving State Changing From Idling to Running
func change_moving_state(stateName):
	# If there is currently a state, destroy it (make sure that player state is not idle and run at the same time
	if state != null:
		state.queue_free()
	
	# Get Player State and Initializes the class into object
	state = stateManager.get_state(stateName).new()
	
	# Initializes State Attributes
	state.init(Callable(self, "change_moving_state"), self, $AnimationPlayer, $InteractBoxCollision)
	
	# Name the state
	state.name = str(stateName)
	
	# Add the state to child (display on screen)
	add_child(state)
