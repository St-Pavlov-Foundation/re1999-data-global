module("modules.configs.excel2json.lua_odyssey_fight_element", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward = 7,
	desc = 6,
	param = 3,
	type = 2,
	enemyLevel = 9,
	title = 5,
	episodeId = 4,
	randomDrop = 8,
	id = 1
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
