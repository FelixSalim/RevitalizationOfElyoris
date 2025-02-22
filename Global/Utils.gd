extends Node

const SAVE_PATH = "user://savegame.bin"
const SAVE_PASS = "password"
var json = JSON.new()

# Open File as Write or Read
func get_file(is_write):
	var saveGame
	var password = SAVE_PASS
	# Get password
	
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		password = OS.get_unique_id()
	
	#Open file in write mode
	if is_write: #SAVE
		saveGame = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, password)
	# Open file in read mode
	else: #LOAD
		if not FileAccess.file_exists(SAVE_PATH):
			return
		saveGame = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, password)
	return saveGame

func save_game():
	# Get save file
	var saveGame = get_file(true)
	
	# Save plot data
	var data = {
		"plot" : Game.plot,
		"inventory" : Game.inventory,
		"inventoryAmount" : Game.inventoryAmount,
		"time" : Game.gameTime,
		"redPanda" : Game.redPanda,
		"mayor" : Game.mayor,
		"money" : Game.money,
		"totalPlant" : Game.totalPlant,
		"quest" : QuestData.quest,
		"questProgress" : QuestData.questProgress
	}
	
	# Store data
	saveGame.store_line(json.stringify(data))
	
	# Close file
	saveGame.close()

func load_game():
	# Get save
	var saveGame = get_file(false)
	
	# Save not exist
	if not saveGame:
		return
	
	# Read until end of line, store to Game file
	while not saveGame.eof_reached():
		var curLine = json.parse_string(saveGame.get_line())
		if curLine:
			Game.plot = curLine["plot"]
			Game.inventory = curLine["inventory"]
			Game.inventoryAmount = curLine["inventoryAmount"]
			Game.gameTime = curLine["time"]
			Game.redPanda = curLine["redPanda"]
			Game.mayor = curLine["mayor"]
			Game.money = int(curLine["money"])
			Game.totalPlant = int(curLine["totalPlant"])
			QuestData.quest = curLine["quest"]
			QuestData.questProgress = int(curLine["questProgress"])
	# Close file
	saveGame.close()
