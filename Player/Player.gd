extends CharacterBody2D

# Initate a Player class
class_name Player

# Player State Handling
var state
var stateManager

# Character Speed
var speed = 300

# Initiates State Manager, Set Initial State to Idle
func _ready():
	stateManager = StateManager.new()
	change_state("idle")

# Process User Input
func get_input():
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
	velocity = velocity.normalized() * speed

# Get Input and Move Player Each Frame
func _process(delta):
	get_input()
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

# Handles Player State Changing
func change_state(stateName):
	# If there is currently a state, destroy it
	if state != null:
		state.queue_free()
	
	# Get Player State and Initializes the class into object
	state = stateManager.get_state(stateName).new()
	
	# Initializes State Attributes
	state.init(Callable(self, "change_state"), self)
	
	# Name the state
	state.name = str(stateName)
	
	# Add the state to child (display on screen)
	add_child(state)
