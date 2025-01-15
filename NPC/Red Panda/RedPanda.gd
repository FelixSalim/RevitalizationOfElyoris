extends Area2D

# Stores colliding objects
var collision = []

var dialogue = ['Are you the grandchild of the owner?', 'Hi, I am Lign, the guardian of this land']
var page = 0

var choiceIdx = [0]
var choices = [
	['Yes', 'No']
]

var choicesAns = [
	['I am so happy that you have come back, I am Lign', 'You must have forgotten, well anyway, I am Lign']
]

var currentChoices = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
func _process(delta: float) -> void:
	if collision.size() > 0:
		enter()

func enter():
	# Stores player
	var player = get_node("../../../Environments/Player/Player")
	# If player is colliding and pressed interact, pop notification
	if player.get_node("InteractBox") in collision and Input.is_action_just_pressed("ui_accept") and player.movementState.name != "dialogue":
		player.change_moving_state("dialogue")
		player.get_node("Control/UI/Dialogue").set_npc_name("Lign")
		player.isChatting = true
		player.chattingWith = self
		next_dialogue()
			
func next_dialogue():
	var player = get_node("../../../Environments/Player/Player")
	if(page != dialogue.size()):
		player.get_node("Control/UI/Dialogue").set_dialogue(dialogue[page])
		if(page in choiceIdx):
			player.isChoosing = true
			choice(choices[currentChoices], choicesAns[currentChoices])
			currentChoices += 1
			
		page += 1
		
		if(page == dialogue.size()):
			player.isChatting = false
			#player.chattingWith = null
			page = 0
			currentChoices = 0
			
func choice(choice, choiceAns):
	var player = get_node("../../../Environments/Player/Player")
	player.get_node("Control/UI/Choices").set_choice(choice[0], choice[1])
	player.get_node("Control/UI/Choices").show()

# When a collision occurs, add the collision to the array
func _on_area_entered(area: Area2D) -> void:
	collision.append(area)

# When a collision no longer exists, remove the collision from the array
func _on_area_exited(area: Area2D) -> void:
	collision.erase(area)
