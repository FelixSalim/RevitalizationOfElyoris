extends Area2D

# Stores colliding objects
var collision = []

var dialogue = ['(cough, cough) Hello, I\'m busy right now', #Nyangkut sampe the main problem
				'Hi, my name is Jack, (cough, cough)I\'ve heard that you need my help', #The Main Problem
				'Can you get me 500 gold, I\'ll remove that power plant after that.', #Nyangkut, Removing the Coal Powerplant
				'The coal powerplant is gone, but now we don\'t have anymore electricity, other than that, I have a bad feeling about that broken windmill', #Coal Plant is Gone!
				'Oh, I know what we need to do, I\'ll fix that windmill for us, but I need more resources, 1000 gold to be exact', #Coal Plant is Gone!
				'I\'ll fix that windmill for us, but I need more resources, 1000 gold to be exact', #Nyangkut, repairing the windmill
				'Just look at that!, the land below us is healing, and we are no longer sick. Thank you for your help!', #Two Birds with One Stone
				'If you need anything, I\'ll help you to the best of my ability', #Nyangkut sampe fix the town
				'I\'ve heard that the mayor wants to repair this town, I can try to repair this town but this time I need even more resources, 1200 gold should be enough', #Nyangkut, Fix the Town
				'If you need anything, I\'ll help you to the best of my ability', #Nyangkut abis quest dia di fix the town, stop kalo udah sampe quest electricity of for elyoris
				'Ah, so the mayor wants to build a sustainable energy source like windmill', #Electricity for Elyoris
				'I\'ll build it for you, but like usual, I need more resources, around 2500 gold', #Nyangkut, Electricity for Elyoris
				'It\'s finally done, we have enough electricity for everyone, thank you so much for all of your help', #Electricity of Elyoris
				'Hi, what are you up to?'
				]
var defaultPage = 0
var page = 0
var choiceIdx = [1, 2, 5, 8, 11, 13]
var questRequired = [7, 8, 9, 10, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
var specialRequirements = [0, 500, 1000, 1200, 2500, 0]

var choices = [
	['Yeah', 'Nope'],
	['Sure', 'Not Yet'],
	['Sure', 'Not Yet'],
	['Sure', 'Not Yet'],
	['Sure', 'Not Yet'],
	['Great! How\'s your life now?', 'Goodbye']	
]

var choicesAns = [
	[
		['If you haven\'t visited the land below our town, it\'s miserable, but I think I\'ve found the source of all this problem', 'That wicked coal plant, I can remove it but I need some resources', 'Can you get me 500 gold, I\'ll remove that power plant after that.'], 
		['Huh, really? Well then, I actually still need to talk to you', 'If you haven\'t visited the land below our town, it\'s miserable, but I think I\'ve found the source of all this problem', 'That wicked coal plant, I can remove it but I need some resources', 'Can you get me 500 gold, I\'ll remove that power plant after that.']
	],
	
	[
		['Alright then, I\'ll work on it!'], 
		['Guess you haven\'t met the requirement yet']
	],
	
	[
		['Alright then, I\'ll work on it!'], 
		['Guess you haven\'t met the requirement yet']
	],
	
	[
		['Alright then, I\'ll work on it!'], 
		['Guess you haven\'t met the requirement yet']
	],
	
	[
		['Alright then, I\'ll work on it!'], 
		['Guess you haven\'t met the requirement yet']
	],
	
	[
		['I\'ve also been doing great, just a bit busy now, once again, thanks for all of your help'], 
		['Goodbye'],
	],
]

var currentChoices = 0

# Load saved dialogue
func _ready():
	self.defaultPage = int(Game.jack['defaultPage'])
	self.page = self.defaultPage
	self.currentChoices = int(Game.jack['currentChoice'])

# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
func _process(delta: float) -> void:
	if collision.size() > 0:
		enter()
	Game.jack['defaultPage'] = self.defaultPage
	Game.jack['currentChoice'] = self.currentChoices

func enter():
	# Stores player
	var player = get_node("../../../Environments/Player/Player")
	# If player is colliding and pressed interact, pop notification
	if player.get_node("InteractBox") in collision and Input.is_action_just_pressed("ui_accept") and player.movementState.name != "dialogue":
		player.change_moving_state("dialogue")
		player.get_node("Control/UI/Dialogue").set_npc_name("Jack")
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
			choice(choices[currentChoices], choicesAns[currentChoices], specialRequirements[currentChoices])
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
			player.check_progress("Talk", "Jack")
	else:
		player.isChatting = false
		#player.chattingWith = null
		page = defaultPage
		
		# Checks quest and add progress if available
		player.check_progress("Talk", "Jack")
			
func choice(choice, choiceAns, specialReq):
	var player = get_node("../../../Environments/Player/Player")
	player.get_node("Control/UI/Choices").set_choice(choice, choiceAns)
	if specialReq > 0:
		player.get_node("Control/UI/Choices").init("Pay", specialReq)
	player.get_node("Control/UI/Choices").show()

# When a collision occurs, add the collision to the array
func _on_area_entered(area: Area2D) -> void:
	collision.append(area)

# When a collision no longer exists, remove the collision from the array
func _on_area_exited(area: Area2D) -> void:
	collision.erase(area)
