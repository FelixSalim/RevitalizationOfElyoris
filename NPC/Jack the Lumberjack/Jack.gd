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
				'I\'ve heard that the mayor wants to repair this town, I can try to repair this town but this time I need even more resources, 3000 gold to be exact', #Nyangkut, Fix the Town
				'If you need anything, I\'ll help you to the best of my ability', #Nyangkut abis quest dia di fix the town, stop kalo udah sampe quest electricity of for elyoris
				'Ah, so the mayor wants to build a sustainable energy source like windmill', #Electricity for Elyoris
				'I\'ll build it for you, but like usual, I need more resources, 5000 gold should be enough', #Nyangkut, Electricity for Elyoris
				'It\'s finally done, we have enough electricity for everyone, thank you so much for all of your help', #Electricity of Elyoris
				'Hi, what are you up to?'
				]
var defaultPage = 0
var page = 0
var choiceIdx = [1, 13]
var choices = [
	['Yeah', 'Nope'],
	['Great! How\'s your life now?', 'Goodbye']	
]
var choicesAns = [
	[
		['If you haven\'t visited the land below our town, it\'s miserable, but I think I\'ve found the source of all this problem', 'That wicked coal plant, I can remove it but I need some resources', 'Can you get me 500 gold, I\'ll remove that power plant after that.'], 
		['Huh, really? Well then, I actually still need to talk to you', 'If you haven\'t visited the land below our town, it\'s miserable, but I think I\'ve found the source of all this problem', 'That wicked coal plant, I can remove it but I need some resources', 'Can you get me 500 gold, I\'ll remove that power plant after that.']
	],
	
	[
		['I\'ve also been doing great, just a bit busy now, once again, thanks for all of your help'], 
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
		player.get_node("Control/UI/Dialogue").set_dialogue(dialogue[page])
		if(page in choiceIdx):
			player.isChoosing = true
			choice(choices[currentChoices], choicesAns[currentChoices])
			if(currentChoices == 0):
				currentChoices = 1
				defaultPage = 1
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
		player.check_progress("Talk", "RedPanda")
			
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
