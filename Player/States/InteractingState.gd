extends Node2D

# Declare Class
class_name InteractingState

# Get the interact box of player
@onready var interactBox = get_parent().get_parent().get_node("InteractBox")
