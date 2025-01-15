# Inherit State Class
extends MovementState

# IdleState Class
class_name DialogueState

# Load the notification
var dial = preload("res://UI/Dialogue.tscn")
var choice = preload("res://UI/Choices.tscn")

# Stores notification usage

var use

# Initialize use
func initialize(use):
	self.use = use

# Instantiate the notification when it is called


func _ready():
	# Stop unwanted animation
	if playerAnimation.current_animation not in ["Fade Out", "Idle Down", ""]:
		playerAnimation.stop()
	# Player is interacting
	player.isInteracting = true
	
	# Instantiate notification
	var dialogue = dial.instantiate()
	dialogue.name = "Dialogue"
	player.get_node("Control/UI").add_child(dialogue)
	
	var choices = choice.instantiate()
	choices.name = "Choices"
	player.get_node("Control/UI").add_child(choices)

# Read user input, if player pressed confirm, hide notification, if player interact with it again, show the notification
func _input(event):
	if not player.isChoosing:
		if event.is_action_pressed("ui_accept") and player.isInteracting and not player.isChatting :
			player.get_node("Control/UI/Dialogue").queue_free()
			player.get_node("Control/UI/Choices").queue_free()
			player.isInteracting = false
			player.chattingWith = null
			
		elif event.is_action_pressed("ui_accept") and player.isInteracting and player.isChatting:
			#print(player.chattingWith.page)
			player.chattingWith.next_dialogue()
		
			
		elif event.is_action_pressed("ui_cancel") and player.isInteracting:
			player.chattingWith.page = 0
			player.chattingWith.currentChoices = 0
			player.get_node("Control/UI/Dialogue").queue_free()
			player.get_node("Control/UI/Choices").queue_free()
			player.isInteracting = false
			player.chattingWith = null
			
		elif event.is_action_pressed("ui_accept") and not player.isInteracting:
			player.change_moving_state("idle")
			

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
