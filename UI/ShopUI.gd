extends CanvasLayer

var itemsForSale = [{
	"ID" : 2,
	"Item" : ItemData.item[2],
	"Price" : 70
}]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Instantiate all items for sale
	for i in range(len(itemsForSale)):
		var slot = get_node("Item" + str(i + 1))
		var item = load(itemsForSale[i]["Item"]["Location"]).instantiate()
		item.position = Vector2(112, 77)
		slot.add_child(item)
		var price = Label.new()
		price.name = "Label"
		price.position = Vector2(25, 136)
		price.add_theme_font_size_override("font", 200)
		price.scale = Vector2(0.2, 0.2)
		slot.add_child(price)
		slot.get_node("Label").text = "Price : " + str(itemsForSale[i]["Price"])

func add_item_to_inv(itemID):
	var player = get_node("../../..")
	var found = false
	for i in range(len(Game.inventory)):
		if Game.inventory[i] == itemID:
			if Game.inventoryAmount[i] < 99:
				Game.inventoryAmount[i] += 1
				found = true
				break
	
	if found:
		return
	
	var inventoryAvailable = false
	for i in range(len(Game.inventory)):
		if Game.inventory[i] == -1:
			Game.inventoryAmount[i] = 1
			Game.inventory[i] = itemID
			player.get_node("Control/UI/InventoryBar").load_inventory()
			inventoryAvailable = true
			break
	
	if inventoryAvailable:
		return
	
	print("Ran out of space")

# Check for buying input
func _input(event):
	if event.is_action_pressed("buy_1"):
		if len(itemsForSale) >= 1 and Game.money >= itemsForSale[0]["Price"]:
			Game.money -= itemsForSale[0]["Price"]
			add_item_to_inv(itemsForSale[0]["ID"])
			print(Game.inventory, Game.inventoryAmount)
	if event.is_action_pressed("buy_2"):
		if len(itemsForSale) >= 2 and Game.money >= itemsForSale[1]["Price"]:
			Game.money -= itemsForSale[1]["Price"]
			add_item_to_inv(itemsForSale[1]["ID"])
	if event.is_action_pressed("buy_3"):
		if len(itemsForSale) >= 3 and Game.money >= itemsForSale[2]["Price"]:
			Game.money -= itemsForSale[2]["Price"]
			add_item_to_inv(itemsForSale[2]["ID"])
	if event.is_action_pressed("buy_4"):
		if len(itemsForSale) >= 4 and Game.money >= itemsForSale[3]["Price"]:
			Game.money -= itemsForSale[3]["Price"]
			add_item_to_inv(itemsForSale[3]["ID"])
	if event.is_action_pressed("buy_5"):
		if len(itemsForSale) >= 5 and Game.money >= itemsForSale[4]["Price"]:
			Game.money -= itemsForSale[4]["Price"]
			add_item_to_inv(itemsForSale[4]["ID"])
