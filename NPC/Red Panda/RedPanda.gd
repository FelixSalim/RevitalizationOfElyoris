extends Area2D

# Stores colliding objects
var collision = []

var dialogue = ['Are you the grandchild of the owner?', #Introduction to Elyoris
				'I\'ll be waiting for your next progress, good luck!', #Nyangkut untuk Start Planting
				'Looks like you have successfully planted a turnip! Here\'s some coin for you', #Quest Completed
				'I\'ll be waiting for your next progress, good luck!', #Nyangkut Start Harvesting
				'Is that a turnip? It\'s been so long.. Congrats! Now, I need you to plant 16 turnips, hopefully by planting a lot of crops, we can revitalize this land.', #Quest Completed
				'Now, I need you to plant 16 turnips, hopefully by planting a lot of crops, we can revitalize this land.', #Nyangkut Restore Homeland
				'You\'ve done it! Look at our farm now, it\'so green and beautiful, from the deepest of my tiny heart, thank you, you can now start to talk to the mayor in town, I think he\'s facing some issue', #Quest Completed
				'Hi, what are you up to?'
				]
var defaultPage = 0
var page = 0
var choiceIdx = [0, 7]
var questRequired = [0, 1, 2, 3, 4, 5, 6, 7]
var choices = [
	['Yes', 'No'],
	['I\'m doing just fine', 'Goodbye']	
]
var choicesAns = [
	[
		['I am so happy that you have come back, my name is Lign, I am the guardian of this land.', 'There\'s so many things that we\'ll need to do to restore Elyoris.', 'You can start by planting a turnip, here is a seed for you', 'I\'ll be waiting for your next progress, good luck!'], 
		['You must have forgotten, well anyway, my name is Lign, I am the guardian of this land.', 'There\'s so many things that we\'ll need to do to restore Elyoris.', 'You can start by planting a turnip, here is a seed for you', 'I\'ll be waiting for your next progress, good luck!']
	],
	
	[
		['Nice to hear that! I\'m forever thankful for what you did for our farm, goodluck on your future journey.'], 
		['Goodbye'],
	],
]

var currentChoices = 0

# Load saved dialogue
func _ready():
	self.defaultPage = int(Game.redPanda['defaultPage'])
	self.page = self.defaultPage
	self.currentChoices = int(Game.redPanda['currentChoice'])

# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
func _process(delta: float) -> void:
	if collision.size() > 0:
		enter()
	Game.redPanda['defaultPage'] = self.defaultPage
	Game.redPanda['currentChoice'] = self.currentChoices

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
		if QuestData.questProgress > questRequired[self.page]:
			self.page += 1
		
		player.get_node("Control/UI/Dialogue").set_dialogue(dialogue[page])
		if(page in choiceIdx):
			player.isChoosing = true
			choice(choices[currentChoices], choicesAns[currentChoices])
			if(currentChoices < len(choiceIdx) - 1):
				currentChoices += 1
				defaultPage = page + 1
				page = dialogue.size()
		elif QuestData.questProgress <= questRequired[page]:
			defaultPage = page
			page = dialogue.size()
		
		page += 1
			
		
		if(page >= dialogue.size() and not player.isChoosing):
			player.isChatting = false
			#player.chattingWith = null
			page = defaultPage
			
			# Checks quest and add progress if available
			player.check_progress("Talk", "RedPanda")
	else:
		player.isChatting = false
		#player.chattingWith = null
		page = defaultPage
		
		# Checks quest and add progress if available
		player.check_progress("Talk", "RedPanda")
		
		# for presentation purposes
		if player.get_node("Control/UI/InventoryBar").visible == false:
			player.get_node("Control/UI/InventoryBar").visible = true
			
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
