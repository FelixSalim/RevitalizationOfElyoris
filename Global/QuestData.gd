extends Node

# Stores current quest progress
var questProgress = 0

# Stores quest list
var quest = [
	{
		"Name" : "Introduction to Elyoris",
		"Requirements" : [
			{
				"QuestDesc" : "Talk to Red Panda",
				"Target" : "RedPanda",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 50
	},
	{
		"Name" : "Start Plating",
		"Requirements" : [
			{
				"QuestDesc" : "Plant a turnip on your farmland",
				"Target" : "TurnipPlant",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Plant"
			}
		],
		"Rewards" : 50
	},
	{
		"Name" : "Start Harvesting",
		"Requirements" : [
			{
				"QuestDesc" : "Harvest a turnip",
				"Target" : "TurnipPlant",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Harvest"
			}
		],
		"Rewards" : 50
	}
]
