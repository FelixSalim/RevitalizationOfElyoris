extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Every frame adjust size of panel to fit the text
# Set the text that will appear
func set_choice(choiceA, choiceB):
	get_node("Panel/Label").text = choiceA
	get_node("Panel2/Label").text = choiceB
