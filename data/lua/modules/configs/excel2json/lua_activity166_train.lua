module("modules.configs.excel2json.lua_activity166_train", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	trainId = 2,
	name = 7,
	winDesc = 12,
	needStar = 4,
	strategy = 11,
	firstBonus = 6,
	level = 10,
	episodeId = 3,
	desc = 9,
	type = 5,
	activityId = 1,
	nameEn = 8
}
local var_0_2 = {
	"activityId",
	"trainId"
}
local var_0_3 = {
	strategy = 3,
	name = 1,
	winDesc = 4,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
