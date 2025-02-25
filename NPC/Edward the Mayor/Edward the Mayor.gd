extends Area2D

# Stores colliding objects
var collision = []

var dialogue = ['Hi Player, my name is Edward, I am the mayor of this town, I have a favor to ask you', 'My town is dying, it\'s environment withering and our villagers are sick, If you are willing, can you investigate this issue for us?', 'Hi Player, what are you up to?']
var defaultPage = 0
var page = 0
var choiceIdx = [1, 2]
var choices = [
	['Ofcourse', 'What\'s in it for me'],
	['How\'s the villager and environment in this town?', 'Goodbye']	
]
var choicesAns = [
	[
		['Thank you, our town will thank you for your generosity', 'You can start to investigate the land below our town, some villager are noticeably more sick there'], 
		['Well.. we do have some reward that is ready', 'if you want to, you can start to investigate the land below our town, some villager are noticeably more sick there']
	],
	
	[
		['It\'s still bleak, I\'m worried that things will get worse from here', 'I\'ll keep updating our condition to you, good luck in any of your journey'], 
		['Goodbye'],
	],
]

var currentChoices = 0

# Load saved dialogue
func _ready():
	self.defaultPage = int(Game.mayor['defaultPage'])
	self.page = self.defaultPage
	self.currentChoices = int(Game.mayor['currentChoice'])

# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
func _process(delta: float) -> void:
	if collision.size() > 0:
		enter()
	Game.mayor['defaultPage'] = self.defaultPage
	Game.mayor['currentChoice'] = self.currentChoices

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
	if(page < dialogue.size()):
		player.get_node("Control/UI/Dialogue").set_dialogue(dialogue[page])
		if(page in choiceIdx):
			player.isChoosing = true
			choice(choices[currentChoices], choicesAns[currentChoices])
			if(currentChoices == 0):
				currentChoices = 1
				defaultPage = 2
				page = dialogue.size()
			
		page += 1
		
		if(page >= dialogue.size() and not player.isChoosing):
			player.isChatting = false
			#player.chattingWith = null
			page = defaultPage
	else:
		player.isChatting = false
		#player.chattingWith = null
		page = defaultPage
			
		# Checks quest and add progress if available
		player.check_progress("Talk", "Edward")
			
func choice(choice, choiceAns):
	var player = get_node("../../../Environments/Player/Player")
	player.get_node("Control/UI/Choices").set_choice(choice, choiceAns)
	player.get_node("Control/UI/Choices").show()

# When a collision occurs, add the collision to the array
func _on_area_entered(area: Area2D) -> void:
	collision.append(area)

# When a collision no longer exists, remove the collision from the array
func _on_area_exited(area: Area2D) -> void:
	collision.erase(area)
