extends CharacterBody2D

# Initate a Player class
class_name Player

# Player State Handling
var interactingState
var movementState
var stateManager

# Stores last player direction
var lastDir = "down"

# Stores if player is currently is interacting
var isInteracting = false

# Stores if player is holding something
var isHolding = false
var lastIsHolding = false

#Stores if there is still dialogue from the npc
var isChatting = true
var isChoosing = false
var chattingWith

# Character Speed
var speed = 35000

# Initiates State Manager, Set Initial State to Idle, Set player camera and set animations accordingly
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
	if Input.is_action_just_pressed("open_quest"):
		open_quest()
	
	# Update Velocity
	velocity = velocity.normalized() * speed * delta

# updates on player if it is interacting
func _process(delta):
	if Game.isInteracting != self.isInteracting:
		Game.isInteracting = self.isInteracting

	# If player holding condition change then change animation
	check_idling_animation()

# Get Input and Move Player Each Frame
func _physics_process(delta: float) -> void:
	get_input(delta)
	move_and_slide()

# Check for quest progress
func check_progress(questType, target):
	if QuestData.questProgress < len(QuestData.quest):
		var questReq = QuestData.quest[QuestData.questProgress]["Requirements"]
		for quest in questReq:
			if quest["QuestType"] == questType:
				if quest["Target"] == target and quest["CurrentProgress"] < quest["MaxProgress"]:
					quest["CurrentProgress"] += 1

		# Check for player quest completion
		check_completion()

# Check if quest is completed
func check_completion():
	if QuestData.questProgress < len(QuestData.quest):
		var completed = true
		var curQuest = QuestData.quest[QuestData.questProgress]
		# Check each requirements
		for req in curQuest["Requirements"]:
			if req["CurrentProgress"] != req["MaxProgress"]:
				completed = false
				break
		
		if completed:
			Game.money += curQuest["Rewards"]
			QuestData.questProgress += 1
			self.get_node("AudioStreamPlayer").stream = load("res://Assets/Audio/quest-complete.mp3")
			self.get_node("AudioStreamPlayer").play()

# Check Idling Animation, update to current condition
func check_idling_animation():
	if lastIsHolding != isHolding and not isInteracting:
		lastIsHolding = isHolding
		if isHolding:
			if lastDir == "left":
				$AnimationPlayer.play("HoldLeft")
			elif lastDir == "right":
				$AnimationPlayer.play("HoldRight")
			elif lastDir == "down":
				$AnimationPlayer.play("HoldDown")
			elif lastDir == "up":
				$AnimationPlayer.play("HoldUp")
		else:
			if lastDir == "left":
				$AnimationPlayer.play("Idle Left")
			elif lastDir == "right":
				$AnimationPlayer.play("Idle Right")
			elif lastDir == "down":
				$AnimationPlayer.play("Idle Down")
			elif lastDir == "up":
				$AnimationPlayer.play("Idle Up")

# Open quest UI
func open_quest():
	if not self.isInteracting:
		self.change_moving_state("quest")

# Sleep, move to the next day
func sleep(forced):		
	if self.movementState.name != "notify" and not forced and not self.isInteracting:
		self.change_moving_state("notify")
		self.movementState.initialize("sleep")
		get_node("Control/UI/Notification").set_notification("Go to sleep?")
		
	# If sleep is forced
	if forced:
		self.change_moving_state("notify")
		self.movementState.initialize("sleep")
		get_node("Control/UI/Notification").set_notification("You are exhausted, you can't move anymore!")

# Money Notifier
func notify_money(moneyMade):
	self.change_moving_state("notify")
	get_node("Control/UI/Notification").set_notification("You made $" + str(moneyMade) + " yesterday")

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
	
	# Initializes the state
	interactingState.init(self, $AnimationPlayer, $InteractBoxCollision)
	
	# Save the state to global
	Game.currentInteractingState = str(stateName)
	
	# Add the state to child (display on screen)
	get_node("interactingState").add_child(interactingState, true)
		

# Read when player is not interacting, change the interacting variable
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name not in ["Walk Up", "Walk Down", "Walk Left", "Walk Right", "Idle Up", "Idle Down", "Idle Left", "Idle Right", "HoldUp", "HoldDown", "HoldRight", "HoldLeft", "HoldWalkUp", "HoldWalkDown", "HoldWalkRight", "HoldWalkLeft"] and self.movementState.name != "notify":
		isInteracting = false

# Read when player is interacting, change the interacting variable
func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name not in ["Walk Up", "Walk Down", "Walk Left", "Walk Right", "Idle Up", "Idle Down", "Idle Left", "Idle Right", "HoldUp", "HoldDown", "HoldRight", "HoldLeft", "HoldWalkUp", "HoldWalkDown", "HoldWalkRight", "HoldWalkLeft"] and self.movementState.name != "notify":
		isInteracting = true
