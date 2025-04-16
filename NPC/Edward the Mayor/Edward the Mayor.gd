extends Area2D

# Stores colliding objects
var collision = []

var dialogue = ['Hi, my name is Edward, I am the mayor of this town', #Nyangkut disini kecuali udah sampe moving to town
				'Hi, my name is Edward, I am the mayor of this town, I have a favor to ask you', #Moving to Town
				'My town is dying, it\'s environment withering and our villagers are sick, If you are willing, can you investigate this issue for us?', #Moving to Town
				'You can try to ask Jack near the land below our town, some villagers are noticeably more sick there', #Nyangkut dari quest The Main Problem sampe Repairing the Windmill, abis itu masuk ke dialog selanjutnya
				'So the problem is that coal power plant huh, and also that broken windmill', #Addressing the Town Problem
				'Thank you so much, our villagers aren\'t sick anymore but, well our town is at a bad state. You can try asking jack again for the reparation of our town', #Addressing the Town Problem
				'You can try asking jack again for the reparation of our town', #Nyangkut, Fix the Town
				'I can\'t believe it, our town is back, thank you so much but there is just one problem now, we don\'t have enough electricity anymore, this is my final request to you, talk to jack for a new renewable energy power plant like windmill', #Electricity?
				'This is my final request to you, talk to jack for a new renewable energy power plant like windmill', #Nyangkut, electricity for elyoris
				'You truly have revitalized Elyoris, I\'m forever grateful and thankful for what you\'ve done', #Revitalization of Elyoris
				'It isn\'t much but, here is some gold for you' , #Revitalization of Elyoris
				'I don\'t think there is anymore I can ask you, enjoy Elyoris and give my thanks to your parent for raising such a wonderful child like you'
				] #Revitalization of Elyoris
var defaultPage = 0
var page = 0
var choiceIdx = [2]
var questRequired = [6, 6, 7, 12, 13, 13, 14, 15, 17, 18, 18, 19]
var choices = [
	['Ofcourse', 'What\'s in it for me'],
]
var choicesAns = [
	[
		['Thank you, our town will thank you for your generosity', 'You can try to ask Jack near the land below our town, some villagers are noticeably more sick there'], 
		['Well.. we do have some reward that is ready', 'If you want to, you can try to ask Jack near the land below our town, some villagers are noticeably more sick there']
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
		player.get_node("Control/UI/Dialogue").set_npc_name("Mayor")
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
			player.check_progress("Talk", "Edward")
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
