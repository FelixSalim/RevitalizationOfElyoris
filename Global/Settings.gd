extends Node

var GlobalPositions = {
	"WorldFromHome" : Vector2(1116.419, 667.009),
	"House" : Vector2(7184.991, 500.46),
	"Bed" : Vector2(8165.339, -1013.874),
	"WorldLower" : Vector2(1093.167, 1914.927),
	"FarmlandToTownUpper" : Vector2(1173.551, 3110.885),
	"FarmlandToTownLower" : Vector2(-88.566, 3767.213),
	"CityRight" : Vector2(-908.351, 3742.47),
	"toGenerator" : Vector2(-2540.011, 5829.979),
	"LeaveGenerator" : Vector2(-2537, 5255)
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
	}, 
	"toGenerator" : {
		"Left" : -3211.962,
		"Right" : -1216,
		"Top" : 5676,
		"Bottom" : 7152.656
	}, 
	"LeaveGenerator" : {
		"Left" : -4387.51,
		"Right" : -665.056,
		"Top" : 2977.116,
		"Bottom" : 5429.956
	}
}

func fix_home():
	GlobalPositions["WorldFromHome"] = Vector2(7652.68, 5113.39)
	GlobalPositions["WorldLower"] = Vector2(7693.196, 6243.269)
	LoadingZones["WorldFromHome"]["Left"] = 6000.751
	LoadingZones["WorldFromHome"]["Right"] = 10000.278
	LoadingZones["WorldFromHome"]["Top"] = 3800.495
	LoadingZones["WorldFromHome"]["Bottom"] = 6329.927
	LoadingZones["WorldLower"]["Left"] = 6000.751
	LoadingZones["WorldLower"]["Right"] = 10000.278
	LoadingZones["WorldLower"]["Top"] = 3800.495
	LoadingZones["WorldLower"]["Bottom"] = 6329.927

func fix_farmland_to_town():
	GlobalPositions["FarmlandToTownUpper"] = Vector2(7686.951, 7551.2)
	GlobalPositions["FarmlandToTownLower"] = Vector2(6409.214, 8202.491)
	LoadingZones["FarmlandToTownUpper"]["Left"] = 6641.906
	LoadingZones["FarmlandToTownUpper"]["Right"] = 8644.291
	LoadingZones["FarmlandToTownUpper"]["Top"] = 7392.021
	LoadingZones["FarmlandToTownUpper"]["Bottom"] = 8517.171
	LoadingZones["FarmlandToTownLower"]["Left"] = 6641.906
	LoadingZones["FarmlandToTownLower"]["Right"] = 8644.291
	LoadingZones["FarmlandToTownLower"]["Top"] = 7392.021
	LoadingZones["FarmlandToTownLower"]["Bottom"] = 8517.171

func fix_generator_area():
	GlobalPositions["toGenerator"] = Vector2(3985.332, 10163.45)
	LoadingZones["toGenerator"]["Left"] = 2820
	LoadingZones["toGenerator"]["Right"] = 5319
	LoadingZones["toGenerator"]["Top"] = 10017
	LoadingZones["toGenerator"]["Bottom"] = 11496

func fix_town():
	GlobalPositions["CityRight"] = Vector2(5764.4, 8185.834)
	GlobalPositions["LeaveGenerator"] = Vector2(4057.503, 9618.105)
	LoadingZones["CityRight"]["Left"] = 2275.556
	LoadingZones["CityRight"]["Right"] = 5858.456
	LoadingZones["CityRight"]["Top"] = 7409.476
	LoadingZones["CityRight"]["Bottom"] = 9766.646
	LoadingZones["LeaveGenerator"]["Left"] = 2275.556
	LoadingZones["LeaveGenerator"]["Right"] = 5858.456
	LoadingZones["LeaveGenerator"]["Top"] = 7409.476
	LoadingZones["LeaveGenerator"]["Bottom"] = 9766.646
