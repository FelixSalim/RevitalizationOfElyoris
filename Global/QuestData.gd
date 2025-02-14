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
		]
	}
]
