extends Node

var GlobalPositions = {
	"WorldFromHome" : Vector2(1116.419, 667.009),
	"House" : Vector2(7184.991, 500.46),
	"Bed" : Vector2(8165.339, -1013.874),
	"WorldLower" : Vector2(1093.167, 1914.927),
	"FarmlandToTownUpper" : Vector2(1173.551, 3110.885),
	"FarmlandToTownLower" : Vector2(-88.566, 3767.213),
	"CityRight" : Vector2(-908.351, 3742.47)
}

var LoadingZones = {
	"WorldFromHome" : {
		"Left" : -500.417,
		"Right" : 3500,
		"Top" : -600,
		"Bottom" : 2100.295
	},
	"WorldLower" : {
		"Left" : -500.417,
		"Right" : 3500,
		"Top" : -600,
		"Bottom" : 2100.295
	},
	"House" : {
		"Left" : 4200.259,
		"Right" : 9053,
		"Top" : -2070,
		"Bottom" : 1027.965
	},
	"FarmlandToTownUpper" : {
		"Left" : 21.467,
		"Right" : 2123.355,
		"Top" : 2989.02,
		"Bottom" : 4084.526
	},
	"FarmlandToTownLower" : {
		"Left" : 21.467,
		"Right" : 2123.355,
		"Top" : 2989.02,
		"Bottom" : 4084.526
	},
	"CityRight" : {
		"Left" : -4387.51,
		"Right" : -665.056,
		"Top" : 2977.116,
		"Bottom" : 5429.956
	}
}

func fix_home():
	GlobalPositions["WorldFromHome"] = Vector2(7652.68, 5113.39)
	GlobalPositions["WorldLower"] = Vector2(7693.196, 6243.269)
	LoadingZones["WorldFromHome"]["Left"] = 5814.751
	LoadingZones["WorldFromHome"]["Right"] = 10365.278
	LoadingZones["WorldFromHome"]["Top"] = 3647.495
	LoadingZones["WorldFromHome"]["Bottom"] = 6729.927
	LoadingZones["WorldLower"]["Left"] = 5814.751
	LoadingZones["WorldLower"]["Right"] = 10365.278
	LoadingZones["WorldLower"]["Top"] = 3647.495
	LoadingZones["WorldLower"]["Bottom"] = 6729.927
