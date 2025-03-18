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
		"Name" : "Start Planting",
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
		"Rewards" : 1050
	},
	#{
		#"Name" : "All Steps Together",
		#"Requirements" : [
			#{
				#"QuestDesc" : "Plant 16 turnips",
				#"Target" : "TurnipPlant",
				#"MaxProgress" : 3,
				#"CurrentProgress" : 0,
				#"QuestType" : "Plant"
			#},
			#{
				#"QuestDesc" : "Harvest 16 turnips",
				#"Target" : "TurnipPlant",
				#"MaxProgress" : 3,
				#"CurrentProgress" : 0,
				#"QuestType" : "Harvest"
			#}
		#],
		#"Rewards" : 0
	#},
	#{
		#"Name" : "Quest Completed",
		#"Requirements" : [
			#{
				#"QuestDesc" : "Report back to Red Panda",
				#"Target" : "RedPanda",
				#"MaxProgress" : 1,
				#"CurrentProgress" : 0,
				#"QuestType" : "Talk"
			#}
		#],
		#"Rewards" : 500
	#},
	{
		"Name" : "Restore Homeland!",
		"Requirements" : [
			{
				"QuestDesc" : "Plant 16 turnips",
				"Target" : "TurnipPlant",
				"MaxProgress" : 6,
				"CurrentProgress" : 0,
				"QuestType" : "Plant"
			},
			{
				"QuestDesc" : "Harvest 16 turnips",
				"Target" : "TurnipPlant",
				"MaxProgress" : 6,
				"CurrentProgress" : 0,
				"QuestType" : "Harvest"
			}
		],
		"Rewards" : 0
	},
	{
		"Name" : "Revitalized the Farmland",
		"Requirements" : [
			{
				"QuestDesc" : "Report back to Red Panda",
				"Target" : "RedPanda",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 900
	},
	{
		"Name" : "Moving to Town",
		"Requirements" : [
			{
				"QuestDesc" : "Talk to the Mayor in Town",
				"Target" : "Edward",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 150
	},
	{
		"Name" : "The Main Problem",
		"Requirements" : [
			{
				"QuestDesc" : "Talk to Jack in Town",
				"Target" : "Jack",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 0
	},
	
	#Quest Type Baru
	{
		"Name" : "Removing the Coal Powerplant",
		"Requirements" : [
			{
				"QuestDesc" : "Pay Jack to remove the powerplant",
				"Target" : "Jack",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 0
	},
	
	{
		"Name" : "Coal Plant is Gone!",
		"Requirements" : [
			{
				"QuestDesc" : "Talk to Jack",
				"Target" : "Jack",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 0
	},
	
	#Quest Type baru
	{
		"Name" : "Repairing the Windmill",
		"Requirements" : [
			{
				"QuestDesc" : "Pay Jack to repair the windmill",
				"Target" : "Jack",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 0
	},
	
	{
		"Name" : "Two Birds with One Stone",
		"Requirements" : [
			{
				"QuestDesc" : "Talk to Jack",
				"Target" : "Jack",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 0
	},
	
	{
		"Name" : "Addressing the Town Problem",
		"Requirements" : [
			{
				"QuestDesc" : "Talk to the Mayor in Town",
				"Target" : "Edward",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 150
	},
	
	{
		"Name" : "Fix the Town",
		"Requirements" : [
			{
				"QuestDesc" : "Plant 50 turnips",
				"Target" : "TurnipPlant",
				"MaxProgress" : 50,
				"CurrentProgress" : 0,
				"QuestType" : "Plant"
			},
			{
				"QuestDesc" : "Harvest 50 turnips",
				"Target" : "TurnipPlant",
				"MaxProgress" : 50,
				"CurrentProgress" : 0,
				"QuestType" : "Harvest"
			},
			#Quest Type baru?
			{
				"QuestDesc" : "Pay Jack to repair the Town",
				"Target" : "TurnipPlant",
				"MaxProgress" : 50,
				"CurrentProgress" : 0,
				"QuestType" : "Harvest"
			},
		],
		"Rewards" : 0
	},
	{
		"Name" : "Electricity?",
		"Requirements" : [
			{
				"QuestDesc" : "Report back to the Mayor",
				"Target" : "Edward",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 150
	},
	
	#Quest Type Baru
	{
		"Name" : "Electricity for Elyoris",
		"Requirements" : [
			{
				"QuestDesc" : "Pay Jack to build the windmills",
				"Target" : "Jack",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 0
	},
	
	{
		"Name" : "Electricity of Elyoris",
		"Requirements" : [
			{
				"QuestDesc" : "Talk to Jack",
				"Target" : "Jack",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 0
	},
	
	{
		"Name" : "Revitalization of Elyoris",
		"Requirements" : [
			{
				"QuestDesc" : "Report back to the Mayor",
				"Target" : "Edward",
				"MaxProgress" : 1,
				"CurrentProgress" : 0,
				"QuestType" : "Talk"
			}
		],
		"Rewards" : 2500
	},
]
