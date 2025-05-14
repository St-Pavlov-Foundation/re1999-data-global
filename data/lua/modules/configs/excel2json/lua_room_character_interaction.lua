module("modules.configs.excel2json.lua_room_character_interaction", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	buildingAudio = 10,
	variety = 3,
	rate = 5,
	dialogId = 17,
	faithDialog = 19,
	excludeDaily = 20,
	conditionStr = 22,
	buildingAnimState = 13,
	heroId = 2,
	weather = 4,
	buildingCameraIds = 11,
	behaviour = 6,
	buildingNode = 12,
	reward = 18,
	showtime = 21,
	buildingInside = 8,
	heroAnimState = 14,
	buildingId = 7,
	buildingInsideSpines = 9,
	id = 1,
	relateHeroId = 16,
	delayEnterBuilding = 15
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
