module("modules.configs.excel2json.lua_assassin_quest", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 8,
	display = 10,
	unlock = 9,
	type = 7,
	picture = 4,
	title = 2,
	rewardCount = 11,
	desc = 3,
	mapId = 5,
	id = 1,
	position = 6,
	recommend = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
