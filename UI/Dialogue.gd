extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Every frame adjust size of panel to fit the text
# Set the text that will appear
func set_npc_name(npcName):
	get_node("Panel2/Label").text = npcName

func set_dialogue(dialogue):
	get_node("Panel/Label").text = dialogue
