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
		"Rewards" : 0
	},
	{
		"Name" : "Quest Completed",
		"Requirements" : [
			{
				"QuestDesc" : "Report back to Red Panda",
				"Target" : "RedPanda",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
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
		"Rewards" : 0
	},
	{
		"Name" : "Quest Completed",
		"Requirements" : [
			{
				"QuestDesc" : "Report back to Red Panda",
				"Target" : "RedPanda",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 50
	},
	{
		"Name" : "All Steps Together",
		"Requirements" : [
			{
				"QuestDesc" : "Plant 3 turnips",
				"Target" : "TurnipPlant",
				"MaxProgress" : 3,
				"CurrentProgress" : 0,
				"QuestType" : "Plant"
			},
			{
				"QuestDesc" : "Harvest 3 turnips",
				"Target" : "TurnipPlant",
				"MaxProgress" : 3,
				"CurrentProgress" : 0,
				"QuestType" : "Harvest"
			}
		],
		"Rewards" : 0
	},
	{
		"Name" : "Quest Completed",
		"Requirements" : [
			{
				"QuestDesc" : "Report back to Red Panda",
				"Target" : "RedPanda",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 150
	},
	{
		"Name" : "Restore Homeland!",
		"Requirements" : [
			{
				"QuestDesc" : "Plant 6 turnips",
				"Target" : "TurnipPlant",
				"MaxProgress" : 6,
				"CurrentProgress" : 0,
				"QuestType" : "Plant"
			},
			{
				"QuestDesc" : "Harvest 6 turnips",
				"Target" : "TurnipPlant",
				"MaxProgress" : 6,
				"CurrentProgress" : 0,
				"QuestType" : "Harvest"
			}
		],
		"Rewards" : 0
	},
	{
		"Name" : "Quest Completed",
		"Requirements" : [
			{
				"QuestDesc" : "Report back to Red Panda",
				"Target" : "RedPanda",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 150
	}
	
]
