extends Node

class_name QuestDetailsManager

# Updates Quest each time opened
func _ready() -> void:
	var curQuest = QuestData.quest[QuestData.questProgress]
	get_node("Panel/QuestName").text = curQuest["Name"]
	for i in range(len(curQuest["Requirements"])):
		var control = Control.new()
		control.name = "Requirement" + str(i + 1)
		get_node("Panel/QuestRequirements").add_child(control)
		control.position = Vector2(0, 75 * i)
		
		var questDescription = Label.new()
		questDescription.name = "QuestDesc"
		questDescription.add_theme_font_size_override("font_size", 250)
		questDescription.add_theme_color_override("font_color", Color.BLACK)
		questDescription.scale = Vector2(0.2, 0.2)
		questDescription.position = Vector2(2, 101)
		questDescription.text = curQuest["Requirements"][i]["QuestDesc"]
		control.add_child(questDescription)
		
		var questProgress = Label.new()
		questProgress.name = "Progress"
		questProgress.add_theme_font_size_override("font_size", 250)
		questProgress.add_theme_color_override("font_color", Color.BLACK)
		questProgress.scale = Vector2(0.2, 0.2)
		questProgress.position = Vector2(1324, 101)
		questProgress.size = Vector2(2129, 342)
		questProgress.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		questProgress.text =  "<" + str(curQuest["Requirements"][i]["CurrentProgress"]) + "/" + str(curQuest["Requirements"][i]["MaxProgress"]) + ">"
		control.add_child(questProgress)
		
		
