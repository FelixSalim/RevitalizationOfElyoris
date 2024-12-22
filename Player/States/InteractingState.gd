extends Node2D

# Declare Class
class_name InteractingState

# Get the interact box of player
var interactBox

# Stores player class
var player

# Stores animations
var playerAnimation
var hitboxAnimation

# Initialize Class
func init(player, playerAnimation, hitboxAnimation):
	self.player = player
	self.playerAnimation = playerAnimation
	self.hitboxAnimation = hitboxAnimation
	self.interactBox = player.get_node("InteractBox")
