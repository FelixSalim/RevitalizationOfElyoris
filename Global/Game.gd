extends Node

# Stores interacting state of player currently
var currentInteractingState = "None"

# Stores if player is currently interacting
var isInteracting = false

# Stores plot condition
var plot = {
	
}

# Stores time
var gameTime = 0.5 * PI

# Stores player inventory
var inventory = [-1, 0, 1, 2, -1, -1, -1, -1]

# Stores player inventory amount
var inventoryAmount = [0, 1, 1, 1, 0, 0, 0, 0]

# Stores current selected inventory
var selected = 0
