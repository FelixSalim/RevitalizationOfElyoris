extends Node

# Stores interacting state of player currently
var currentInteractingState = "None"

# Stores if player is currently interacting
var isInteracting = false

# Stores red panda dialogue
var redPanda = {
	"currentChoice" : 0,
	"defaultPage" : 0
}

var mayor = {
	"currentChoice" : 0,
	"defaultPage" : 0
}

# Stores plot condition
var plot = {
	
}

# Stores time
var gameTime = 0.5 * PI

# Stores player inventory
var inventory = [100, 0, 1, 2, -1, -1, -1, -1]

# Stores player inventory amount
var inventoryAmount = [2, 1, 1, 1, 0, 0, 0, 0]

# Stores current selected inventory
var selected = 0

# Stores item in shipping box
var items = []

# Stores player money
var money = 0

# Stores how many plants has been planted
var totalPlant = 50
