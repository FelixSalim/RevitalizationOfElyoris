extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Every frame adjust size of panel to fit the text
# Set the text that will appear

var choiceAns = []

func set_choice(choice, choiceAns):
	get_node("Panel/Label").text = choice[0]
	get_node("Panel2/Label").text = choice[1]
	self.choiceAns = choiceAns

func _on_panel_gui_inputA(event: InputEvent) -> void:
	if(event.is_pressed()):
		get_node("../Dialogue").set_dialogue(choiceAns[0])
		get_node("../../../../Player").isChoosing = false
		self.queue_free()

func _on_panel_2_gui_inputB(event: InputEvent) -> void:
	if(event.is_pressed()):
		get_node("../Dialogue").set_dialogue(choiceAns[1])
		get_node("../../../../Player").isChoosing = false
		self.queue_free()
