module("modules.configs.excel2json.lua_activity164_story", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bgPath = 9,
	name = 5,
	needbg = 8,
	nameen = 6,
	episodeId = 2,
	id = 4,
	icon = 7,
	activityId = 1,
	order = 3
}
local var_0_2 = {
	"activityId",
	"episodeId",
	"order"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
