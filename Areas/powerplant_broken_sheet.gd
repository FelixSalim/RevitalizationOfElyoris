extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if QuestData.questProgress > 9:
		self.hide()
