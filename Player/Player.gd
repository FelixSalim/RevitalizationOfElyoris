extends CharacterBody2D

# Initate a Player class
class_name Player

# Player State Handling
var interactingState
var movementState
var stateManager

# Character Speed
var speed = 12000

# Initiates State Manager, Set Initial State to Idle and set animations accordingly
func _ready():
	stateManager = StateManager.new()
	change_moving_state("idle")
	movementState.playerAnimation.play("Idle Down")
	movementState.hitboxAnimation.play("Interact Down")

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
	
	# Calls for interaction
	# currently prototype, later will change so that this state is enterred via equipping tools
	if Input.is_action_just_pressed("ui_equip_till_later_will_be_replaced"):
		change_interacting_state("till")
	if Input.is_action_just_pressed("ui_unequip"):
		change_interacting_state("none")
	
	# Update Velocity
	velocity = velocity.normalized() * speed * delta

# Get Input and Move Player Each Frame
func _process(delta):
	get_input(delta)
	move_and_slide()

# Movement Handling (Handled in the individual state class like RunState and IdleState)
func move_left():
	movementState.move_left()

func move_right():
	movementState.move_right()

func move_up():
	movementState.move_up()

func move_down():
	movementState.move_down()

# Handles Player Moving State Changing From Idling to Running
func change_moving_state(stateName):
	# If there is currently a state, destroy it (make sure that player state is not idle and run at the same time
	if movementState != null:
		movementState.queue_free()
	
	# Get Player Moving State and Initializes the class into object
	movementState = stateManager.get_state(stateName).new()
	
	# Initializes State Attributes
	movementState.init(Callable(self, "change_moving_state"), self, $AnimationPlayer, $InteractBoxCollision)
	
	# Name the state
	movementState.name = str(stateName)
	
	# Add the state to child (display on screen)
	get_node("movementState").add_child(movementState, true)

# Handles Player Interacting State
func change_interacting_state(stateName):
	# If player is in an interacting state, destroy that state
	if interactingState != null:
		interactingState.queue_free()
	
	# If player wants to unequip, destroy state, then back up
	if stateName == "none":
		Game.currentInteractingState = "None"
		return
		
	# Get player interacting state and initializes the class to an object
	interactingState = stateManager.get_state(stateName).new()
	
	# Name the state
	interactingState.name = str(stateName)
	
	# Attach a script to such state
	interactingState.set_script(stateManager.get_state_script(stateName))
	
	# Save the state to global
	Game.currentInteractingState = str(stateName)
	
	# Add the state to child (display on screen)
	get_node("interactingState").add_child(interactingState, true)
		
