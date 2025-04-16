extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Every frame adjust size of panel to fit the text
# Set the text that will appear

var choiceAns = []

var idx = 0
var choice
var hasToPay = false
var moneyReq = 0

func _input(event):
	if(event.is_action_pressed("ui_accept") and get_node("../../../../Player").isChoosing):
		playDialogue(idx)

func init(use, moneyReq):
	if use == "Pay":
		hasToPay = true
		self.moneyReq = moneyReq

func set_choice(choice, choiceAns):
	get_node("Panel/Label").text = choice[0]
	get_node("Panel2/Label").text = choice[1]
	self.choiceAns = choiceAns.map(func(x): return x.duplicate() )
	
func playDialogue(idx):
	var player = get_node("../../../../Player")
	if Game.money < moneyReq:
		choice = 1
		
	if(choice == 0):
		if hasToPay:
			hasToPay = false
			Game.money -= moneyReq
			player.get_node("AudioStreamPlayer").stream = load("res://Assets/Audio/buying.mp3")
			player.get_node("AudioStreamPlayer").play()
			player.check_progress("Rebuild", "Jack")
			player.isChoosing = false
			self.queue_free()
			player.chattingWith.next_dialogue()
		if(idx != choiceAns[0].size()):
			get_node("../Dialogue").set_dialogue(choiceAns[0].pop_front())
			self.hide()
			if(choiceAns[0].size() == 0):
				player.isChoosing = false
				self.queue_free()
				player.chattingWith.next_dialogue()
		else:
			player.isChoosing = false
			self.queue_free()
			player.chattingWith.next_dialogue()
	elif(choice == 1):
		if hasToPay:
			hasToPay = false
			player.chattingWith.defaultPage -= 1
			player.chattingWith.currentChoices -= 1
		if(idx != choiceAns[1].size()):
			get_node("../Dialogue").set_dialogue(choiceAns[1].pop_front())
			self.hide()
			if(choiceAns[1].size() == 0):
				player.isChoosing = false
				self.queue_free()
				player.chattingWith.next_dialogue()
		else:
			player.isChoosing = false
			self.queue_free()
			player.chattingWith.next_dialogue()
		
func _on_panel_gui_inputA(event: InputEvent) -> void:
	if(event.is_pressed()):
		choice = 0
		playDialogue(0)

func _on_panel_2_gui_inputB(event: InputEvent) -> void:
	if(event.is_pressed()):
		choice = 1
		playDialogue(0)
