module("modules.configs.excel2json.lua_activity123_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	level = 5,
	layerName = 8,
	stagePicture = 6,
	desc = 9,
	unlockEquipIndex = 10,
	layerPicture = 7,
	episodeId = 4,
	displayMark = 11,
	stage = 2,
	activityId = 1,
	layer = 3
}
local var_0_2 = {
	"activityId",
	"stage",
	"layer"
}
local var_0_3 = {
	desc = 2,
	layerName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
