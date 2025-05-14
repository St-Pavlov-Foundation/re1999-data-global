module("modules.configs.excel2json.lua_activity104_trial", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	equipId = 8,
	firstPassEquipIds = 5,
	name = 6,
	nameEn = 7,
	episodeId = 3,
	unlockLayer = 4,
	activityId = 1,
	layer = 2
}
local var_0_2 = {
	"activityId",
	"layer"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
